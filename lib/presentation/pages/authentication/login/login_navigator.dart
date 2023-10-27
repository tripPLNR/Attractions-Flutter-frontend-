import 'package:flutter/material.dart';
import 'package:triplaner/presentation/pages/authentication/forget_password/forget_password_navigator.dart';
import 'package:triplaner/presentation/pages/authentication/signup/signup_navigator.dart';
import 'package:triplaner/presentation/pages/main/bottom_navigation/bottom_navigation_navigator.dart';
import '../../../../../navigation/app_navigator.dart';
import '../../../../../util/dependency/app_dependency.dart';
import 'login_page.dart';
import 'login_cubit.dart';
import 'login_initial_params.dart';

class LoginNavigator with SignupRoute,ForgetPasswordRoute,BottomNavigationRoute{
  LoginNavigator(this.navigator);

  @override
  late BuildContext context;

  @override
  late AppNavigator navigator;
}

mixin LoginRoute {
  openLogin(LoginInitialParams initialParams) {
    navigator.push(
        context,
        LoginPage(
          cubit: getIt(param1: initialParams),
        ));
  }

  AppNavigator get navigator;

  BuildContext get context;
}
