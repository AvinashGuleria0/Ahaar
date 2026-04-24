import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class MacroColors extends ThemeExtension<MacroColors> {
  final Color protein;
  final Color carbs;
  final Color fats;
  final Color calories;

  const MacroColors({
    required this.protein,
    required this.carbs,
    required this.fats,
    required this.calories,
  });

  @override
  ThemeExtension<MacroColors> copyWith({
    Color? protein,
    Color? carbs,
    Color? fats,
    Color? calories,
  }) {
    return MacroColors(
      protein: protein ?? this.protein,
      carbs: carbs ?? this.carbs,
      fats: fats ?? this.fats,
      calories: calories ?? this.calories,
    );
  }

  @override
  ThemeExtension<MacroColors> lerp(
    covariant ThemeExtension<MacroColors>? other,
    double t,
  ) {
    if (other is! MacroColors) return this;
    return MacroColors(
      protein: Color.lerp(protein, other.protein, t)!,
      carbs: Color.lerp(carbs, other.carbs, t)!,
      fats: Color.lerp(fats, other.fats, t)!,
      calories: Color.lerp(calories, other.calories, t)!,
    );
  }
}

class AppTheme {
  // Brand colors
  static const Color _primaryLight = Colors.deepOrange;
  static const Color _primaryDark = Colors.deepOrangeAccent;

  // Backgrounds
  static const Color _scaffoldLight = Color(0xFFF8F9FA); // Premium Apple-like Light
  static const Color _scaffoldDark = Color(0xFF121212); // Standard Dark Mode background

  // Macro colors
  static const MacroColors _macroColorsLight = MacroColors(
    protein: Colors.redAccent,
    carbs: Colors.blueAccent,
    fats: Colors.amber,
    calories: Colors.teal,
  );

  static const MacroColors _macroColorsDark = MacroColors(
    protein: Color(0xFFFF8A80), // lighter RedAccent
    carbs: Color(0xFF82B1FF), // lighter BlueAccent
    fats: Color(0xFFFFD740), // lighter Amber
    calories: Color(0xFF64FFDA), // lighter Teal
  );

  // Typography - using Commissioner requested by the user
  static TextTheme _buildTextTheme(Brightness brightness) {
    var baseTheme = brightness == Brightness.light ? ThemeData.light().textTheme : ThemeData.dark().textTheme;
    return GoogleFonts.commissionerTextTheme(baseTheme);
  }

  // --- Light Theme ---
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorSchemeSeed: _primaryLight,
      scaffoldBackgroundColor: _scaffoldLight,
      textTheme: _buildTextTheme(Brightness.light),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0, // Keeps it clean when scrolling
        systemOverlayStyle: SystemUiOverlayStyle.dark, // Dark icons on light bg
        iconTheme: IconThemeData(color: Colors.black87),
        titleTextStyle: TextStyle(color: Colors.black87, fontSize: 20, fontWeight: FontWeight.w600),
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 2, // Soft shadow for a premium feel
        shadowColor: Colors.black.withValues(alpha: 0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      extensions: const <ThemeExtension<dynamic>>[
        _macroColorsLight,
      ],
    );
  }

  // --- Dark Theme ---
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorSchemeSeed: _primaryDark,
      scaffoldBackgroundColor: _scaffoldDark,
      textTheme: _buildTextTheme(Brightness.dark),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light, // Light icons on dark bg
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
      ),
      cardTheme: CardThemeData(
        color: const Color(0xFF1E1E1E), // Slightly lighter than scaffold
        elevation: 2,
        shadowColor: Colors.black.withValues(alpha: 0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      extensions: const <ThemeExtension<dynamic>>[
        _macroColorsDark,
      ],
    );
  }
}
