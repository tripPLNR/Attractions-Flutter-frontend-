import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:triplaner/presentation/widgets/custom_horizontal_date_picker.dart';
import 'package:triplaner/util/app_assets.dart';
import 'package:triplaner/util/app_extentions.dart';
import 'package:triplaner/util/app_style.dart';

class CheckAvailabilityWidget extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateSelect;
  final VoidCallback onCustomDatePicker;
  final VoidCallback? onClear;

  const CheckAvailabilityWidget({Key? key,required this.selectedDate,required this.onDateSelect,required this.onCustomDatePicker,this.onClear}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 22.h,bottom: 30.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Check Availability",
                style: AppStyle.siteDetailHeading(context),
              ),
              SizedBox(height: 12.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Select Date",style: TextStyle(fontSize: 17.sp,fontWeight: FontWeight.w600),),
                  Expanded(child: Align(
                      alignment: selectedDate.isToday()?Alignment.centerRight:Alignment.center,
                      child: Text("Available",style: TextStyle(fontSize: 17.sp,fontWeight: FontWeight.w600,color: Theme.of(context).colorScheme.primary),))),
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
                  SizedBox(width: 10.w,),
                  Expanded(child: CustomHorizontalDatePicker(
                    selectedDate: selectedDate,
                    onDateSelect:onDateSelect,
                  )),
                ],
              ),
            ],
          ),
        ),
        const Divider(
          thickness: 1,
          height: 0,
        ),
      ],
    );
  }
}
