import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:triplaner/domain/entities/review_rating.dart';
import 'package:triplaner/presentation/widgets/custom_star_rating.dart';
import 'package:triplaner/util/app_style.dart';
import 'package:triplaner/presentation/widgets/custom_readmore.dart';

class ReviewWidget extends StatelessWidget {
  final ReviewRating reviewRating;
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${reviewRating.userName} ",
                  style:AppStyle.siteDetailHeading(context),
                ),
                Text(
                  "${reviewRating.date} ",
                  style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.2,
                    color: Theme.of(context).colorScheme.tertiaryContainer
                  ),
                )
              ],
            ),
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
                      color: Theme.of(context).colorScheme.tertiaryContainer,
                      fontSize: 16.sp),
                ),
              ],
            ),
            SizedBox(
              height: 2.h,
            ),
            CustomReadMore(
                text: "${reviewRating.review}",
              style: AppStyle.siteDetailSubHeading(context).copyWith(fontSize: 19.sp,letterSpacing: -0.2),

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
