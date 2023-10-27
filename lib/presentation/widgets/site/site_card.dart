import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:triplaner/domain/entities/site.dart';
import 'package:triplaner/presentation/widgets/custom_image_slider.dart';
import 'package:triplaner/presentation/widgets/site/rating_and_review_widget.dart';
import 'package:triplaner/util/app_assets.dart';
import 'package:triplaner/util/app_colors.dart';
import 'package:triplaner/util/app_extentions.dart';

import '../custom_bookmark.dart';
import '../custom_cache_image.dart';
import '../custom_star_rating.dart';

class SiteCard extends StatelessWidget {
  final VoidCallback? onTap;
  final Site site;
  const SiteCard({Key? key, this.onTap,required this.site}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 1.sw,
        padding: EdgeInsets.all(8.h),
        margin: EdgeInsets.only(bottom: 11.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            color: Theme.of(context).colorScheme.surface,
            boxShadow: [
              BoxShadow(
                color: Theme.of(context)
                    .colorScheme
                    .onBackground
                    .withOpacity(0.25),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
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
                    CustomImageSlider(
                        height: 198.h,
                        width: 1.sw,
                        borderRadius: BorderRadius.circular(12.r),
                          images: site.images
                          ?.map((e) => e.toJson().getImageUrl()?? "")
                          .toList() ??
                          [],
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
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h,),
                // Text(
                //   "${site.location}",
                //   style: TextStyle(
                //       fontSize: 12.sp,
                //       fontWeight: FontWeight.w500,
                //       letterSpacing: 0,
                //       color: Theme.of(context).colorScheme.secondary),
                //   maxLines: 3,
                //   overflow: TextOverflow.ellipsis,
                // ),
                Text(
                  "Free cancellation",
                  style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).colorScheme.primary),
                )
              ],
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RatingAndReviewWidget(rating: site.ratings?.ratings??0, reviews: site.ratings?.reviewersCount??0),
                    Text(
                      "${site.provider}",
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).colorScheme.secondary),
                    )
                  ],
                ),
                SizedBox(
                  height: 3.h,
                ),
                Row(
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
                              fontWeight: FontWeight.w500, fontSize: 14.sp),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "from",
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).colorScheme.primary),
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        Text(
                          "${site.currency} ${site.basePrice}",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.h,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
