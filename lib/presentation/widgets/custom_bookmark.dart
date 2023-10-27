import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../util/app_assets.dart';

class CustomBookMark extends StatelessWidget {
  final bool isBookmarked;

  const CustomBookMark({Key? key, this.isBookmarked = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.h),
      child: CircleAvatar(
        radius: 18.r,
        backgroundColor: Theme.of(context).colorScheme.surface,
        child: SvgPicture.asset(isBookmarked?AppAssets.bookmarked:AppAssets.bookmark,height: 20.h,width: 20.h,)
      ),
    );
  }
}
