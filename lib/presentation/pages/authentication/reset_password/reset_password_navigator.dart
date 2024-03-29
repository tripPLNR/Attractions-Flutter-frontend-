import 'package:flutter/material.dart';
import '../../../../../navigation/app_navigator.dart';
import '../../../../../util/dependency/app_dependency.dart';
import 'reset_password_page.dart';
import 'reset_password_cubit.dart';
import 'reset_password_initial_params.dart';

class ResetPasswordNavigator {
  ResetPasswordNavigator(this.navigator);

  @override
  late BuildContext context;

  @override
  late AppNavigator navigator;
}

mixin ResetPasswordRoute {
  openResetPassword(ResetPasswordInitialParams initialParams) {
    navigator.replace(
        context,
        ResetPasswordPage(
          cubit: getIt(param1: initialParams),
        ));
  }

  AppNavigator get navigator;

  BuildContext get context;
}
