import 'package:flutter/material.dart';
import 'package:triplaner/presentation/pages/authentication/login/login_navigator.dart';
import 'package:triplaner/presentation/pages/confirmation/confirmation_navigator.dart';
import 'package:triplaner/presentation/pages/main/activites/activities_navigator.dart';
import 'package:triplaner/presentation/pages/main/destination_detail/destination_detail_navigator.dart';
import 'package:triplaner/presentation/pages/main/site_detail/site_detail_navigator.dart';
import 'package:triplaner/presentation/pages/no_internet/no_internet_navigator.dart';
import '../../../../../navigation/app_navigator.dart';
import '../../../../../util/dependency/app_dependency.dart';
import 'home_page.dart';
import 'home_cubit.dart';
import 'home_initial_params.dart';

class HomeNavigator
    with
        DestinationDetailRoute,
        ActivitiesRoute,
        ActivitiesRoute,
        SiteDetailRoute,
        ConfirmationRoute,
        LoginRoute,
        NoInternetRoute
{
  HomeNavigator(this.navigator);

  @override
  late BuildContext context;

  @override
  late AppNavigator navigator;
}

mixin HomeRoute {
  openHome(HomeInitialParams initialParams) {
    navigator.push(
        context,
        HomePage(
          cubit: getIt(param1: initialParams),
        ));
  }

  AppNavigator get navigator;

  BuildContext get context;
}
