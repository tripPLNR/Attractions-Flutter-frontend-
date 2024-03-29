import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:triplaner/domain/entities/site.dart';
import 'package:triplaner/presentation/pages/main/site_detail/widgets/site_detail_heading.dart';
import 'package:triplaner/presentation/widgets/site_detail_divider.dart';
import 'package:triplaner/util/app_style.dart';

class CancellationPolicyWidget extends StatelessWidget {
  final Site site;
  const CancellationPolicyWidget({Key? key,required this.site}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SiteDetailHeading(
              title:"Cancellation Policy",
            ),
            Text(
              site.isRefundAvailable()
                  ? "You can cancel these tickets up to 24 hours before the activity starts to get full refund."
                  : "These tickets can't be cancelled or rescheduled.",
              style: AppStyle.siteDetailSubHeading(context),
            ),
          ],
        ),
        const SiteDetailDivider(),
      ],
    );
  }
}
