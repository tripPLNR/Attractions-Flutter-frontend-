import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:triplaner/domain/entities/site.dart';

class FreeRefundWidget extends StatelessWidget {
  final Site site;
  const FreeRefundWidget({Key? key,required this.site}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isAvailable=site.cancellationPolicy?.description.toString().contains("full refund")??false;
    return isAvailable?Container(
      padding: EdgeInsets.symmetric(vertical: 4.h,horizontal: 7.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.r),
          color: Theme.of(context).colorScheme.surface
      ),
      child:Text(
        "Free cancellation",
        style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 12.sp,
            color: Theme.of(context).colorScheme.primary),
      ),
    ):const SizedBox();
  }
}
