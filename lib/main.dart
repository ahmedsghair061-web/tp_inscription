import 'package:flutter/material.dart';

import 'screens/step_one_screen.dart';

void main() => runApp(const InscriptionApp());

class InscriptionApp extends StatelessWidget {
  const InscriptionApp({super.key});

  static const Color primary = Color(0xFF00A8CC);
  static const Color error = Color(0xFFD32F2F);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color fieldBackground = Color(0xFFF2F7F9);

  static OutlineInputBorder _border(Color color, [double width = 1]) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: color, width: width),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = ColorScheme.fromSeed(seedColor: primary).copyWith(
      primary: primary,
      error: error,
      surface: surface,
    );

    final theme = ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      fontFamily: 'Roboto',
      scaffoldBackgroundColor: surface,
      appBarTheme: const AppBarTheme(
        backgroundColor: surface,
        foregroundColor: Colors.black87,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleTextStyle: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: fieldBackground,
        labelStyle: const TextStyle(fontSize: 14),
        helperStyle: const TextStyle(fontSize: 12),
        errorStyle: const TextStyle(fontSize: 12, color: error),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: _border(Colors.transparent),
        enabledBorder: _border(Colors.transparent),
        focusedBorder: _border(primary, 2),
        errorBorder: _border(error),
        focusedErrorBorder: _border(error, 2),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
      ),
    );

    return MaterialApp(
      title: 'Inscription',
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: const StepOneScreen(),
    );
  }
}
