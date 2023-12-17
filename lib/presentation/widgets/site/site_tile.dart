import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:triplaner/domain/entities/site.dart';
import 'package:triplaner/presentation/widgets/clock_hour_widget.dart';
import 'package:triplaner/presentation/widgets/custom_cache_image.dart';
import 'package:triplaner/presentation/widgets/free_refund_widget.dart';
import 'package:triplaner/presentation/widgets/price_widget.dart';
import 'package:triplaner/util/app_assets.dart';
import 'package:triplaner/util/app_constant.dart';
import 'package:triplaner/util/app_extentions.dart';

import '../custom_bookmark.dart';
import 'rating_and_review_widget.dart';

class SiteTile extends StatelessWidget {
  final VoidCallback? onTap;
  final VoidCallback? onBookMarkTap;
  final bool isBookMarked;
  final Site site;
  final double? bottomMargin;
  const SiteTile(
      {Key? key,
      this.onTap,
      required this.site,
      this.isBookMarked = false,
      this.onBookMarkTap,
      this.bottomMargin,

      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: AppConstant.horizontalTileCardHeight,
        padding: EdgeInsets.all(8.h),
        margin: EdgeInsets.only(bottom: bottomMargin??13.h),
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
                Hero(
                  tag: '${site.images?.first.variants!.getUrlBySize()}',
                  child: CustomCacheImage(
                    imgUrl: "${site.images?.first.variants!.getUrlBySize()}",
                    height:AppConstant.horizontalTileCardHeight,
                    radius: 12.r,
                    width: 123.w,
                  ),
                ),
                Positioned.fill(
                  child: Align(
                      alignment: Alignment.topRight,
                      child: CustomBookMark(
                        isBookmarked: isBookMarked,
                        onTap: onBookMarkTap,
                      )),
                ),
                // Positioned.fill(
                //   bottom: 4.h,
                //   child: Align(
                //     alignment: Alignment.bottomCenter,
                //     child: FreeRefundWidget(
                //       site: site,
                //     ),
                //   ),
                // ),
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
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0
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
                      RatingAndReviewWidget(
                          rating: site.ratings?.ratings ?? 0,
                          reviews: site.ratings?.reviewersCount ?? 0,
                          starSize: 20.h,
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ClockAndHourWidget(
                              site: site,
                              clockSize: 16.h,
                              timeSize: 14.sp,
                          ),
                          PriceWidget(
                            price: "${site.basePrice}",
                            fromSize:16.sp,
                            priceSize:26.sp,
                          ),
                          // Text(
                          //   "US \$${site.basePrice}",
                          //   style: TextStyle(
                          //       fontWeight: FontWeight.w700,
                          //       fontSize: 16.sp,
                          //       color: Theme.of(context).colorScheme.primary),
                          // )
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
