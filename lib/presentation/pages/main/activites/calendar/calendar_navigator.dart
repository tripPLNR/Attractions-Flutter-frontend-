import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../navigation/app_navigator.dart';
import '../../../../../util/dependency/app_dependency.dart';
import 'calendar_page.dart';
import 'calendar_cubit.dart';
import 'calendar_initial_params.dart';

class CalendarNavigator {
  CalendarNavigator(this.navigator);

  @override
  late BuildContext context;

  @override
  late AppNavigator navigator;
}

mixin CalendarRoute {
  openCalendar(CalendarInitialParams initialParams) {
    navigator.showBottomSheet(
        context,
        CalendarPage(
          cubit: getIt(param1: initialParams),
        ),
    height: 450.h
    );
  }

  AppNavigator get navigator;

  BuildContext get context;
}
