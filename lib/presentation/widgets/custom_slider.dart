import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_xlider/flutter_xlider.dart';

class CustomSlider extends StatelessWidget {
  final Function(double min,double max) onChange;
  final double min;
  final double max;

  const CustomSlider({Key? key,required this.onChange,required this.min,required this.max}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("Min",style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w700
        ),),
        Expanded(
          child: FlutterSlider(
            values:  [min, max],
            rangeSlider: true,
            max: 10000,
            min: 0,
            step: const FlutterSliderStep(step: 100),
            jump: true,

            trackBar: FlutterSliderTrackBar(
              activeTrackBarHeight: 6,
              activeTrackBar: BoxDecoration(color: Theme.of(context).colorScheme.primary),
            ),
            tooltip: FlutterSliderTooltip(
              textStyle: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w600),
            ),
            handler:customHandler(context),
            rightHandler: customHandler(context),
            disabled: false,
            onDragging: (handlerIndex, lowerValue, upperValue) {
              onChange(lowerValue,upperValue);
            },
          ),
        ),
        Text("Max",style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w700
        ),),
      ],
    );
  }

  FlutterSliderHandler customHandler(BuildContext context){
    return FlutterSliderHandler(
      decoration: const BoxDecoration(),
      child: Container(
        height: 20.h,
        width: 20.h,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: Theme.of(context).colorScheme.primary,
            width: 3
          )
        ),
        padding: EdgeInsets.all(5),
      ),
    );
  }
}
