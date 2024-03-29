import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SiteDetailDivider extends StatelessWidget {
  const SiteDetailDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(top:20.h),
      child: const Divider(
        thickness: 1,
        height: 0,
      ),
    );
  }
}
