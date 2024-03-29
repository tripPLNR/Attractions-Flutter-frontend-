import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:triplaner/domain/entities/search_location.dart';
import 'package:triplaner/domain/entities/search_suggestion.dart';
import 'package:triplaner/domain/entities/site.dart';
import 'package:triplaner/util/app_assets.dart';
import 'package:triplaner/util/app_constant.dart';
import 'package:triplaner/util/app_extentions.dart';
import 'package:triplaner/util/app_style.dart';

import '../../../../widgets/custom_cache_image.dart';

class SearchAttractionSuggestion extends StatelessWidget {
  final Site site;
  final VoidCallback onTap;

  const SearchAttractionSuggestion(
      {Key? key, required this.site, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(bottom: 10.h),
        child: Column(
          children: [
            Padding(
              padding: AppConstant.screenPadding,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SvgPicture.asset(AppAssets.location,height: 32.h,width: 32.h,),
                  CustomCacheImage(
                    imgUrl: site.images?.first ?? "",
                    borderRadius: BorderRadius.circular(5.r),
                    width: 35.h,
                    height: 30.h,
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${site.title}",
                            style: AppStyle.searchResultTextStyle(context),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                        // Text("${site.productAddress}",
                        //     style: TextStyle(fontSize: 12.sp),
                        //     maxLines: 1,
                        //     overflow: TextOverflow.ellipsis),

                      ],
                    ),
                  ),
                  // SizedBox(width: 30.w,),
                  // SvgPicture.asset(AppAssets.landMark,height: 36.h,width: 36.h,),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            const Divider(
              thickness: 0.5,
              height: 0,
            )
          ],
        ),
      ),
    );
  }
}
