import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

import '../../util/app_style.dart';
import '../pages/authentication/login/login_page.dart';

class OtpTextField extends StatelessWidget {
  Function(String) onSubmit;

  OtpTextField({Key? key, required this.onSubmit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 50.w,
      height: 50.h,
      textStyle: AppStyle.textFieldTextStyle(context),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: Theme.of(context).dividerColor, width: 1),
      ),
      margin: EdgeInsets.only(bottom: 20.h)
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Theme.of(context).dividerColor, width: 1),
      borderRadius: BorderRadius.circular(15.r),
    );

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Pinput(
        defaultPinTheme: defaultPinTheme,
        focusedPinTheme: focusedPinTheme,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        scrollPadding: EdgeInsets.only(bottom: 250.h),
        // validator: (s) {
        //   return s == '2222' ? null : 'Pin is incorrect';
        // },
        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
        showCursor: true,
        onChanged: onSubmit,
        length: 6,
      ),
    );
  }
}
