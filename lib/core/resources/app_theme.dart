import 'package:flutter/material.dart';

import 'colors_manager.dart';

class AppTheme {
  static ThemeMode themeMode = ThemeMode.light;
  static ThemeData lightTheme = ThemeData(
      fontFamily: "Poppins",
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedLabelStyle: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: ColorsManager.lightPrimary
          ),
          unselectedLabelStyle: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: ColorsManager.unselectedTabColor
          )
      ),
      colorScheme: ColorScheme.light(
          primary: ColorsManager.lightPrimary,
          onPrimary:ColorsManager.lightPrimary,
          onPrimaryContainer: ColorsManager.whiteColor,
          secondary: ColorsManager.lightFieldBorderColor

      ),
      scaffoldBackgroundColor: ColorsManager.lightBackground,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      textTheme: TextTheme(
          titleMedium: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: ColorsManager.blackColor
          ),
          bodySmall:TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: ColorsManager.lightSecondaryColor
          ),
          labelMedium: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: ColorsManager.whiteColor
          ),
          labelSmall: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: ColorsManager.lightPrimary
          ),
          titleSmall: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: ColorsManager.lightPrimary,
              decoration: TextDecoration.underline,
              decorationColor: ColorsManager.lightPrimary
          ),
          displaySmall: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500
          ),
          bodyMedium: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.white
          ),
          headlineSmall: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: ColorsManager.lightPrimary
          )
      )
  );
  static ThemeData darkTheme = ThemeData(
      fontFamily: "Poppins",
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: ColorsManager.darkBackground,
          selectedLabelStyle: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: ColorsManager.darkPrimary
          ),
          unselectedLabelStyle: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: ColorsManager.unselectedTabColor
          )
      ),

      colorScheme: ColorScheme.dark(
          primary: ColorsManager.darkPrimary,
          onPrimary:ColorsManager.whiteColor,
          onPrimaryContainer: ColorsManager.darkUnselectedSettings,
          secondary: ColorsManager.darkFieldBorderColor

      ),
      scaffoldBackgroundColor: ColorsManager.darkBackground,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      textTheme: TextTheme(
          displaySmall: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500
          ),
          bodyMedium: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.white
          ),
          titleMedium: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: ColorsManager.whiteColor
          ),
          bodySmall:TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: ColorsManager.darkSecondaryColor
          ),
          labelMedium: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: ColorsManager.whiteColor
          ),
          labelSmall: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: ColorsManager.whiteColor
          ),
          titleSmall: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: ColorsManager.darkPrimary,
              decoration: TextDecoration.underline,
              decorationColor: ColorsManager.darkPrimary
          ),
          headlineSmall: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: ColorsManager.darkPrimary
          )
      )

  );
}