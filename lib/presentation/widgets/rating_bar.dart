import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RatingBar extends StatelessWidget {
  final String title;
  final int progress;

  const RatingBar({Key? key, required this.title, required this.progress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 3.h),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Text(
          title,
          style: TextStyle(
              color: Theme.of(context).colorScheme.tertiaryContainer,
              fontSize: 11.sp,
              fontWeight: FontWeight.w500),
        ),
        SizedBox(
          width: 8.w,
        ),
        SizedBox(
          height: 7.h,
          width: 209.w,
          child: LinearProgressIndicator(
            backgroundColor:
                Theme.of(context).colorScheme.secondary.withOpacity(0.3),
            minHeight: 7,
            value: progress.toDouble() / 100,
            valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).colorScheme.primary),
          ),
        ),
      ]),
    );
  }
}
