import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:triplaner/domain/entities/site.dart';
import 'package:triplaner/presentation/widgets/clock_hour_widget.dart';
import 'package:triplaner/presentation/widgets/price_widget.dart';
import 'package:triplaner/util/app_constant.dart';

import '../../../../../util/app_assets.dart';
import '../../../../widgets/custom_star_rating.dart';

class SiteDetailInfo extends StatelessWidget {
  final Site site;

  const SiteDetailInfo({Key? key, required this.site}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 12.h,
        ),
        Padding(
          padding: AppConstant.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${site.title}",
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w700,
                ),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
              site.isRefundAvailable()?
              Padding(
                padding: EdgeInsets.symmetric(vertical: 6.h),
                child: Text(
                  "free cancellation",
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.primary),
                ),
              )
                  : const SizedBox(),
              SizedBox(height: 4.h,),
              Row(
                children: [
                  CustomStarRating(
                    ignoreGesture: true,
                    rating: site.ratings?.ratings ?? 0,
                    size: 25.h,

                  ),
                  Text.rich(TextSpan(
                      text: " ${site.ratings?.ratings}",
                      style: TextStyle(
                        fontSize: 23.sp,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.tertiaryContainer,
                      ),
                      children: [
                        TextSpan(
                          text: "(${site.ratings?.reviewersCount} reviews)",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color:
                                Theme.of(context).colorScheme.tertiaryContainer,
                          ),
                        )
                      ])),
                ],
              ),
              SizedBox(
                height: 6.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClockAndHourWidget(
                    site: site,
                    clockSize: 14.h,
                    timeSize: 18.sp,
                  ),
                  PriceWidget(
                      fromSize: 16.sp,
                      priceSize: 27.sp,
                      priceWeight: FontWeight.w800,
                      fromWeight: FontWeight.w400,
                      price: "${site.basePrice}")
                ],
              ),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     Text(
              //       "from ",
              //       style: TextStyle(
              //         fontSize: 16.sp,
              //         fontWeight: FontWeight.w600,
              //         color: Theme.of(context).colorScheme.primary,
              //       ),
              //     ),
              //     Text(
              //       "\$${site.basePrice}",
              //       style: TextStyle(
              //         fontSize: 24.sp,
              //         fontWeight: FontWeight.bold,
              //         color: Theme.of(context).colorScheme.primary,
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
        SizedBox(
          height: 14.h,
        ),
      ],
    );
  }
}
