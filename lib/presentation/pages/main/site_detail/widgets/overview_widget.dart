import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:triplaner/domain/entities/site.dart';
import 'package:triplaner/util/app_style.dart';
import 'package:triplaner/presentation/widgets/custom_readmore.dart';

class OverviewWidget extends StatelessWidget {
  final Site site;
  final Function(bool)? onTextCollapsed;
  const OverviewWidget({Key? key,required this.site,required this.onTextCollapsed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 22.h,bottom: 30.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Overview",
                style: AppStyle.siteDetailHeading(context),
              ),
              SizedBox(height: 12.h,),
              Text(
               site.description??"N/A", style: AppStyle.siteDetailSubHeading(context),
              ),
            ],
          ),
        ),
        const Divider(
          thickness: 1,
          height: 0,
        ),
      ],
    );
  }
}
