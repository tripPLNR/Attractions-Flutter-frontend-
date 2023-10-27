import 'package:flutter/material.dart';
import 'package:triplaner/presentation/pages/main/activites/activities_navigator.dart';
import 'package:triplaner/presentation/pages/main/site_detail/site_detail_navigator.dart';
import '../../../../../navigation/app_navigator.dart';
import '../../../../../util/dependency/app_dependency.dart';
import 'destination_detail_page.dart';
import 'destination_detail_cubit.dart';
import 'destination_detail_initial_params.dart';

class DestinationDetailNavigator with SiteDetailRoute,ActivitiesRoute {
  DestinationDetailNavigator(this.navigator);

  @override
  late BuildContext context;

  @override
  late AppNavigator navigator;
}

mixin DestinationDetailRoute {
  openDestinationDetail(DestinationDetailInitialParams initialParams) {
    navigator.push(
        context,
        DestinationDetailPage(
          cubit: getIt(param1: initialParams),
        ));
  }

  AppNavigator get navigator;

  BuildContext get context;
}
