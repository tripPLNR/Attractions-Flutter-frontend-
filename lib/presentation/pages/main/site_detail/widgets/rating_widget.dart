import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:triplaner/domain/entities/site.dart';
import 'package:triplaner/presentation/widgets/custom_star_rating.dart';
import 'package:triplaner/presentation/widgets/rating_bar.dart';
import 'package:triplaner/util/app_assets.dart';
import 'package:triplaner/util/app_style.dart';

class RatingWidget extends StatelessWidget {
  final Site site;

  const RatingWidget({Key? key, required this.site}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 22.h, bottom: 30.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Ratings & Reviews",
            style: AppStyle.headingH2(context),
          ),
          SizedBox(
            height: 12.h,
          ),
          Row(
            children: [
              CustomStarRating(
                rating: site.ratings?.ratings ??0,
                size: 30,
              ),
              SizedBox(
                width: 8.w,
              ),
              Text(
                "${site.ratings?.ratings} ",
                style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w700),
              ),
              Text(
                "(${site.ratings?.reviewersCount} reviews)",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
            ],
          )
        ],
      ),
    );
  }
}
