import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'bounding_box_painter.dart';

void main() {
  runApp(const MaterialApp(home: AaharPoC(), debugShowCheckedModeBanner: false));
}

class AaharPoC extends StatefulWidget {
  const AaharPoC({super.key});

  @override
  State<AaharPoC> createState() => _AaharPoCState();
}

class _AaharPoCState extends State<AaharPoC> {
  File? _image;
  List<dynamic> _dishes =[];
  bool _isLoading = false;
  int? _imageWidth;
  int? _imageHeight;

  final ImagePicker _picker = ImagePicker();

  // Change this to your laptop's IP if using a real phone!
  final String apiUrl = "http://10.252.124.14:8000/api/v1/analyze/vision";

  Future<ui.Image> _decodeImage(File file) async {
    final bytes = await file.readAsBytes();
    final codec = await ui.instantiateImageCodec(bytes);
    final frame = await codec.getNextFrame();
    return frame.image;
  }

  Future<void> _captureAndAnalyze() async {
    print("📸 Opening Image Picker...");
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1024, // Resize to prevent buffer overflow
      maxHeight: 1024,
      imageQuality: 85,
    ); 
    
    if (pickedFile == null) {
      print("❌ No image picked.");
      return;
    }

    print("🖼️ Image picked: ${pickedFile.path}");
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
      print("📡 Sending request to: $apiUrl");
      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
      request.files.add(await http.MultipartFile.fromPath('file', _image!.path));

      var response = await request.send().timeout(const Duration(seconds: 180));
      print("⬇️ Response received: ${response.statusCode}");
      
      var responseData = await response.stream.bytesToString().timeout(const Duration(seconds: 180));
      var jsonResponse = json.decode(responseData);

      setState(() {
        _dishes = jsonResponse['dishes'];
        _isLoading = false;
      });
      print("✅ Analysis complete!");
      
    } catch (e) {
      print("🔥 Network/Processing Error: $e");
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Aahar AI - Vision PoC"), backgroundColor: Colors.deepOrange),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              if (_image != null)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Stack(
                    children:[
                      // The actual image
                      Image.file(_image!, fit: BoxFit.contain),
                      
                      // The AI Bounding Box Overlay
                      if (_dishes.isNotEmpty)
                        Positioned.fill(
                          child: CustomPaint(
                            painter: BoundingBoxPainter(
                              _dishes,
                              imageWidth: _imageWidth,
                              imageHeight: _imageHeight,
                            ),
                          ),
                        ),
                    ],
                  ),
                )
              else
                const Text("No image selected. Take a picture of a Thali!"),
              
              const SizedBox(height: 20),
              
              if (_isLoading)
                const CircularProgressIndicator()
              else
                ElevatedButton.icon(
                  onPressed: _captureAndAnalyze,
                  icon: const Icon(Icons.camera_alt),
                  label: const Text("Scan Food"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}