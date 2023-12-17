import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TimeChip extends StatelessWidget {
  final String title;
  final String subTitle;
  final  bool isSelected;

  const TimeChip({Key? key,required this.title,required this.isSelected,required this.subTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.symmetric(vertical: 5.h,horizontal: 18.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(48.r),
        border: Border.all(
          color: isSelected?Theme.of(context).colorScheme.primary:
          Theme.of(context).colorScheme.secondary,
          width: isSelected?1:0
        )
      ),
      child: Column(
        children: [
          Text(title,style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: isSelected?Theme.of(context).primaryColor:null
          ),),
          Text(subTitle,style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: isSelected?Theme.of(context).colorScheme.onBackground:Theme.of(context).colorScheme.tertiaryContainer
          ),),

        ],
      ),
    );
  }
}
