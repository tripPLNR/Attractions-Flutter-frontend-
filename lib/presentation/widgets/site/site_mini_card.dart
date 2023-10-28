import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:triplaner/domain/entities/site.dart';
import 'package:triplaner/util/app_assets.dart';
import 'package:triplaner/util/app_colors.dart';
import 'package:triplaner/util/app_extentions.dart';

import '../custom_bookmark.dart';
import '../custom_cache_image.dart';
import '../custom_star_rating.dart';
import 'rating_and_review_widget.dart';

class SiteMiniCard extends StatelessWidget {
  final bool gridviewMode;
  final VoidCallback? onTap;
  final Site site;

  const SiteMiniCard(
      {Key? key, this.gridviewMode = false, this.onTap, required this.site})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: gridviewMode ? 164.h : 280.w,
        padding: EdgeInsets.all(8.h),
        margin: gridviewMode
            ? EdgeInsets.all(6.h)
            : EdgeInsets.symmetric(horizontal: 6.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            color: Theme.of(context).colorScheme.surface,
            border: Border.all(
                color:
                    Theme.of(context).colorScheme.secondary.withOpacity(0.2))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// image with bookmark
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Hero(
                      tag: '${site.images?.first.toJson().getImageUrl()}',
                      child: CustomCacheImage(
                        imgUrl:"${site.images?.first.toJson().getImageUrl()}",
                        height: gridviewMode ? 148.h : 196.h,
                        radius: 12.r,
                        width: 1.sw,
                      ),
                    ),
                    const Positioned.fill(
                      child: Align(
                          alignment: Alignment.topRight,
                          child: CustomBookMark()),
                    )
                  ],
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  "${site.title}",
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0),
                  maxLines: gridviewMode ? 2 : 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(
                //   "${site.location}",
                //   style: TextStyle(
                //     fontSize: 12.sp,
                //     fontWeight: FontWeight.w500,
                //     color: Theme.of(context).colorScheme.tertiaryContainer,
                //   ),
                //   maxLines: 1,
                //   overflow: TextOverflow.ellipsis,
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 3.h),
                      child: RatingAndReviewWidget(
                        rating: site.ratings?.ratings ?? 0,
                        reviews: site.ratings?.reviewersCount ?? 0,
                        oneStarMode: true,
                      ),
                    ),
                    Visibility(
                      visible: !gridviewMode,
                      child: Text(
                        "free cancellation",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp,
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 4.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            AppAssets.clock,
                            height: 16.h,
                          ),
                          SizedBox(
                            width: 4.w,
                          ),
                          Text(
                            "${site.duration?.hours} hours",
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 12.sp),
                          ),
                        ],
                      ),
                      Text(
                        "${site.currency} ${site.basePrice}",
                        style: TextStyle(
                          fontSize: gridviewMode?14.sp:16.sp,
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
