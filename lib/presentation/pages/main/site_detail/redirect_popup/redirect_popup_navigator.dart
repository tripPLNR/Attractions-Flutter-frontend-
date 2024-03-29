import 'package:flutter/material.dart';
import '../../../../../navigation/app_navigator.dart';
import '../../../../../util/dependency/app_dependency.dart';
import 'redirect_popup_page.dart';
import 'redirect_popup_cubit.dart';
import 'redirect_popup_initial_params.dart';

class RedirectPopupNavigator {
  RedirectPopupNavigator(this.navigator);

  @override
  late BuildContext context;

  @override
  late AppNavigator navigator;
}

mixin RedirectPopupRoute {
  openRedirectPopup(RedirectPopupInitialParams initialParams) {
    navigator.showDialogBox(
        context,
        RedirectPopupPage(
          cubit: getIt(param1: initialParams),
        ));
  }

  AppNavigator get navigator;

  BuildContext get context;
}
