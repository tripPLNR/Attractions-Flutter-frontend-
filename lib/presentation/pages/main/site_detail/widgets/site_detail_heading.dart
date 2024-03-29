import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:triplaner/util/app_style.dart';

class SiteDetailHeading extends StatelessWidget {
  final String title;
  const SiteDetailHeading({Key? key,required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(top: 15.h,bottom: 8.h),
      child: Text(
        title,
        style: AppStyle.siteDetailHeading(context),
      ),
    );
  }
}
