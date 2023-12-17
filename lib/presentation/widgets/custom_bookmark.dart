import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../util/app_assets.dart';

class CustomBookMark extends StatelessWidget {
  final bool isBookmarked;
  final VoidCallback? onTap;
  const CustomBookMark({Key? key, this.isBookmarked = false,this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(8.h),
        child: CircleAvatar(
          radius: 18.r,
          backgroundColor: Theme.of(context).colorScheme.surface,
          child: SvgPicture.asset(isBookmarked?AppAssets.bookmarked:AppAssets.bookmark,height: 20.h,width: 20.h,)
        ),
      ),
    );
  }
}
