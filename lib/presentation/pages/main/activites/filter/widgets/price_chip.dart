import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class PriceChip extends StatelessWidget {
  final String title;
  final double value;

  const PriceChip({Key? key,required this.title,required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 8.h),
      margin: EdgeInsets.symmetric(horizontal: 4.w,vertical: 6.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(42.r),
          color:Theme.of(context).colorScheme.surface,
          border: Border.all(
            color: Theme.of(context).colorScheme.tertiaryContainer.withOpacity(0.2),
            width: 1,
          )
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "$title: ",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: Theme.of(context).colorScheme.tertiaryContainer.withOpacity(0.3)
            ),
          ),
          Text("\$$value",style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: 0
          ),)

        ],
      ),
    );
  }
}
