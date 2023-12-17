import 'package:flutter/material.dart';
import 'package:triplaner/presentation/pages/authentication/login/login_navigator.dart';
import 'package:triplaner/presentation/pages/confirmation/confirmation_navigator.dart';
import 'package:triplaner/presentation/pages/main/activites/calendar/calendar_navigator.dart';
import 'package:triplaner/presentation/pages/main/activites/filter/filter_navigator.dart';
import 'package:triplaner/presentation/pages/main/site_detail/site_detail_navigator.dart';
import '../../../../../navigation/app_navigator.dart';
import '../../../../../util/dependency/app_dependency.dart';
import 'activities_page.dart';
import 'activities_cubit.dart';
import 'activities_initial_params.dart';

class ActivitiesNavigator with SiteDetailRoute,FilterRoute,CalendarRoute,ConfirmationRoute,LoginRoute {
  ActivitiesNavigator(this.navigator);

  @override
  late BuildContext context;

  @override
  late AppNavigator navigator;
}

mixin ActivitiesRoute {
  openActivities(ActivitiesInitialParams initialParams) {
    navigator.push(
        context,
        ActivitiesPage(
          cubit: getIt(param1: initialParams),
        ));
  }

  AppNavigator get navigator;

  BuildContext get context;
}
