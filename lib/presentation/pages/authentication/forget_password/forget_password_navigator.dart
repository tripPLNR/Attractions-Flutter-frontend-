import 'package:flutter/material.dart';
import '../../../../../navigation/app_navigator.dart';
import '../../../../../util/dependency/app_dependency.dart';
import 'forget_password_page.dart';
import 'forget_password_cubit.dart';
import 'forget_password_initial_params.dart';



class ForgetPasswordNavigator {
ForgetPasswordNavigator(this.navigator);

@override
late BuildContext context;

@override
late AppNavigator navigator;

}

mixin ForgetPasswordRoute {
openForgetPassword(ForgetPasswordInitialParams initialParams) {
navigator.push(
context,
ForgetPasswordPage(cubit: getIt(param1:initialParams),));
}

AppNavigator get navigator;

BuildContext get context;
}
