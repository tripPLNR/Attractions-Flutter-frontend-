import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:triplaner/domain/entities/site.dart';
import 'package:triplaner/presentation/pages/main/site_detail/widgets/site_detail_heading.dart';
import 'package:triplaner/presentation/widgets/site_detail_divider.dart';
import 'package:triplaner/util/app_assets.dart';
import 'package:triplaner/util/app_style.dart';

class ExcludesWidget extends StatelessWidget {
  final Site site;
  const ExcludesWidget({Key? key,required this.site}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           const SiteDetailHeading(
              title: "Excludes",
            ),
            for (var exclusion in site.exclusions!)
              Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:  EdgeInsets.only(top: 5.h),
                      child: SvgPicture.asset(
                        AppAssets.excludes,
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
                          exclusion,
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
