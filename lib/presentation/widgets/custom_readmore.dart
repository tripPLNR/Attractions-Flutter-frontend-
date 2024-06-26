import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readmore/readmore.dart';

class CustomReadMore extends StatelessWidget {
  final String text;
  final int trimLines;
  final TextStyle? style;
  final Function(bool)? callback;
  const CustomReadMore(
      {Key? key, required this.text, this.trimLines = 2, this.style,this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      text,
      trimLines: trimLines,
      colorClickableText: Theme.of(context).primaryColor,
      style: style ??
          TextStyle(
              fontSize: 13.sp,
              color: Theme.of(context).colorScheme.tertiaryContainer,
              letterSpacing: 0),
      trimMode: TrimMode.Line,
      trimCollapsedText: 'Read more',
      trimExpandedText: ' Show less',
      callback:callback,
      moreStyle: TextStyle(
          fontSize: 13.sp,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).primaryColor),
      lessStyle: TextStyle(
          fontSize: 13.sp,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).primaryColor),
    );
  }
}
