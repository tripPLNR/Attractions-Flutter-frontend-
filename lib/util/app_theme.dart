import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';

class AppTheme {
  static String petronaFontFamily = 'Petrona';
  static String numBrushScriptFontFamily = 'NanumBrushScript';
  static String mulish = 'Mulish';
  static String montserratAlternates = 'MontserratAlternates';
  static String montserrat = 'Montserrat';

  static ThemeData lightTheme() {
    return ThemeData(
      primaryColor: AppColors.primaryColor,
      useMaterial3: false,
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        background: AppColors.scaffoldColor,
        onBackground: AppColors.onBackgroundColor,
        primary: AppColors.primaryColor,
        onPrimary: AppColors.onPrimaryColor,
        secondary: AppColors.secondaryColor,
        onSecondary: AppColors.onSecondaryColor,
        error: AppColors.primaryColor,
        onError: AppColors.whiteColor,
        surface: AppColors.whiteColor,
        onSurface: AppColors.blackColor,
        tertiary: AppColors.tertiaryColor,
        onTertiary: AppColors.onTertiaryColor,
        tertiaryContainer: AppColors.greyColor
      ),
      dividerColor: AppColors.dividerColor,
      dividerTheme:  DividerThemeData(
        color: AppColors.dividerColor.withOpacity(0.2),
      ),
      scaffoldBackgroundColor: AppColors.whiteColor,
      fontFamily: mulish,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.onPrimaryColor),
      ),
      radioTheme: RadioThemeData(
          fillColor: MaterialStateProperty.all(AppColors.primaryColor)),
      textTheme: Typography.englishLike2018.apply(
        bodyColor: AppColors.blackColor,
        fontFamily: mulish,
      ),
      indicatorColor: AppColors.primaryColor,
    );
  }

  static ThemeData darkTheme(Locale locale) {
    return ThemeData();
  }
}
