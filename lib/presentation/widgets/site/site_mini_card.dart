import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:triplaner/domain/entities/site.dart';
import 'package:triplaner/presentation/widgets/clock_hour_widget.dart';
import 'package:triplaner/presentation/widgets/free_refund_widget.dart';
import 'package:triplaner/presentation/widgets/price_widget.dart';
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
  final bool isBookMarked;
  final VoidCallback? onBookMarkTap;


  const SiteMiniCard(
      {Key? key, this.gridviewMode = false, this.onTap, required this.site,this.isBookMarked=false,this.onBookMarkTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: gridviewMode ? 172.w : 310.w,
        padding: EdgeInsets.all(8.h),
        margin: gridviewMode
            ? EdgeInsets.all(6.h)
            : EdgeInsets.symmetric(horizontal: 6.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            color: Theme.of(context).colorScheme.surface,
            border: Border.all(
                color:
                    Theme.of(context).colorScheme.secondary.withOpacity(0.3))),
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
                      tag: '${site.images?.first.variants!.getUrlBySize()}',
                      child: CustomCacheImage(
                        imgUrl:"${site.images?.first.variants!.getUrlBySize()}",
                        height: gridviewMode ? 148.h : 190.h,
                        radius: 12.r,
                        width: 1.sw,
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
                    //  Positioned.fill(
                    //    bottom: 4.h,
                    //    left: 4.h,
                    //   child: Align(
                    //       alignment: Alignment.bottomLeft,
                    //       child:  FreeRefundWidget(site: site,),),
                    // ),

                  ],
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  "${site.title}",
                  style: TextStyle(
                      fontSize: gridviewMode?14.sp:18.sp,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RatingAndReviewWidget(
                  rating: site.ratings?.ratings ?? 0,
                  reviews: site.ratings?.reviewersCount ?? 0,
                  oneStarMode: gridviewMode,
                  starSize: gridviewMode?20.h:25.h,
                  ratingSize:gridviewMode?14.sp:18.sp ,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClockAndHourWidget(
                      site: site,
                      clockSize: gridviewMode?12.h:13.h,
                      timeSize: gridviewMode?12.sp:14.sp
                    ),
                    PriceWidget(
                      price: "${site.basePrice}",
                      fromSize:gridviewMode?11.sp:16.sp,
                      priceSize: gridviewMode?14.sp:26.sp,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
