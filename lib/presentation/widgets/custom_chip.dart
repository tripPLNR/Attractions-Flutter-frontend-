import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomChip extends StatelessWidget {
  final String title;
  final String assetPath;
  final VoidCallback onTap;

  const CustomChip({Key? key,required this.title,required this.assetPath,required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: onTap,
      child: Container(
        padding:EdgeInsets.symmetric(horizontal: 7.w,vertical: 5.h),
        margin: EdgeInsets.symmetric(horizontal: 4.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: Theme.of(context).colorScheme.background,
          border: Border.all(color: Theme.of(context).colorScheme.primary)
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(assetPath,),
            SizedBox(width: 4.w,),
            Text(title,style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w600,),),
          ],
        ),
      ),
    );
  }
}
