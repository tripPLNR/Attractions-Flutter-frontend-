import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../util/app_colors.dart';
import 'custom_loader.dart';

class CustomButton extends StatelessWidget {
  String text;
  Function action;
  Color? color;
  double? width;
  double? height;
  bool isSecondaryButton;
  bool isDisabled;
  Color? textColor;
  Color? borderColor;
  String? iconPath;
  double? fontSize;
  double? borderRadius;

  bool isLoading;

  CustomButton(
      {Key? key,
      required this.text,
      required this.action,
      this.color,
      this.width,
      this.height,
      this.textColor,
      this.fontSize,
      this.isLoading = false,
      this.isDisabled = false,
      this.iconPath,
      this.borderColor,
      this.borderRadius,
      this.isSecondaryButton = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 1.sw,
      height: height ?? 60.h,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(borderRadius ?? 40.r),
          boxShadow: [
            BoxShadow(
              color: isSecondaryButton == true
                  ? Theme.of(context)
                      .colorScheme
                      .tertiaryContainer
                      .withOpacity(0.25)
                  : Theme.of(context).colorScheme.primary.withOpacity(0.25),
              spreadRadius: 0,
              blurRadius: 12,
              offset: const Offset(0, 4), // changes position of shadow
            ),
          ]),
      child: ElevatedButton(
        onPressed: () {
          if (isLoading || isDisabled) return;
          action();
        },
        style: ButtonStyle(
          elevation: MaterialStateProperty.all<double>(0.0),
          backgroundColor: color != null
              ? MaterialStateProperty.all<Color>(color!)
              : MaterialStateProperty.all<Color>(isSecondaryButton
                  ? Theme.of(context)
                      .colorScheme
                      .tertiaryContainer
                      .withOpacity(0.5)
                  : isDisabled
                      ? Theme.of(context).colorScheme.secondary.withOpacity(0.2)
                      : Theme.of(context).primaryColor),
          foregroundColor: MaterialStateProperty.all<Color>(
            textColor == null
                ? isSecondaryButton
                    ? Theme.of(context).colorScheme.onPrimary
                    : Theme.of(context).colorScheme.onPrimary
                : textColor!,
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius ?? 40.r),
                  side: BorderSide(
                      color: borderColor != null
                          ? borderColor!
                          : color != null
                              ? color!
                              : isDisabled
                                  ? Colors.transparent
                                  : isSecondaryButton
                                      ? Theme.of(context)
                                          .colorScheme
                                          .tertiaryContainer
                                          .withOpacity(0.5)
                                      : Theme.of(context).primaryColor,
                      width: 0))),
        ),
        child: isLoading
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: CustomLoader(
                  color: isSecondaryButton
                      ? Theme.of(context).colorScheme.onSecondary
                      : Theme.of(context).colorScheme.onPrimary,
                )),
              )
            : FittedBox(
                child: Row(
                  children: [
                    iconPath != null
                        ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            child: SvgPicture.asset(iconPath!),
                          )
                        : const SizedBox(),
                    Text(
                      text,
                      style: TextStyle(
                          fontSize: fontSize ?? 17.sp,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.1),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
