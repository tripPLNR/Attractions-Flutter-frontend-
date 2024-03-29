import 'package:flutter/material.dart';
import 'package:triplaner/presentation/pages/authentication/login/login_navigator.dart';
import '../../../../../navigation/app_navigator.dart';
import '../../../../../util/dependency/app_dependency.dart';
import 'change_password_page.dart';
import 'change_password_cubit.dart';
import 'change_password_initial_params.dart';



class ChangePasswordNavigator with LoginRoute{
ChangePasswordNavigator(this.navigator);

@override
late BuildContext context;

@override
late AppNavigator navigator;

}

mixin ChangePasswordRoute {
openChangePassword(ChangePasswordInitialParams initialParams) {
navigator.push(
context,
ChangePasswordPage(cubit: getIt(param1:initialParams),));
}

AppNavigator get navigator;

BuildContext get context;
}
