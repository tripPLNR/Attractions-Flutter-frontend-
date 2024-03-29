import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:triplaner/presentation/widgets/custom_horizontal_date_picker.dart';
import 'package:triplaner/presentation/widgets/custom_loader.dart';
import 'package:triplaner/presentation/widgets/site_detail_divider.dart';
import 'package:triplaner/util/app_assets.dart';
import 'package:triplaner/util/app_extentions.dart';
import 'package:triplaner/util/app_style.dart';

import 'site_detail_heading.dart';

class CheckAvailabilityWidget extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateSelect;
  final EasyInfiniteDateTimelineController controller;
  final VoidCallback onCustomDatePicker;
  final VoidCallback? onClear;
  final bool isAvailable;
  final bool isLoading;

  const CheckAvailabilityWidget({Key? key,required this.selectedDate,required this.onDateSelect,required this.onCustomDatePicker,this.onClear,required this.isAvailable,required this.isLoading,required this.controller,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SiteDetailHeading(
              title:"Check Availability",
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Select Date",style: TextStyle(fontSize: 17.sp,fontWeight: FontWeight.w600),),
                isLoading?Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomLoader(),
                  ],
                ):
                Expanded(child: Align(
                    alignment: selectedDate.isToday()?Alignment.centerRight:Alignment.center,
                    child:
                    Text(isAvailable?"Available":"Not Available",style: TextStyle(fontSize: 17.sp,fontWeight: FontWeight.w600,color: Theme.of(context).colorScheme.primary),))),
                selectedDate.isToday()?const SizedBox():
                GestureDetector(
                    onTap: onClear,
                    child: Text("Clear",style: TextStyle(fontSize: 17.sp,fontWeight: FontWeight.w600,),)),
              ],
            ),
            SizedBox(height: 18.h,),
            Row(
              children: [
                GestureDetector(
                    onTap: onCustomDatePicker,
                    child: SvgPicture.asset(AppAssets.moreCalendar,height: 55.h,width: 55.h,)),
                SizedBox(width: 5.w,),

                Expanded(child: CustomHorizontalDatePicker(
                  selectedDate: selectedDate,
                  onDateSelect:onDateSelect,
                  // controller: controller,
                )),
              ],
            ),
          ],
        ),
        const SiteDetailDivider(),
      ],
    );
  }
}
