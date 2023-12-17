import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:triplaner/util/app_assets.dart';

class ActivityChip extends StatelessWidget {
  final String title;
  final String icon;
  final VoidCallback onTap;
  final bool isSelected;

  const ActivityChip({Key? key,required this.onTap,required this.isSelected,required this.icon,required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 8.h),
        margin: EdgeInsets.symmetric(horizontal: 4.w,vertical: 6.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(42.r),
          color: isSelected?Theme.of(context).colorScheme.tertiary:Theme.of(context).colorScheme.surface,
          border: Border.all(
            color: isSelected?Theme.of(context).colorScheme.primary:Theme.of(context).colorScheme.tertiaryContainer.withOpacity(0.2),
            width: 1,
          )
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(icon,
            height: 24.h,
             width: 24.h,
            ),
            SizedBox(width: 4.w,),
            Text(title,style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              letterSpacing: 0
            ),)

          ],
        ),
      ),
    );
  }
}
