import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:triplaner/domain/entities/site.dart';
import 'package:triplaner/util/app_assets.dart';

class ClockAndHourWidget extends StatelessWidget {
  final Site site;
   double? clockSize;
   double? timeSize;

   ClockAndHourWidget({Key? key,required this.site,this.clockSize=18,this.timeSize=15}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        SvgPicture.asset(
          AppAssets.clock,
          height: clockSize,
          color: Theme.of(context).colorScheme.tertiaryContainer,
        ),
        SizedBox(
          width: 4.w,
        ),
        Text(
          "${site.durationHours??0} hours",
          style: TextStyle(
              fontWeight: FontWeight.w600,
            fontSize: timeSize,
            color: Theme.of(context).colorScheme.tertiaryContainer,
          ),
        )
      ],
    );
  }
}
