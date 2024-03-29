import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:triplaner/domain/entities/product_review.dart';
import 'package:triplaner/presentation/widgets/custom_star_rating.dart';
import 'package:triplaner/util/app_assets.dart';
import 'package:triplaner/util/app_extentions.dart';
import 'package:triplaner/util/app_style.dart';
import 'package:triplaner/presentation/widgets/custom_readmore.dart';

class ReviewWidget extends StatelessWidget {
  final ProductReview reviewRating;
  final VoidCallback? onTap;
  final bool hideDivider;

  const ReviewWidget(
      {Key? key,
      required this.reviewRating,
      this.onTap,
      this.hideDivider = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(bottom: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  AppAssets.profileAvatar,
                  height: 50.h,
                ),
                SizedBox(
                  width: 10.w,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${reviewRating.userName.toString().capitalize()} ",
                      style: AppStyle.siteDetailHeading(context)
                          .copyWith(fontSize: 18.sp),
                    ),
                    SizedBox(height: 5.h,),
                    Row(
                      children: [
                        CustomStarRating(
                          rating: reviewRating.rating ?? 0,
                          size: 18.h,
                        ),
                        Text(
                          " ${reviewRating.rating}",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0,
                              color: Theme.of(context)
                                  .colorScheme
                                  .tertiaryContainer,
                              fontSize: 16.sp),
                        ),
                      ],
                    ),
                  ],
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      "${reviewRating.publishedDate} ",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.2,
                        color: Theme.of(context).colorScheme.tertiaryContainer,
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CustomReadMore(
                text: "${reviewRating.comment}",
                style: AppStyle.siteDetailSubHeading(context),
              ),
            ),
            hideDivider
                ? SizedBox(
                    height: 10.h,
                  )
                : SizedBox(
                    height: 18.h,
                  ),
            hideDivider
                ? const SizedBox()
                : const Divider(
                    thickness: 1,
                    height: 0,
                  ),
          ],
        ),
      ),
    );
  }
}
