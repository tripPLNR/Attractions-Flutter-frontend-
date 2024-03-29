import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../navigation/app_navigator.dart';
import '../../../../../util/dependency/app_dependency.dart';
import 'currencies_page.dart';
import 'currencies_cubit.dart';
import 'currencies_initial_params.dart';

class CurrenciesNavigator {
  CurrenciesNavigator(this.navigator);

  @override
  late BuildContext context;

  @override
  late AppNavigator navigator;
}

mixin CurrenciesRoute {
  openCurrencies(CurrenciesInitialParams initialParams) {
    navigator.showBottomSheet(
        context,
        CurrenciesPage(
          cubit: getIt(param1: initialParams),
        ),
    height: 470.h
    );
  }

  AppNavigator get navigator;

  BuildContext get context;
}
