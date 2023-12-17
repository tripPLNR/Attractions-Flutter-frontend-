import 'package:flutter/material.dart';
import '../../../../../navigation/app_navigator.dart';
import '../../../../../util/dependency/app_dependency.dart';
import 'check_availability_page.dart';
import 'check_availability_cubit.dart';
import 'check_availability_initial_params.dart';

class CheckAvailabilityNavigator {
  CheckAvailabilityNavigator(this.navigator);

  @override
  late BuildContext context;

  @override
  late AppNavigator navigator;
}

mixin CheckAvailabilityRoute {
  openCheckAvailability(CheckAvailabilityInitialParams initialParams) {
    navigator.showBottomSheet(
        context,
        CheckAvailabilityPage(
          cubit: getIt(param1: initialParams),
        ));
  }

  AppNavigator get navigator;

  BuildContext get context;
}
