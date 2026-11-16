import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const seed = Color(0xFF1A56DB); // deep blue
  static const accent = Color(0xFF0EA5A4);

  static ThemeData light() {
    final base = ThemeData(useMaterial3: true, colorSchemeSeed: seed, brightness: Brightness.light);
    final text = GoogleFonts.interTextTheme(base.textTheme);
    return base.copyWith(
      textTheme: text,
      scaffoldBackgroundColor: const Color(0xFFF7F8FA),
      appBarTheme: AppBarTheme(backgroundColor: Colors.white, foregroundColor: Colors.black87, elevation: 0, titleTextStyle: text.titleLarge?.copyWith(fontWeight: FontWeight.w700, color: Colors.black87)),
      cardTheme: CardThemeData(color: Colors.white, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
      inputDecorationTheme: InputDecorationTheme(
        filled: true, fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFE5E7EB))),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFE5E7EB))),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: seed, width: 1.4)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      chipTheme: base.chipTheme.copyWith(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24))),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(type: BottomNavigationBarType.fixed, selectedItemColor: seed, unselectedItemColor: Colors.grey),
    );
  }

  static ThemeData dark() {
    final base = ThemeData(useMaterial3: true, colorSchemeSeed: seed, brightness: Brightness.dark);
    final text = GoogleFonts.interTextTheme(base.textTheme);
    return base.copyWith(
      textTheme: text,
      scaffoldBackgroundColor: const Color(0xFF0F1115),
      appBarTheme: AppBarTheme(backgroundColor: const Color(0xFF161A22), elevation: 0, titleTextStyle: text.titleLarge?.copyWith(fontWeight: FontWeight.w700, color: Colors.white)),
      cardTheme: CardThemeData(color: const Color(0xFF161A22), elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
      inputDecorationTheme: InputDecorationTheme(
        filled: true, fillColor: const Color(0xFF161A22),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFF2A2F3A))),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFF2A2F3A))),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: seed, width: 1.4)),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(type: BottomNavigationBarType.fixed, backgroundColor: Color(0xFF161A22), selectedItemColor: Color(0xFF6EA8FE)),
    );
  }
}
