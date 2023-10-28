import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:triplaner/domain/entities/site.dart';
import 'package:triplaner/presentation/widgets/custom_cache_image.dart';
import 'package:triplaner/presentation/widgets/custom_star_rating.dart';
import 'package:triplaner/util/app_assets.dart';
import 'package:triplaner/util/app_extentions.dart';

import '../custom_bookmark.dart';
import 'rating_and_review_widget.dart';

class SiteTile extends StatelessWidget {
  final VoidCallback? onTap;
  final Site site;

  const SiteTile({Key? key, this.onTap, required this.site}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height=160.h;
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        padding: EdgeInsets.all(8.h),
        margin: EdgeInsets.only(bottom: 13.h),
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
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            border: Border.all(
                color:
                    Theme.of(context).colorScheme.secondary.withOpacity(0.3))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                CustomCacheImage(
                  imgUrl:"${site.images?.first.toJson().getImageUrl()}",
                  height: height,
                  radius: 12.r,
                  width: 123.w,
                ),
                const Positioned.fill(
                  child: Align(
                      alignment: Alignment.topRight, child: CustomBookMark()),
                )
              ],
            ),
            SizedBox(
              width: 5.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 4.h,
                      ),
                      Text(
                        "${site.title}",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RatingAndReviewWidget(
                              rating: site.ratings?.ratings ?? 0,
                              reviews: site.ratings?.reviewersCount ?? 0),
                          Text(
                            "${site.provider}",
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context)
                                    .colorScheme
                                    .tertiaryContainer),
                          )
                        ],
                      ),
                      SizedBox(height: 4.h,),
                      Text(
                        "Free cancellation",
                        style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      SizedBox(height: 4.h,),
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
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.sp),
                              )
                            ],
                          ),
                          Text(
                            "${site.currency} ${site.basePrice}",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16.sp,
                                color: Theme.of(context).colorScheme.primary),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
