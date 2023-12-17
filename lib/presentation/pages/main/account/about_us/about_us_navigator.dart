import 'package:flutter/material.dart';
import '../../../../../navigation/app_navigator.dart';
import '../../../../../util/dependency/app_dependency.dart';
import 'about_us_page.dart';
import 'about_us_cubit.dart';
import 'about_us_initial_params.dart';



class AboutUsNavigator {
AboutUsNavigator(this.navigator);

@override
late BuildContext context;

@override
late AppNavigator navigator;

}

mixin AboutUsRoute {
openAboutUs(AboutUsInitialParams initialParams) {
navigator.push(
context,
AboutUsPage(cubit: getIt(param1:initialParams),));
}

AppNavigator get navigator;

BuildContext get context;
}
