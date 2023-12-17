import 'package:flutter/material.dart';
import 'package:triplaner/presentation/pages/authentication/login/login_navigator.dart';
import 'package:triplaner/presentation/pages/confirmation/confirmation_navigator.dart';
import 'package:triplaner/presentation/pages/main/activites/calendar/calendar_navigator.dart';
import 'package:triplaner/presentation/pages/main/site_detail/check_availability/check_availability_navigator.dart';
import 'package:triplaner/presentation/pages/main/site_detail/reviews/reviews_navigator.dart';
import '../../../../../navigation/app_navigator.dart';
import '../../../../../util/dependency/app_dependency.dart';
import 'site_detail_page.dart';
import 'site_detail_cubit.dart';
import 'site_detail_initial_params.dart';

class SiteDetailNavigator with SiteDetailRoute,CheckAvailabilityRoute,ReviewsRoute,LoginRoute,ConfirmationRoute,CalendarRoute {
  SiteDetailNavigator(this.navigator);

  @override
  late BuildContext context;

  @override
  late AppNavigator navigator;
}

mixin SiteDetailRoute {
  openSiteDetail(SiteDetailInitialParams initialParams) {
    navigator.push(
        context,
        SiteDetailPage(
          cubit: getIt(param1: initialParams),
          key: UniqueKey(),
        ));
  }

  AppNavigator get navigator;

  BuildContext get context;
}
