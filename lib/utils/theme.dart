import 'package:flutter/material.dart';

class AppTheme {
  // Modern Material Design 3 color palette
  static const Color primaryColor = Color(0xFF6750A4); // Purple 80
  static const Color onPrimaryColor = Color(0xFFFFFFFF);
  static const Color primaryContainerColor = Color(0xFFEADDFF); // Purple 90
  static const Color onPrimaryContainerColor = Color(0xFF21005D); // Purple 10
  
  static const Color secondaryColor = Color(0xFF625B71); // Purple grey 80
  static const Color onSecondaryColor = Color(0xFFFFFFFF);
  static const Color secondaryContainerColor = Color(0xFFE8DEF8); // Purple grey 90
  static const Color onSecondaryContainerColor = Color(0xFF1D192B); // Purple grey 10
  
  static const Color tertiaryColor = Color(0xFF7D5260); // Brown 80
  static const Color onTertiaryColor = Color(0xFFFFFFFF);
  static const Color tertiaryContainerColor = Color(0xFFFFD8E4); // Brown 90
  static const Color onTertiaryContainerColor = Color(0xFF31111D); // Brown 10
  
  static const Color errorColor = Color(0xFFBA1A1A); // Red 80
  static const Color onErrorColor = Color(0xFFFFFFFF);
  static const Color errorContainerColor = Color(0xFFFFDAD6); // Red 90
  static const Color onErrorContainerColor = Color(0xFF410002); // Red 10
  
  static const Color surfaceColor = Color(0xFFFFFBFE); // Surface
  static const Color onSurfaceColor = Color(0xFF1C1B1F); // On surface
  static const Color surfaceVariantColor = Color(0xFFE7E0EC); // Surface variant
  static const Color onSurfaceVariantColor = Color(0xFF49454F); // On surface variant
  
  static const Color outlineColor = Color(0xFF79747E); // Outline
  static const Color outlineVariantColor = Color(0xFFCAC4D0); // Outline variant
  
  static const Color backgroundColor = Color(0xFFFFFBFE); // Background
  static const Color onBackgroundColor = Color(0xFF1C1B1F); // On background
  
  static const Color inverseSurfaceColor = Color(0xFF313033); // Inverse surface
  static const Color onInverseSurfaceColor = Color(0xFFF4EFF4); // On inverse surface
  
  static const Color shadowColor = Color(0xFF000000);
  static const Color scrimColor = Color(0xFF000000);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: primaryColor,
        onPrimary: onPrimaryColor,
        primaryContainer: primaryContainerColor,
        onPrimaryContainer: onPrimaryContainerColor,
        secondary: secondaryColor,
        onSecondary: onSecondaryColor,
        secondaryContainer: secondaryContainerColor,
        onSecondaryContainer: onSecondaryContainerColor,
        tertiary: tertiaryColor,
        onTertiary: onTertiaryColor,
        tertiaryContainer: tertiaryContainerColor,
        onTertiaryContainer: onTertiaryContainerColor,
        error: errorColor,
        onError: onErrorColor,
        errorContainer: errorContainerColor,
        onErrorContainer: onErrorContainerColor,
        surface: surfaceColor,
        onSurface: onSurfaceColor,
        surfaceVariant: surfaceVariantColor,
        onSurfaceVariant: onSurfaceVariantColor,
        outline: outlineColor,
        outlineVariant: outlineVariantColor,
        background: backgroundColor,
        onBackground: onBackgroundColor,
        inverseSurface: inverseSurfaceColor,
        onInverseSurface: onInverseSurfaceColor,
        shadow: shadowColor,
        scrim: scrimColor,
      ),
      scaffoldBackgroundColor: backgroundColor,
      
      // App Bar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: onSurfaceColor,
        elevation: 0,
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: onSurfaceColor,
          letterSpacing: 0.1,
        ),
      ),
      
      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: onPrimaryColor,
          elevation: 2,
          shadowColor: primaryColor.withOpacity(0.3),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.1,
          ),
        ),
      ),
      
      // Outlined Button Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryColor,
          side: const BorderSide(color: primaryColor, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.1,
          ),
        ),
      ),
      
      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.1,
          ),
        ),
      ),
      
      // Card Theme
      cardTheme: CardThemeData(
        elevation: 2,
        shadowColor: shadowColor.withOpacity(0.1),
        color: surfaceColor,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      ),
      
      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceVariantColor.withOpacity(0.3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: primaryColor, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: outlineVariantColor, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: errorColor, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: errorColor, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        hintStyle: TextStyle(
          color: onSurfaceVariantColor.withOpacity(0.7),
          fontSize: 16,
        ),
        labelStyle: const TextStyle(
          color: onSurfaceVariantColor,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        floatingLabelStyle: const TextStyle(
          color: primaryColor,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      
      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: surfaceColor,
        selectedItemColor: primaryColor,
        unselectedItemColor: onSurfaceVariantColor,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        selectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
      
      // Floating Action Button Theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
        foregroundColor: onPrimaryColor,
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
      
      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: surfaceVariantColor.withOpacity(0.5),
        selectedColor: primaryContainerColor,
        disabledColor: surfaceVariantColor.withOpacity(0.3),
        labelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      
      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: outlineVariantColor,
        thickness: 1,
        space: 1,
      ),
      
      // Typography
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 57,
          fontWeight: FontWeight.w400,
          letterSpacing: -0.25,
          color: onSurfaceColor,
        ),
        displayMedium: TextStyle(
          fontSize: 45,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          color: onSurfaceColor,
        ),
        displaySmall: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          color: onSurfaceColor,
        ),
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          color: onSurfaceColor,
        ),
        headlineMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          color: onSurfaceColor,
        ),
        headlineSmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          color: onSurfaceColor,
        ),
        titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w500,
          letterSpacing: 0,
          color: onSurfaceColor,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
          color: onSurfaceColor,
        ),
        titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          color: onSurfaceColor,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5,
          color: onSurfaceColor,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
          color: onSurfaceColor,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.4,
          color: onSurfaceVariantColor,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          color: onSurfaceColor,
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          color: onSurfaceColor,
        ),
        labelSmall: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          color: onSurfaceColor,
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: Color(0xFFD0BCFF), // Purple 80
        onPrimary: Color(0xFF381E72), // Purple 20
        primaryContainer: Color(0xFF4F378B), // Purple 30
        onPrimaryContainer: Color(0xFFEADDFF), // Purple 90
        secondary: Color(0xFFCCC2DC), // Purple grey 80
        onSecondary: Color(0xFF332D41), // Purple grey 20
        secondaryContainer: Color(0xFF4A4458), // Purple grey 30
        onSecondaryContainer: Color(0xFFE8DEF8), // Purple grey 90
        tertiary: Color(0xFFEFB8C8), // Brown 80
        onTertiary: Color(0xFF492532), // Brown 20
        tertiaryContainer: Color(0xFF633B48), // Brown 30
        onTertiaryContainer: Color(0xFFFFD8E4), // Brown 90
        error: Color(0xFFFFB4AB), // Red 80
        onError: Color(0xFF690005), // Red 20
        errorContainer: Color(0xFF93000A), // Red 30
        onErrorContainer: Color(0xFFFFDAD6), // Red 90
        surface: Color(0xFF141218), // Surface
        onSurface: Color(0xFFE6E1E5), // On surface
        surfaceVariant: Color(0xFF49454F), // Surface variant
        onSurfaceVariant: Color(0xFFCAC4D0), // On surface variant
        outline: Color(0xFF938F99), // Outline
        outlineVariant: Color(0xFF49454F), // Outline variant
        background: Color(0xFF141218), // Background
        onBackground: Color(0xFFE6E1E5), // On background
        inverseSurface: Color(0xFFE6E1E5), // Inverse surface
        onInverseSurface: Color(0xFF313033), // On inverse surface
        shadow: Color(0xFF000000), // Shadow
        scrim: Color(0xFF000000), // Scrim
      ),
      scaffoldBackgroundColor: const Color(0xFF141218),
      
      // App Bar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: Color(0xFFE6E1E5),
        elevation: 0,
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: Color(0xFFE6E1E5),
          letterSpacing: 0.1,
        ),
      ),
      
      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFD0BCFF),
          foregroundColor: const Color(0xFF381E72),
          elevation: 2,
          shadowColor: const Color(0xFFD0BCFF).withOpacity(0.3),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.1,
          ),
        ),
      ),
      
      // Outlined Button Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFFD0BCFF),
          side: const BorderSide(color: Color(0xFFD0BCFF), width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.1,
          ),
        ),
      ),
      
      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: const Color(0xFFD0BCFF),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.1,
          ),
        ),
      ),
      
      // Card Theme
      cardTheme: CardThemeData(
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.3),
        color: const Color(0xFF1C1B1F),
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      ),
      
      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF49454F).withOpacity(0.3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFD0BCFF), width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFF49454F), width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFFFB4AB), width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFFFB4AB), width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        hintStyle: const TextStyle(
          color: Color(0xFFCAC4D0),
          fontSize: 16,
        ),
        labelStyle: const TextStyle(
          color: Color(0xFFCAC4D0),
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        floatingLabelStyle: const TextStyle(
          color: Color(0xFFD0BCFF),
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      
      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF1C1B1F),
        selectedItemColor: Color(0xFFD0BCFF),
        unselectedItemColor: Color(0xFFCAC4D0),
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        selectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
      
      // Floating Action Button Theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xFFD0BCFF),
        foregroundColor: Color(0xFF381E72),
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
      
      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: const Color(0xFF49454F).withOpacity(0.5),
        selectedColor: const Color(0xFF4F378B),
        disabledColor: const Color(0xFF49454F).withOpacity(0.3),
        labelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      
      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: Color(0xFF49454F),
        thickness: 1,
        space: 1,
      ),
    );
  }
} 