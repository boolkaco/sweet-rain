import 'package:flutter/material.dart';
import 'package:sweetbonanzarain/theme/app_colors.dart';
import 'package:sweetbonanzarain/theme/app_branding_colors.dart';

class AppTheme {
  static const String fontFamily = "Nunito";

  static ThemeData get lightTheme {
    return ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: AppColors.white,
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.orange),
      primaryColor: AppColors.orange,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.white,
      ),
      iconTheme: const IconThemeData(
        color: AppColors.black,
      ),
      dividerColor: AppColors.silver.withOpacity(0.2),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.white,
        selectedItemColor: AppColors.orange,
        unselectedItemColor: AppColors.black,
        selectedIconTheme: IconThemeData(
          color: AppColors.orange,
        ),
        selectedLabelStyle: TextStyle(
          color: AppColors.orange,
        ),
        unselectedIconTheme: IconThemeData(
          color: AppColors.black,
        ),
        unselectedLabelStyle: TextStyle(
          color: AppColors.black,
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        labelStyle: TextStyle(color: AppColors.silver),
        fillColor: Colors.transparent,
        filled: true,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.orange),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.silver),
        ),
      ),
      textTheme: const TextTheme(
        headlineSmall: TextStyle(
          fontSize: 14,
          color: AppColors.white,
          fontFamily: fontFamily,
        ),
        headlineMedium: TextStyle(
          fontSize: 20,
          color: AppColors.white,
          fontFamily: fontFamily,
          fontWeight: FontWeight.w800,
        ),
        headlineLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w900,
          color: AppColors.white,
          fontFamily: fontFamily,
        )
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: AppColors.orange,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
            side: const BorderSide(color: AppColors.white, width: 1)
          ),
        ),
      ),
      useMaterial3: true,
    ).copyWith(
        extensions: <ThemeExtension<dynamic>>[
          const AppBrandingColors(
            color: AppColors.orange,
          ),
        ]
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: AppColors.silver,
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.orange),
      primaryColor: AppColors.orange,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.silver,
      ),
      iconTheme: const IconThemeData(
        color: AppColors.white,
      ),
      dividerColor: AppColors.silver.withOpacity(0.2),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.silver,
        selectedItemColor: AppColors.orange,
        unselectedItemColor: AppColors.white,
        unselectedIconTheme: IconThemeData(
          color: AppColors.white,
        ),
        unselectedLabelStyle: TextStyle(
          color: AppColors.white,
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        labelStyle: TextStyle(color: AppColors.silver),
        fillColor: Colors.transparent,
        filled: true,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.orange),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.silver),
        ),
      ),
      textTheme: const TextTheme(
          headlineSmall: TextStyle(
            fontSize: 14,
            color: AppColors.white,
          ),
          headlineMedium: TextStyle(
            fontSize: 24,
            color: AppColors.white,
          ),
          headlineLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w800,
            color: AppColors.white,
          )
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: AppColors.orange,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
              side: const BorderSide(color: AppColors.white, width: 1)
          ),
        ),
      ),
      useMaterial3: true,
    ).copyWith(
        extensions: <ThemeExtension<dynamic>>[
          const AppBrandingColors(
            color: AppColors.orange,
          ),
        ]
    );
  }
}
