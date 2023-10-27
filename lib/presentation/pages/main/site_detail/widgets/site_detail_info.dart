import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:triplaner/domain/entities/site.dart';
import 'package:triplaner/util/app_constant.dart';

import '../../../../../util/app_assets.dart';
import '../../../../widgets/custom_star_rating.dart';

class SiteDetailInfo extends StatelessWidget {
  final Site site;
  const SiteDetailInfo({Key? key,required this.site}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Column(
      children: [
        SizedBox(height: 12.h,),
        Padding(
          padding:AppConstant.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text("Day Trip",style: TextStyle(
              //     fontSize: 13.sp,
              //     fontWeight: FontWeight.w600,
              //     color: Theme.of(context).colorScheme.primary
              // ),),
              Text("${site.title}",style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w500,
              ),),
              Text("${site.location}",style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.tertiaryContainer
              ),),
              SizedBox(height: 8.h,),
              Row(
                children: [
                   CustomStarRating(
                    ignoreGesture: true,
                    rating: site.ratings?.ratings??0,
                  ),
                  Text(
                    " ${site.ratings?.ratings} (${site.ratings?.reviewersCount} reviews)",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).colorScheme.tertiaryContainer,
                    ),
                  ),
                  SizedBox(
                    height: 13.h,
                    child: VerticalDivider(thickness: 1,color: Theme.of(context).colorScheme.tertiaryContainer,),
                  ),
                  Text(
                    "Free cancellation",
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.primary),
                  )
                ],
              ),
              SizedBox(
                height: 3.h,
              ),
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
                            fontWeight: FontWeight.w500, fontSize: 14.sp),
                      )
                    ],
                  ),
                  Text(
                    "From ${site.currency} ${site.basePrice}",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 14.h,),
      ],
    );
  }
}
