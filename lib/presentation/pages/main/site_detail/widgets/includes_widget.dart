import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:triplaner/domain/entities/site.dart';
import 'package:triplaner/presentation/pages/main/site_detail/widgets/site_detail_heading.dart';
import 'package:triplaner/presentation/widgets/site_detail_divider.dart';
import 'package:triplaner/util/app_assets.dart';
import 'package:triplaner/util/app_style.dart';

class IncludesWidget extends StatelessWidget {
  final Site site;

  const IncludesWidget({Key? key, required this.site}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SiteDetailHeading(
              title:"Includes",
            ),
            for (var inclusion in site.inclusions!)
              Padding(
                padding:  EdgeInsets.only(top: 5.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:  EdgeInsets.only(top: 7.h),
                      child: SvgPicture.asset(
                        AppAssets.includes,
                        height: 24.h,
                        width: 24.w,
                      ),
                    ),
                    SizedBox(
                      width: 6.w,
                    ),
                    SizedBox(
                        width: 1.sw - 80.w,
                        child: Text(
                          inclusion,
                          style: AppStyle.siteDetailSubHeading(context),
                        )),
                  ],
                ),
              ),
          ],
        ),
        const SiteDetailDivider(),
      ],
    );
  }
}
