import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:triplaner/util/app_theme.dart';
import 'app_colors.dart';

class AppStyle {
  static TextStyle authHeadingStyle(BuildContext context) => TextStyle(
        fontSize: 32.sp,
        fontWeight: FontWeight.w700,
        color: Theme.of(context).colorScheme.primary,
      );

  static TextStyle headingH1(BuildContext context) => TextStyle(
        fontSize: 21.sp,
        fontWeight: FontWeight.w600,
        color: Theme.of(context).colorScheme.onBackground,
        fontFamily: AppTheme.montserratAlternates,
      );

  static TextStyle headingH2(BuildContext context) => TextStyle(
      fontSize: 21.sp,
      fontWeight: FontWeight.w500,
      color: Theme.of(context).colorScheme.onBackground,
  );

  static TextStyle headingH3(BuildContext context) => TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    color: Theme.of(context).colorScheme.tertiaryContainer,
  );
  static TextStyle bottomSheetHeading() => TextStyle(
      fontSize: 20.sp,
      fontWeight: FontWeight.w700,
      color: AppColors.blackColor);

  static TextStyle authSubHeadingStyle(BuildContext context) => TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
        color: Theme.of(context).colorScheme.secondary,
      );

  static BoxShadow boxShadow(context) => BoxShadow(
        color: Theme.of(context).colorScheme.onBackground.withOpacity(0.15),
        blurRadius: 4.0, // soften the shadow
        spreadRadius: 0, //extend the shadow
        offset: const Offset(
          1.0, // Move to right 5  horizontally
          1.0, // Move to bottom 5 Vertically
        ), // Spread radius
      );

  static TextStyle textFieldLabelStyle(BuildContext context) => TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,

      );

  static TextStyle textFieldHintStyle(BuildContext context) => TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      color: Theme.of(context).colorScheme.tertiaryContainer // grey color

      );

  static TextStyle textFieldTextStyle(BuildContext context) => TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: Theme.of(context).colorScheme.onBackground,
      );

  static Gradient linearGradient() => const LinearGradient(colors: [
        Color(0xffFC7F13),
        Color(0xffCF530D),
      ], begin: Alignment.topCenter, end: Alignment.bottomCenter);
}
