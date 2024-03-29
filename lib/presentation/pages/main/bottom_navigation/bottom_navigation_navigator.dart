import 'package:flutter/material.dart';
import 'package:triplaner/presentation/pages/main/site_detail/site_detail_navigator.dart';
import 'package:triplaner/presentation/pages/no_internet/no_internet_navigator.dart';
import '../../../../../navigation/app_navigator.dart';
import '../../../../../util/dependency/app_dependency.dart';
import 'bottom_navigation_page.dart';
import 'bottom_navigation_cubit.dart';
import 'bottom_navigation_initial_params.dart';

class BottomNavigationNavigator with NoInternetRoute,SiteDetailRoute{
  BottomNavigationNavigator(this.navigator);

  @override
  late BuildContext context;

  @override
  late AppNavigator navigator;
}

mixin BottomNavigationRoute {
  openBottomNavigation(BottomNavigationInitialParams initialParams) {
    navigator.pushAndClearAllPrevious(
        context,
        BottomNavigationPage(
          cubit: getIt(param1: initialParams),
        ));
  }

  AppNavigator get navigator;

  BuildContext get context;
}
