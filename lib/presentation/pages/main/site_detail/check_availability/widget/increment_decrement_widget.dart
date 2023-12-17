import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:triplaner/util/app_assets.dart';

class IncrementDecrementWidget extends StatelessWidget {
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final int value;

  const IncrementDecrementWidget(
      {Key? key, required this.onDecrement, required this.onIncrement,required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.h),
      decoration: BoxDecoration(
          border: Border.all(
              color: Theme.of(context).colorScheme.primary, width: 1),
          borderRadius: BorderRadius.circular(29.r)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
              onTap: onDecrement, child: SvgPicture.asset(AppAssets.decrement)),
          SizedBox(
            width: 14.w,
          ),
          Text(
            "${value}",
            style: TextStyle(fontSize: 13.sp),
          ),
          SizedBox(
            width: 14.w,
          ),
          InkWell(
              onTap: onIncrement, child: SvgPicture.asset(AppAssets.increment)),
        ],
      ),
    );
  }
}
