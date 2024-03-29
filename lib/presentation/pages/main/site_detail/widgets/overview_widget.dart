import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:triplaner/domain/entities/site.dart';
import 'package:triplaner/presentation/widgets/site_detail_divider.dart';
import 'package:triplaner/util/app_style.dart';
import 'package:triplaner/presentation/widgets/custom_readmore.dart';

import 'site_detail_heading.dart';

class OverviewWidget extends StatelessWidget {
  final Site site;
  const OverviewWidget({Key? key,required this.site}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SiteDetailHeading(
              title:"Overview",
            ),
            Text(
             site.description?.trim()??"N/A", style: AppStyle.siteDetailSubHeading(context),
            ),
          ],
        ),
        const SiteDetailDivider(),
      ],
    );
  }
}
