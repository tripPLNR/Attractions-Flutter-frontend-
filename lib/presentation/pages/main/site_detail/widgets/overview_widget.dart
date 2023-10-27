import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:triplaner/domain/entities/site.dart';
import 'package:triplaner/util/app_style.dart';

class OverviewWidget extends StatelessWidget {
  final Site site;
  const OverviewWidget({Key? key,required this.site}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 22.h,bottom: 30.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Overview",
            style: AppStyle.headingH2(context),
          ),
          SizedBox(height: 12.h,),
          Text(site.description??"N/A", style: AppStyle.headingH3(context),
          ),
        ],
      ),
    );
  }
}
