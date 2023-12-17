import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:triplaner/util/app_assets.dart';

class DurationChip extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool isSelected;

  const DurationChip({Key? key,required this.onTap,required this.isSelected,required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 8.h),
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
            Text(title,style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                letterSpacing: 0,
              color: isSelected?
              Theme.of(context).colorScheme.primary:
              Theme.of(context).colorScheme.tertiaryContainer
            ),),
            SizedBox(width: 12.w,),
            SvgPicture.asset(isSelected?AppAssets.selectedRadio:AppAssets.unSelectedRadio,
            height: 24.h,
             width: 24.h,
            ),

          ],
        ),
      ),
    );
  }
}
