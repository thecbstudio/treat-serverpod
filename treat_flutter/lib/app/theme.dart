import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Design tokens: warm paper background, cocoa ink, one persimmon accent.
abstract final class T {
  static const bg = Color(0xFFFAF6F0);
  static const bgSecondary = Color(0xFFF4EDE2);
  static const bgHover = Color(0xFFEFE6D9);
  static const card = Color(0xFFFFFFFF);

  static const ink = Color(0xFF241C17);
  static const inkSecondary = Color(0xFF6F6157);
  static const inkTertiary = Color(0xFFA4978A);
  static const inkInverse = Color(0xFFFFFAF5);

  static const border = Color(0xFFEEE4D6);
  static const borderStrong = Color(0xFFE2D8C7);

  static const accent = Color(0xFFE8532B);
  static const accentHover = Color(0xFFCF4522);
  static const accentSoft = Color(0xFFFDECE5);
  static const accentInk = Color(0xFFB63C1C);

  static const green = Color(0xFF2F8F4E);
  static const greenSoft = Color(0xFFE7F2E9);
  static const amber = Color(0xFFA06A10);
  static const amberSoft = Color(0xFFFAEDCA);
  static const gold = Color(0xFFE6A01F);
  static const goldSoft = Color(0xFFFBEECB);
  static const red = Color(0xFFCF4335);
  static const redSoft = Color(0xFFFBE8E4);

  static const radiusSm = 8.0;
  static const radiusMd = 12.0;
  static const radiusLg = 16.0;

  static const appMax = 560.0;
  static const tapMin = 44.0;

  static const cardShadow = [
    BoxShadow(color: Color(0x0A241C17), blurRadius: 2, offset: Offset(0, 1)),
    BoxShadow(color: Color(0x0F241C17), blurRadius: 16, offset: Offset(0, 6)),
  ];
}

ThemeData buildTheme() {
  final base = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: T.accent,
      primary: T.accent,
      onPrimary: T.inkInverse,
      secondary: T.ink,
      surface: T.card,
      onSurface: T.ink,
      error: T.red,
    ),
    scaffoldBackgroundColor: T.bg,
  );
  final text = GoogleFonts.nunitoTextTheme(base.textTheme).apply(
    bodyColor: T.ink,
    displayColor: T.ink,
  );
  final rounded = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(T.radiusMd),
  );

  return base.copyWith(
    textTheme: text.copyWith(
      headlineMedium: text.headlineMedium?.copyWith(
        fontWeight: FontWeight.w800,
        letterSpacing: -0.5,
      ),
      titleLarge: text.titleLarge?.copyWith(fontWeight: FontWeight.w800),
      titleMedium: text.titleMedium?.copyWith(fontWeight: FontWeight.w700),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: T.bg,
      foregroundColor: T.ink,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      titleTextStyle: text.titleLarge?.copyWith(fontWeight: FontWeight.w800),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: T.accent,
        foregroundColor: T.inkInverse,
        disabledBackgroundColor: T.bgHover,
        disabledForegroundColor: T.inkTertiary,
        minimumSize: const Size(T.tapMin, 50),
        shape: rounded,
        textStyle: text.titleMedium?.copyWith(fontWeight: FontWeight.w800),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: T.ink,
        minimumSize: const Size(T.tapMin, 50),
        side: const BorderSide(color: T.borderStrong),
        shape: rounded,
        textStyle: text.titleMedium?.copyWith(fontWeight: FontWeight.w700),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: T.accentInk,
        minimumSize: const Size(T.tapMin, T.tapMin),
        textStyle: text.labelLarge?.copyWith(fontWeight: FontWeight.w700),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: T.card,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(T.radiusMd),
        borderSide: const BorderSide(color: T.borderStrong),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(T.radiusMd),
        borderSide: const BorderSide(color: T.borderStrong),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(T.radiusMd),
        borderSide: const BorderSide(color: T.accent, width: 1.6),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(T.radiusMd),
        borderSide: const BorderSide(color: T.red),
      ),
      hintStyle: const TextStyle(color: T.inkTertiary),
    ),
    chipTheme: base.chipTheme.copyWith(
      backgroundColor: T.card,
      selectedColor: T.ink,
      side: const BorderSide(color: T.border),
      shape: const StadiumBorder(),
      labelStyle: text.labelLarge?.copyWith(fontWeight: FontWeight.w700),
      showCheckmark: false,
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: T.card,
      indicatorColor: T.accentSoft,
      surfaceTintColor: Colors.transparent,
      labelTextStyle: WidgetStatePropertyAll(
        text.labelMedium?.copyWith(fontWeight: FontWeight.w700),
      ),
      iconTheme: WidgetStateProperty.resolveWith(
        (s) => IconThemeData(
          color: s.contains(WidgetState.selected)
              ? T.accentInk
              : T.inkSecondary,
        ),
      ),
    ),
    dividerTheme: const DividerThemeData(color: T.border, space: 1),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: T.ink,
      contentTextStyle: text.bodyMedium?.copyWith(color: T.inkInverse),
      behavior: SnackBarBehavior.floating,
      shape: rounded,
    ),
  );
}
