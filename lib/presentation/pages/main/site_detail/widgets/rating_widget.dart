import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:triplaner/domain/entities/site.dart';
import 'package:triplaner/presentation/pages/main/site_detail/widgets/site_detail_heading.dart';
import 'package:triplaner/presentation/widgets/custom_star_rating.dart';
import 'package:triplaner/presentation/widgets/rating_bar.dart';
import 'package:triplaner/presentation/widgets/site_detail_divider.dart';
import 'package:triplaner/util/app_assets.dart';
import 'package:triplaner/util/app_style.dart';

class RatingWidget extends StatelessWidget {
  final Site site;

  const RatingWidget({Key? key, required this.site}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SiteDetailHeading(
              title:"Ratings & Reviews",
            ),
            Row(
              children: [
                CustomStarRating(
                  rating: site.totalRating??0,
                  size: 30,

                ),
                SizedBox(
                  width: 8.w,
                ),
                Text(
                  "${site.totalRating??0} ",
                  style: TextStyle(fontSize: 26.sp, fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.tertiaryContainer
                  ),
                ),
                Text(
                  "(${site.totalReviews??0} reviews)",
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.tertiaryContainer
                  ),
                ),
              ],
            ),
          ],
        ),
        const SiteDetailDivider(),
      ],
    );
  }
}
