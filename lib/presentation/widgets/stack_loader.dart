import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:triplaner/util/app_assets.dart';
import 'package:triplaner/util/app_style.dart';

import 'custom_loader.dart';


class StackLoader extends StatelessWidget {
  final bool show;
  final String? title;
  const StackLoader({Key? key,this.show=false,this.title=""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return show?Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              color: Theme.of(context).primaryColor
            ),
            padding: EdgeInsets.symmetric(vertical: 20.h,horizontal: 20.w),
            margin: EdgeInsets.symmetric(horizontal: 100.w),

            child:Center(
              child: Column(
                children: [
                  CustomLoader(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  SizedBox(height: 20.h,),
                  Text("Please wait.... $title",style: AppStyle.authSubHeadingStyle(context).copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ):const SizedBox();
  }
}
