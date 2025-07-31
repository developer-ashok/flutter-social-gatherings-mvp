import 'package:flutter/material.dart';

class AppTheme {
  // Modern Social App Color Palette (inspired by the new design)
  static const Color primaryColor = Color(0xFF4CAF50); // Light green
  static const Color onPrimaryColor = Color(0xFFFFFFFF);
  static const Color primaryContainerColor = Color(0xFFE8F5E8); // Very light green
  static const Color onPrimaryContainerColor = Color(0xFF1B5E20); // Dark green
  
  static const Color secondaryColor = Color(0xFF2196F3); // Light blue
  static const Color onSecondaryColor = Color(0xFFFFFFFF);
  static const Color secondaryContainerColor = Color(0xFFE3F2FD); // Very light blue
  static const Color onSecondaryContainerColor = Color(0xFF0D47A1); // Dark blue
  
  static const Color accentColor = Color(0xFFE91E63); // Pink
  static const Color onAccentColor = Color(0xFFFFFFFF);
  static const Color accentContainerColor = Color(0xFFFCE4EC); // Very light pink
  static const Color onAccentContainerColor = Color(0xFF880E4F); // Dark pink
  
  static const Color tertiaryColor = Color(0xFF9C27B0); // Purple
  static const Color onTertiaryColor = Color(0xFFFFFFFF);
  static const Color tertiaryContainerColor = Color(0xFFF3E5F5); // Very light purple
  static const Color onTertiaryContainerColor = Color(0xFF4A148C); // Dark purple
  
  static const Color errorColor = Color(0xFFF44336); // Red
  static const Color onErrorColor = Color(0xFFFFFFFF);
  static const Color errorContainerColor = Color(0xFFFFEBEE); // Very light red
  static const Color onErrorContainerColor = Color(0xFFB71C1C); // Dark red
  
  static const Color successColor = Color(0xFF4CAF50); // Green
  static const Color onSuccessColor = Color(0xFFFFFFFF);
  static const Color successContainerColor = Color(0xFFE8F5E8); // Very light green
  static const Color onSuccessContainerColor = Color(0xFF1B5E20); // Dark green
  
  static const Color surfaceColor = Color(0xFFFFFFFF); // White
  static const Color onSurfaceColor = Color(0xFF212121); // Dark gray
  static const Color surfaceVariantColor = Color(0xFFF8F9FA); // Very light gray
  static const Color onSurfaceVariantColor = Color(0xFF757575); // Medium gray
  
  static const Color outlineColor = Color(0xFFE0E0E0); // Light gray
  static const Color outlineVariantColor = Color(0xFFF5F5F5); // Very light gray
  
  static const Color backgroundColor = Color(0xFFFAFAFA); // Off-white
  static const Color onBackgroundColor = Color(0xFF212121); // Dark gray
  
  static const Color inverseSurfaceColor = Color(0xFF212121); // Dark gray
  static const Color onInverseSurfaceColor = Color(0xFFF5F5F5); // Light gray
  
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
          fontSize: 18,
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
          elevation: 0,
          shadowColor: primaryColor.withOpacity(0.2),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.1,
          ),
        ),
      ),
      
      // Outlined Button Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryColor,
          side: const BorderSide(color: primaryColor, width: 1),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.1,
          ),
        ),
      ),
      
      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.1,
          ),
        ),
      ),
      
      // Card Theme
      cardTheme: CardThemeData(
        elevation: 1,
        shadowColor: shadowColor.withOpacity(0.05),
        color: surfaceColor,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      ),
      
      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceVariantColor.withOpacity(0.5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryColor, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: outlineVariantColor, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: errorColor, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: errorColor, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        hintStyle: TextStyle(
          color: onSurfaceVariantColor.withOpacity(0.6),
          fontSize: 14,
        ),
        labelStyle: const TextStyle(
          color: onSurfaceVariantColor,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        floatingLabelStyle: const TextStyle(
          color: primaryColor,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
      
      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: surfaceColor,
        selectedItemColor: primaryColor,
        unselectedItemColor: onSurfaceVariantColor,
        type: BottomNavigationBarType.fixed,
        elevation: 4,
        selectedLabelStyle: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      ),
      
      // Floating Action Button Theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
        foregroundColor: onPrimaryColor,
        elevation: 2,
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
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
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
          fontSize: 20,
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
        primary: Color(0xFF81C784), // Lighter green for dark mode
        onPrimary: Color(0xFF1B5E20),
        primaryContainer: Color(0xFF2E7D32),
        onPrimaryContainer: Color(0xFFE8F5E8),
        secondary: Color(0xFF64B5F6), // Lighter blue for dark mode
        onSecondary: Color(0xFF0D47A1),
        secondaryContainer: Color(0xFF1976D2),
        onSecondaryContainer: Color(0xFFE3F2FD),
        tertiary: Color(0xFFBA68C8), // Lighter purple for dark mode
        onTertiary: Color(0xFF4A148C),
        tertiaryContainer: Color(0xFF7B1FA2),
        onTertiaryContainer: Color(0xFFF3E5F5),
        error: Color(0xFFEF5350), // Lighter red for dark mode
        onError: Color(0xFFB71C1C),
        errorContainer: Color(0xFFD32F2F),
        onErrorContainer: Color(0xFFFFEBEE),
        surface: Color(0xFF121212), // Dark surface
        onSurface: Color(0xFFE0E0E0), // Light text on dark surface
        surfaceVariant: Color(0xFF1E1E1E), // Darker variant
        onSurfaceVariant: Color(0xFFBDBDBD), // Medium light text
        outline: Color(0xFF424242), // Dark outline
        outlineVariant: Color(0xFF2E2E2E), // Darker outline variant
        background: Color(0xFF0A0A0A), // Very dark background
        onBackground: Color(0xFFE0E0E0), // Light text on dark background
        inverseSurface: Color(0xFFE0E0E0), // Light inverse surface
        onInverseSurface: Color(0xFF121212), // Dark text on light inverse surface
        shadow: Color(0xFF000000), // Shadow
        scrim: Color(0xFF000000), // Scrim
      ),
      scaffoldBackgroundColor: const Color(0xFF0A0A0A),
      
      // App Bar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: Color(0xFFE0E0E0),
        elevation: 0,
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Color(0xFFE0E0E0),
          letterSpacing: 0.1,
        ),
      ),
      
      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF81C784),
          foregroundColor: const Color(0xFF1B5E20),
          elevation: 0,
          shadowColor: const Color(0xFF81C784).withOpacity(0.2),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.1,
          ),
        ),
      ),
      
      // Outlined Button Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFF81C784),
          side: const BorderSide(color: Color(0xFF81C784), width: 1),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.1,
          ),
        ),
      ),
      
      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: const Color(0xFF81C784),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.1,
          ),
        ),
      ),
      
      // Card Theme
      cardTheme: CardThemeData(
        elevation: 1,
        shadowColor: Colors.black.withOpacity(0.2),
        color: const Color(0xFF121212),
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      ),
      
      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF1E1E1E).withOpacity(0.5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF81C784), width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF2E2E2E), width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFEF5350), width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFEF5350), width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        hintStyle: const TextStyle(
          color: Color(0xFFBDBDBD),
          fontSize: 14,
        ),
        labelStyle: const TextStyle(
          color: Color(0xFFBDBDBD),
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        floatingLabelStyle: const TextStyle(
          color: Color(0xFF81C784),
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
      
      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF121212),
        selectedItemColor: Color(0xFF81C784),
        unselectedItemColor: Color(0xFFBDBDBD),
        type: BottomNavigationBarType.fixed,
        elevation: 4,
        selectedLabelStyle: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      ),
      
      // Floating Action Button Theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xFF81C784),
        foregroundColor: Color(0xFF1B5E20),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
      
      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: const Color(0xFF1E1E1E).withOpacity(0.5),
        selectedColor: const Color(0xFF2E7D32),
        disabledColor: const Color(0xFF1E1E1E).withOpacity(0.3),
        labelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      ),
      
      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: Color(0xFF2E2E2E),
        thickness: 1,
        space: 1,
      ),
    );
  }
} 