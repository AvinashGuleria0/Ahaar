import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'onboarding_advanced_screen.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();

  String _gender = 'Male';
  String _activityLevel = 'Moderate';
  String _goal = 'Maintain';
  String _dietPreference = 'Veg';

  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    final basicData = {
      "name": _nameController.text.trim(),
      "gender": _gender.toLowerCase(),
      "age": int.tryParse(_ageController.text.trim()) ?? 25,
      "weight_kg": double.tryParse(_weightController.text.trim()) ?? 70.0,
      "target_weight_kg": double.tryParse(_weightController.text.trim()) ?? 70.0, // Temp fallback mapping until goal-based weight UI is established
      "height_cm": double.tryParse(_heightController.text.trim()) ?? 170.0,
      "activity_level": _activityLevel.toLowerCase().replaceAll(' ', '_'),
      "goal": _goal.toLowerCase().replaceAll(' ', '_'),
      "diet_preference": _dietPreference.toLowerCase(),
    };

    // Navigate smoothly to the second part of the setup
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => OnboardingAdvancedScreen(basicData: basicData),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: (value) => 
            value == null || value.isEmpty ? 'Please enter $label' : null,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.deepOrange),
          filled: true,
          fillColor: Colors.grey.shade100, // Light and clean subtle fill
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String value,
    required List<String> items,
    required IconData icon,
    required ValueChanged<String?> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.deepOrange),
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
        items: items
            .map((item) => DropdownMenuItem(value: item, child: Text(item)))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Setup Your Profile'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(
                  Icons.restaurant_menu,
                  size: 64,
                  color: Colors.deepOrange,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Welcome to Aahar!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Let\'s calibrate your personalized macronutrient targets based on your exact physiology.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade700,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),

                // Name
                _buildTextField(
                  controller: _nameController,
                  label: 'Name',
                  icon: Icons.person,
                ),

                // Age & Gender
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 4,
                      child: _buildTextField(
                        controller: _ageController,
                        label: 'Age (yrs)',
                        icon: Icons.calendar_today,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 6,
                      child: _buildDropdown(
                        label: 'Gender',
                        value: _gender,
                        items: const ['Male', 'Female', 'Other'],
                        icon: Icons.wc,
                        onChanged: (v) => setState(() => _gender = v!),
                      ),
                    ),
                  ],
                ),

                // Weight & Height
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildTextField(
                        controller: _weightController,
                        label: 'Weight (kg)',
                        icon: Icons.monitor_weight_outlined,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildTextField(
                        controller: _heightController,
                        label: 'Height (cm)',
                        icon: Icons.height,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),

                // Activity Level
                _buildDropdown(
                  label: 'Activity Level',
                  value: _activityLevel,
                  items: const [
                    'Sedentary',
                    'Light',
                    'Moderate',
                    'Active',
                    'Very Active'
                  ],
                  icon: Icons.directions_run,
                  onChanged: (v) => setState(() => _activityLevel = v!),
                ),

                // Goal
                _buildDropdown(
                  label: 'Goal',
                  value: _goal,
                  items: const ['Cut', 'Maintain', 'Bulk'],
                  icon: Icons.track_changes,
                  onChanged: (v) => setState(() => _goal = v!),
                ),

                // Diet Preference
                _buildDropdown(
                  label: 'Diet Preference',
                  value: _dietPreference,
                  items: const ['Veg', 'Non-Veg', 'Jain'],
                  icon: Icons.local_dining,
                  onChanged: (v) => setState(() => _dietPreference = v!),
                ),

                const SizedBox(height: 32),

                // Submission Button
                SizedBox(
                  height: 56,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      foregroundColor: Colors.white,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: _submitForm,
                    child: const Text(
                            'Continue Setup ->',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
