import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:triplaner/domain/entities/site.dart';
import 'package:triplaner/util/app_assets.dart';
import 'package:triplaner/util/app_style.dart';

class ExcludesWidget extends StatelessWidget {
  final Site site;
  const ExcludesWidget({Key? key,required this.site}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 22.h,bottom: 30.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Excludes",
            style: AppStyle.headingH2(context),
          ),
          SizedBox(height: 12.h,),
          ListView.builder(
            itemCount: site.exclusions?.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context,index){
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 3.h),
                child: Row(
                  children: [
                    SvgPicture.asset(AppAssets.excludes,height: 24.h,width: 24.w,),
                    SizedBox(width: 6.w,),
                    SizedBox(
                        width: 1.sw-80.w,
                        child: Text("${site.exclusions?[index].otherDescription}",style: AppStyle.headingH3(context),)),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}