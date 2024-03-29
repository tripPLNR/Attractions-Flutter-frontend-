import 'package:flutter/material.dart';
import '../../../../../navigation/app_navigator.dart';
import '../../../../../util/dependency/app_dependency.dart';
import '../reset_password/reset_password_navigator.dart';
import 'otp_page.dart';
import 'otp_cubit.dart';
import 'otp_initial_params.dart';

class OtpNavigator with ResetPasswordRoute{
  OtpNavigator(this.navigator);

  @override
  late BuildContext context;

  @override
  late AppNavigator navigator;
}

mixin OtpRoute {
  openOtp(OtpInitialParams initialParams) {
    navigator.push(
        context,
        OtpPage(
          cubit: getIt(param1: initialParams),
        ));
  }

  AppNavigator get navigator;

  BuildContext get context;
}
