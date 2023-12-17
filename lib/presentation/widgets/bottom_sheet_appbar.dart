import 'package:expand_tap_area/expand_tap_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:triplaner/util/app_constant.dart';
import 'package:triplaner/util/app_theme.dart';

class BottomSheetAppbar extends StatelessWidget {
  final String title;
  const BottomSheetAppbar({Key? key,required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Padding(
          padding:AppConstant.bottomSheetHorizontalPadding.copyWith(top:AppConstant.bottomSheetTopPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                letterSpacing: 0
              ),),
              ExpandTapWidget(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  tapPadding: const EdgeInsets.all(30.0),
                  child: const Icon(Icons.close)),
            ],
          ),
        ),
        SizedBox(height: 16.h,),
        const Divider(
          thickness: 1,
          height: 0,
        )
      ],
    );
  }
}
