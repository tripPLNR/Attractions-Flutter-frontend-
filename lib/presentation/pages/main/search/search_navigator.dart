import 'package:flutter/material.dart';
import 'package:triplaner/presentation/pages/authentication/login/login_navigator.dart';
import 'package:triplaner/presentation/pages/confirmation/confirmation_navigator.dart';
import 'package:triplaner/presentation/pages/main/activites/activities_navigator.dart';
import 'package:triplaner/presentation/pages/main/site_detail/site_detail_navigator.dart';
import '../../../../../navigation/app_navigator.dart';
import '../../../../../util/dependency/app_dependency.dart';
import 'search_page.dart';
import 'search_cubit.dart';
import 'search_initial_params.dart';

class SearchNavigator with ActivitiesRoute,ConfirmationRoute,LoginRoute,SiteDetailRoute {
  SearchNavigator(this.navigator);

  @override
  late BuildContext context;

  @override
  late AppNavigator navigator;
}

mixin SearchRoute {
  openSearch(SearchInitialParams initialParams) {
    navigator.push(
        context,
        SearchPage(
          cubit: getIt(param1: initialParams),
        ));
  }

  AppNavigator get navigator;

  BuildContext get context;
}
