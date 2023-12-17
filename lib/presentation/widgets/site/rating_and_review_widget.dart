import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../custom_star_rating.dart';

class RatingAndReviewWidget extends StatelessWidget {
  final double rating;
  final double? ratingSize;
  final double? starSize;
  final int reviews;
  final bool oneStarMode;
  const RatingAndReviewWidget(
      {Key? key,
      required this.rating,
      required this.reviews,
      this.ratingSize,
      this.starSize,

      this.oneStarMode = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(

      children: [
        CustomStarRating(
          ignoreGesture: true,
          rating: rating,
          size: starSize??25.h,
          oneStarMode: oneStarMode,
        ),
        Text.rich(TextSpan(
            text: "$rating",
            style: TextStyle(
              fontSize: ratingSize??18.sp,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.tertiaryContainer,
              letterSpacing: 0
            ),
            children: [
              TextSpan(
                text: "($reviews reviews)",
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.tertiaryContainer,
                    letterSpacing: 0
                ),
              )
            ])),
        // ),
      ],
    );
  }
}
