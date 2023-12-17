import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:intl/intl.dart';

import '../../util/app_colors.dart';
import '../../util/app_style.dart';

class CustomTextField extends StatelessWidget {
  TextEditingController controller;
  String? label;
  String hint;
  Function(String)? onChange;
  Function(String)? onSubmit;

  VoidCallback? onTap;

  bool? dealAsDate;
  bool? dealAsTime;
  bool? hide;
  bool? readOnly;
  bool? disable;

  String? suffixPath;
  String? prefixPath;
  bool? countryPicker;
  bool? genderPicker;
  double? bottomPadding;
  String? initialValue;
  bool? isDetail;
  double? height;
  bool autoFocus;

  double? width;

  double? prefixHeight;
  double? suffixHeight;
  Color? suffixColor;
  bool showCurrentCharacters;
  TextInputType? keyboard;

  List<TextInputFormatter>? inputFormatters;
  Function? suffixAction;

  CustomTextField(
      {Key? key,
      required this.controller,
      this.label,
      required this.hint,
      this.onChange,
      this.onSubmit,
      this.onTap,
      this.height,
      this.width,
      this.initialValue,
      this.prefixPath,
      this.readOnly,
      this.bottomPadding,
      this.dealAsDate,
      this.dealAsTime,
      this.inputFormatters,
      this.showCurrentCharacters = false,
      this.autoFocus = false,

      this.disable,
      this.isDetail,
      this.keyboard,
      this.countryPicker,
      this.genderPicker,
      this.hide,
      this.prefixHeight,
      this.suffixHeight,
      this.suffixColor,
      this.suffixAction,
      this.suffixPath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding ?? 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label ?? "",
            style: AppStyle.textFieldLabelStyle(context),
          ),
          SizedBox(
            height: 8.h,
          ),
          Container(
            height: isDetail != null ? 82.h : null,
            width: width ?? 1.sw,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(40.r),
                border: Border.all(
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.5))),
            child: TextFormField(
              controller: controller,
              initialValue: initialValue,
              textAlignVertical: TextAlignVertical.top,
              expands: isDetail != null ? true : false,
              onChanged: onChange,
              onFieldSubmitted: onSubmit,
              autofocus: autoFocus,
              inputFormatters: inputFormatters,
              style: AppStyle.textFieldTextStyle(context),
              onTap: () {
                if (dealAsDate == true) {
                  _selectDate(context);
                }
                if (dealAsTime == true) {
                  _selectTime(context);
                }

                if (onTap != null) {
                  onTap!();
                }
              },
              keyboardType: keyboard ?? TextInputType.text,
              maxLines: isDetail != null ? null : 1,
              readOnly: disable ??
                  dealAsDate ??
                  dealAsTime ??
                  countryPicker ??
                  genderPicker ??
                  readOnly ??
                  false,
              obscureText: hide ?? false,
              cursorColor: AppColors.primaryColor,
              decoration: InputDecoration(
                hintStyle: AppStyle.textFieldHintStyle(context),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintText: hint,
                isDense: true,
                filled: disable == true ? true : false,
                fillColor: disable == true
                    ? Theme.of(context).colorScheme.secondary.withOpacity(0.4)
                    : Theme.of(context).colorScheme.surface,
                contentPadding: isDetail != null
                    ? EdgeInsets.all(15.h)
                    : EdgeInsets.symmetric(vertical: 16.h),
                enabledBorder: unFocusedBorder(context),
                focusedBorder: borderStyle(context, isActive: true),
                prefixIcon: isDetail == true
                    ? null
                    : prefixPath == null
                        ? SizedBox(
                            width: 15.w,
                          )
                        : Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            child: SvgPicture.asset(
                              prefixPath!,
                              color: Theme.of(context)
                                  .colorScheme
                                  .tertiaryContainer,
                            ),
                          ),
                prefixIconConstraints: BoxConstraints(
                  maxHeight: prefixHeight ?? 75.h,
                  maxWidth: prefixHeight ?? 75.h,
                ),
                suffixIcon: suffixPath == null
                    ? SizedBox(
                        width: 5.w,
                      )
                    : GestureDetector(
                        onTap: () {
                          if (suffixAction != null) {
                            suffixAction!();
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.only(right: 20.w),
                          child: SvgPicture.asset(
                            suffixPath!,
                            color: Theme.of(context)
                                .colorScheme
                                .tertiaryContainer,
                          ),
                        ),
                      ),
                suffixIconConstraints: BoxConstraints(
                  maxHeight: suffixHeight ?? 45.h,
                  maxWidth: suffixHeight ?? 45.h,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _selectDate(BuildContext context) async {
    DateTime? newSelectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2040),
        builder: (BuildContext context, child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.light(
                primary: AppColors.whiteColor, // header background color
                onPrimary: AppColors.blackColor, // header text color
                onSurface: AppColors.whiteColor, // body text color
              ),
              dialogBackgroundColor: AppColors.primaryColor,
            ),
            child: child!,
          );
        });

    if (newSelectedDate != null) {
      controller.text = DateFormat('yyyy-MM-dd').format(newSelectedDate);
    }
  }

  _selectTime(BuildContext context) async {
    TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext context, child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              dialogBackgroundColor: AppColors.primaryColor,
            ),
            child: child!,
          );
        });

    if (selectedTime != null) {
      String formattedTime = DateFormat('hh:mm:ss').format(
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day,
            selectedTime.hour, selectedTime.minute),
      );
      controller.text = formattedTime;
    }
  }
}

borderStyle(BuildContext context, {bool isActive = false}) {
  return OutlineInputBorder(
      borderSide:
          BorderSide(color: Theme.of(context).colorScheme.surface, width: 1),
      borderRadius: BorderRadius.circular(40.r));
}

unFocusedBorder(BuildContext context, {bool isActive = false}) {
  return OutlineInputBorder(
      borderSide:
          BorderSide(color: Theme.of(context).colorScheme.surface, width: 1),
      borderRadius: BorderRadius.circular(40.r));
}
