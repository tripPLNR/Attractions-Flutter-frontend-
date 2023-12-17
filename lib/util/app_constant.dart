import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppConstant {
  static double horizontalPadding = 19.w;
  static double authTopPadding = 22.h;

  static EdgeInsets screenPadding = EdgeInsets.only(
    left: 16.w,
    right: 16.w,
  );
  static EdgeInsets bottomSheetHorizontalPadding = EdgeInsets.only(
    left: 16.w,
    right: 16.w,
  );
  static double bottomSheetTopPadding = 16.h;

  static String appName = "TriPlaner";

  static double get appBarHeight => 65.h;

 // static double get horizontalCardHeight=>328.h;
  static double get horizontalMiniCardHeight=>327.h;
  static double get horizontalMiniGridCardHeight=>230.h;
  static double get horizontalTileCardHeight=>155.h;



}
