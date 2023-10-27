
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../util/app_colors.dart';

class CustomLoader extends StatelessWidget {
  Color? color;
  double? size;
  CustomLoader({Key? key,this.color,this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpinKitThreeBounce(
      color: color??AppColors.primaryColor,
      size: size??28.h,
      // lineWidth: 2.h,
    );
  }
}