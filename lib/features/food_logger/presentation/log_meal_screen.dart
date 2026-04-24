import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../../bounding_box_painter.dart';
import '../domain/meal_draft_notifier.dart';
import 'meal_confirmation_sheet.dart';

class LogMealScreen extends ConsumerStatefulWidget {
  const LogMealScreen({super.key});

  @override
  ConsumerState<LogMealScreen> createState() => _LogMealScreenState();
}

class _LogMealScreenState extends ConsumerState<LogMealScreen> {
  File? _image;
  List<dynamic> _dishes = [];
  bool _isLoading = false;
  int? _imageWidth;
  int? _imageHeight;

  final ImagePicker _picker = ImagePicker();
  
  // Connect cleanly to either a real device IP or fallback
  final String apiUrl = const String.fromEnvironment('API_URL', defaultValue: 'http://127.0.0.1:8000');
  
  final TextEditingController _textController = TextEditingController();
  final stt.SpeechToText _speechToText = stt.SpeechToText();
  bool _isListening = false;

  Future<ui.Image> _decodeImage(File file) async {
    final bytes = await file.readAsBytes();
    final codec = await ui.instantiateImageCodec(bytes);
    final frame = await codec.getNextFrame();
    return frame.image;
  }

  Future<void> _captureAndAnalyze() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1024,
      maxHeight: 1024,
      imageQuality: 85,
    ); 
    
    if (pickedFile == null) return;

    final selectedFile = File(pickedFile.path);
    final decoded = await _decodeImage(selectedFile);

    setState(() {
      _image = selectedFile;
      _imageWidth = decoded.width;
      _imageHeight = decoded.height;
      _dishes = [];
      _isLoading = true;
    });

    try {
      final String endpoint = "$apiUrl/api/v1/analyze/vision";
      var request = http.MultipartRequest('POST', Uri.parse(endpoint));
      request.files.add(await http.MultipartFile.fromPath('file', _image!.path));                                                                           
      var response = await request.send().timeout(const Duration(seconds: 180));                                                                                  
      var responseData = await response.stream.bytesToString().timeout(const Duration(seconds: 180));                                                             
      var jsonResponse = json.decode(responseData);

      setState(() {
        _dishes = jsonResponse['dishes'] ?? [];
        _isLoading = false;
      });

      _openConfirmationSheet(jsonResponse);
      
    } catch (e) {
      _handleError(e);
    }
  }

  Future<void> _analyzeText(String textLog) async {
    if (textLog.trim().isEmpty) return;
    
    setState(() => _isLoading = true);

    try {
      final String endpoint = "$apiUrl/api/v1/analyze/text";
      final response = await http.post(
        Uri.parse(endpoint),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({"text": textLog}),
      ).timeout(const Duration(seconds: 180));

      final jsonResponse = json.decode(response.body);

      setState(() {
        _image = null; 
        _dishes = jsonResponse['dishes'] ?? [];
        _isLoading = false;
        _textController.clear();
      });

      _openConfirmationSheet(jsonResponse);

    } catch (e) {
      _handleError(e);
    }
  }

  void _openConfirmationSheet(Map<String, dynamic> jsonResponse) {
    ref.read(mealDraftProvider.notifier).initializeFromAI(jsonResponse);
    if (!mounted) return;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.85,
          child: const MealConfirmationSheet(),
        );
      },
    );
  }

  void _handleError(dynamic e) {
    if (!mounted) return;
    setState(() => _isLoading = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error: $e"), backgroundColor: Colors.red),
    );
  }

  void _startListening() async {
    bool available = await _speechToText.initialize(
      onStatus: (status) => setState(() => _isListening = status == 'listening'),
      onError: (error) => debugPrint("Speech Error: $error"),
    );

    if (available) {
      setState(() => _isListening = true);
      _speechToText.listen(
        onResult: (result) {
          setState(() {
            _textController.text = result.recognizedWords;
          });
        },
      );
    }
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() => _isListening = false);
  }
  
  Future<void> _fetchBarcodeData(String barcode) async {
    setState(() => _isLoading = true);
    try {
      final url = 'https://world.openfoodfacts.org/api/v0/product/$barcode.json';
      final response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 15));
      final jsonResponse = json.decode(response.body);

      if (jsonResponse['status'] == 1) {
        final product = jsonResponse['product'];
        final productName = product['product_name'] ?? 'Unknown Product';
        final nutriments = product['nutriments'] ?? {};

        final energy = (nutriments['energy-kcal_100g'] ?? nutriments['energy-kcal'] ?? 0);
        final proteins = (nutriments['proteins_100g'] ?? nutriments['proteins'] ?? 0);
        final carbs = (nutriments['carbohydrates_100g'] ?? nutriments['carbohydrates'] ?? 0);
        final fat = (nutriments['fat_100g'] ?? nutriments['fat'] ?? 0);

        final mockAiResponse = {
          "dishes": [
            {
              "name": productName,
              "bounding_box": [0, 0, 0, 0],
              "ingredients": [
                {
                  "name": productName,
                  "quantity": 100,
                  "unit": "g",
                  "calories": (energy is num) ? energy.toDouble() : double.tryParse(energy.toString()) ?? 0.0,
                  "protein": (proteins is num) ? proteins.toDouble() : double.tryParse(proteins.toString()) ?? 0.0,
                  "carbs": (carbs is num) ? carbs.toDouble() : double.tryParse(carbs.toString()) ?? 0.0,
                  "fat": (fat is num) ? fat.toDouble() : double.tryParse(fat.toString()) ?? 0.0,
                }
              ]
            }
          ]
        };

        setState(() {
          _isLoading = false;
          _image = null;
          _dishes = mockAiResponse['dishes'] as List<dynamic>;
          _textController.text = "Scanned: $productName";
        });

        _openConfirmationSheet(mockAiResponse);
      } else {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Product not found in OpenFoodFacts database."), backgroundColor: Colors.red),
        );
      }
    } catch (e) {
      _handleError(e);
    }
  }

  void _openBarcodeScanner() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ScannerScreen(onDetect: (barcode) {
          Navigator.pop(context);
          _fetchBarcodeData(barcode);
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Log a Meal', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), 
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (_image != null)
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Stack(
                            children: [
                              Image.file(_image!, fit: BoxFit.contain),
                              if (_dishes.isNotEmpty)
                                Positioned.fill(
                                  child: CustomPaint(
                                    painter: BoundingBoxPainter(
                                      _dishes,
                                      imageOriginalWidth: _imageWidth?.toDouble() ?? 1000.0,
                                      imageOriginalHeight: _imageHeight?.toDouble() ?? 1000.0,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        )
                      else if (!_isLoading)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40.0),
                          child: Text(
                            "Type what you ate, use the microphone, scan a barcode, or pick an image.",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                          ),
                        ),
                      
                      const SizedBox(height: 24),
                      
                      if (_isLoading)
                        const CircularProgressIndicator(color: Colors.deepOrange)
                      else
                        ElevatedButton.icon(
                          onPressed: _captureAndAnalyze,
                          icon: const Icon(Icons.camera_alt),
                          label: const Text("Scan Food Plate Image"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepOrange,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            
            // Bottom Input Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    offset: const Offset(0, -4),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.qr_code_scanner, color: Colors.deepOrange),
                    onPressed: _openBarcodeScanner,
                    tooltip: "Scan Barcode",
                  ),
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        hintText: "E.g., I ate 2 rotis and dal",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      onSubmitted: _analyzeText,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      _isListening ? Icons.mic_off : Icons.mic,
                      color: _isListening ? Colors.red : Colors.deepOrange,
                    ),
                    onPressed: _isListening ? _stopListening : _startListening,
                    tooltip: "Voice Log",
                  ),
                  IconButton(
                    icon: const Icon(Icons.send, color: Colors.deepOrange),
                    onPressed: () => _analyzeText(_textController.text),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ScannerScreen extends StatelessWidget {
  final Function(String) onDetect;

  const ScannerScreen({super.key, required this.onDetect});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan Barcode')),
      body: MobileScanner(
        onDetect: (capture) {
          final List<Barcode> barcodes = capture.barcodes;
          if (barcodes.isNotEmpty && barcodes.first.rawValue != null) {
            onDetect(barcodes.first.rawValue!);
          }
        },
      ),
    );
  }
}
