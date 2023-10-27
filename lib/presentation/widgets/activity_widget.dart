import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:triplaner/domain/entities/top_activity.dart';

import 'custom_circular_cache_image.dart';

class ActivityWidget extends StatelessWidget {
  final VoidCallback onTap;
  final TopActivity topActivity;
  const ActivityWidget({Key? key, required this.onTap,required this.topActivity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Column(
          children: [
             CustomCircularCacheImage(
              imgUrl:topActivity.thumbnail??"",
            ),
            SizedBox(
              height: 4.h,
            ),
            SizedBox(
              width: 66.w,
              child: Text(
                topActivity.name??"N/A",
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }
}
