import 'package:flutter/material.dart';
import 'package:triplaner/presentation/pages/authentication/login/login_navigator.dart';
import 'package:triplaner/presentation/pages/main/bottom_navigation/bottom_navigation_navigator.dart';
import '../../../../../navigation/app_navigator.dart';
import '../../../../../util/dependency/app_dependency.dart';
import 'signup_page.dart';
import 'signup_cubit.dart';
import 'signup_initial_params.dart';



class SignupNavigator with LoginRoute,BottomNavigationRoute{
SignupNavigator(this.navigator);

@override
late BuildContext context;

@override
late AppNavigator navigator;

}

mixin SignupRoute {
openSignup(SignupInitialParams initialParams) {
navigator.push(
context,
SignupPage(cubit: getIt(param1:initialParams),));
}

AppNavigator get navigator;

BuildContext get context;
}
