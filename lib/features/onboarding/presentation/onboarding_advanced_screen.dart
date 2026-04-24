import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/auth_service.dart';

class OnboardingAdvancedScreen extends ConsumerStatefulWidget {
  final Map<String, dynamic> basicData;

  const OnboardingAdvancedScreen({super.key, required this.basicData});

  @override
  ConsumerState<OnboardingAdvancedScreen> createState() => _OnboardingAdvancedScreenState();
}

class _OnboardingAdvancedScreenState extends ConsumerState<OnboardingAdvancedScreen> {
  final _formKey = GlobalKey<FormState>();

  String _regionPreference = 'Any';
  String _dailyBudgetTier = 'Medium';
  String _sugarPreference = 'Moderate Sugar';
  String _mealsPerDay = '3';
  
  final _allergiesController = TextEditingController();
  final _medicalConditionsController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _allergiesController.dispose();
    _medicalConditionsController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final List<String> allergiesList = _allergiesController.text
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();
          
      final List<String> medicalList = _medicalConditionsController.text
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();

      final payload = {
        ...widget.basicData,
        "region_preference": _regionPreference.toLowerCase().replaceAll(' ', '_'),
        "daily_budget_tier": _dailyBudgetTier.toLowerCase(),
        "sugar_preference": _sugarPreference.toLowerCase().replaceAll(' ', '_'),
        "meals_per_day": int.tryParse(_mealsPerDay) ?? 3,
        "allergies": allergiesList,
        "medical_conditions": medicalList
      };

      await ref.read(authServiceProvider).createUserProfile(payload);
      
      // If successful, routing state updates automatically, closing both screens and opening Dashboard
      if (mounted) {
        Navigator.of(context).pop(); // Clean up navigation stack
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving profile: $e'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? hintText,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hintText,
          prefixIcon: Icon(icon, color: Colors.deepOrange),
          filled: true,
          fillColor: Colors.grey.shade100,
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
        title: const Text('Advanced Details'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.deepOrange),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),
                const Text(
                  'Fine-Tune Your Diet',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Help us customize your meal recommendations.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade700,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),

                // Region Preference
                _buildDropdown(
                  label: 'Region Preference',
                  value: _regionPreference,
                  items: const ['Any', 'North Indian', 'South Indian', 'East Indian', 'West Indian'],
                  icon: Icons.map,
                  onChanged: (v) => setState(() => _regionPreference = v!),
                ),

                // Daily Budget Tier
                _buildDropdown(
                  label: 'Daily Budget Tier',
                  value: _dailyBudgetTier,
                  items: const ['Low', 'Medium', 'High', 'Premium'],
                  icon: Icons.attach_money,
                  onChanged: (v) => setState(() => _dailyBudgetTier = v!),
                ),

                // Sugar Preference
                _buildDropdown(
                  label: 'Sugar Preference',
                  value: _sugarPreference,
                  items: const ['Strict No Sugar', 'Moderate Sugar', 'No Restriction'],
                  icon: Icons.cookie,
                  onChanged: (v) => setState(() => _sugarPreference = v!),
                ),

                // Meals Per Day
                _buildDropdown(
                  label: 'Meals Per Day',
                  value: _mealsPerDay,
                  items: const ['2', '3', '4', '5', '6'],
                  icon: Icons.restaurant,
                  onChanged: (v) => setState(() => _mealsPerDay = v!),
                ),
                
                const SizedBox(height: 8),

                // Allergies
                _buildTextField(
                  controller: _allergiesController,
                  label: 'Allergies',
                  hintText: 'e.g., Peanuts, Dairy (comma separated)',
                  icon: Icons.warning_amber_rounded,
                ),

                // Medical Conditions
                _buildTextField(
                  controller: _medicalConditionsController,
                  label: 'Medical Conditions',
                  hintText: 'e.g., Diabetes, PCOS (comma separated)',
                  icon: Icons.medical_services,
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
                    onPressed: _isLoading ? null : _submitForm,
                    child: _isLoading
                        ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 3,
                            ),
                          )
                        : const Text(
                            'Complete Onboarding ->',
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
