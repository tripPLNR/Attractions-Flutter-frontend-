import 'package:flutter/material.dart';
import 'package:triplaner/presentation/pages/main/bottom_navigation/bottom_navigation_navigator.dart';
import 'package:triplaner/presentation/pages/main/home/home_navigator.dart';

import '../../../../../navigation/app_navigator.dart';
import '../../../../../util/dependency/app_dependency.dart';
import 'splash_page.dart';
import 'splash_cubit.dart';
import 'splash_initial_params.dart';

class SplashNavigator with HomeRoute,BottomNavigationRoute {
  SplashNavigator(this.navigator);

  @override
  late BuildContext context;

  @override
  late AppNavigator navigator;
}

mixin SplashRoute {
  openSplash(SplashInitialParams initialParams) {
    navigator.push(
        context,
        SplashPage(
          cubit: getIt(param1: initialParams),
        ));
  }

  AppNavigator get navigator;

  BuildContext get context;
}
