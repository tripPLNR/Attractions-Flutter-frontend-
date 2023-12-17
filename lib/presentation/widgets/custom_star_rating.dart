import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomStarRating extends StatelessWidget {
  final bool ignoreGesture;
  final double rating;
  final double size;
  final bool oneStarMode;
  const CustomStarRating({Key? key,this.ignoreGesture=false,this.rating=0,this.oneStarMode=false,this.size=15}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: oneStarMode?1:rating,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      ignoreGestures: ignoreGesture,
      itemCount: oneStarMode?1:5,
      itemSize: size,
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {
        print(rating);
      },
    );
  }
}
