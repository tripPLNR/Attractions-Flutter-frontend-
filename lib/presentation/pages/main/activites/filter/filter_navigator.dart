import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../navigation/app_navigator.dart';
import '../../../../../util/dependency/app_dependency.dart';
import 'filter_page.dart';
import 'filter_cubit.dart';
import 'filter_initial_params.dart';

class FilterNavigator {
  FilterNavigator(this.navigator);

  @override
  late BuildContext context;

  @override
  late AppNavigator navigator;
}

mixin FilterRoute {
  openFilter(FilterInitialParams initialParams) {
    navigator.showBottomSheet(
        context,
        FilterPage(
          cubit: getIt(param1: initialParams),
        ),
    height: 1.sh-100.h
    );
  }

  AppNavigator get navigator;

  BuildContext get context;
}
