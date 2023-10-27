import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../custom_star_rating.dart';

class RatingAndReviewWidget extends StatelessWidget {
  final double rating;
  final int reviews;
  final bool oneStarMode;

  const RatingAndReviewWidget(
      {Key? key,
      required this.rating,
      required this.reviews,
      this.oneStarMode = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomStarRating(
          ignoreGesture: true,
          rating: rating,
          oneStarMode: oneStarMode,
        ),
        Text(
          " $rating($reviews reviews)",
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: Theme.of(context).colorScheme.tertiaryContainer,
          ),
        ),
      ],
    );
  }
}
