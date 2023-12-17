import 'package:flutter/material.dart';
import '../../../../../navigation/app_navigator.dart';
import '../../../../../util/dependency/app_dependency.dart';
import 'terms_of_use_page.dart';
import 'terms_of_use_cubit.dart';
import 'terms_of_use_initial_params.dart';



class TermsOfUseNavigator {
TermsOfUseNavigator(this.navigator);

@override
late BuildContext context;

@override
late AppNavigator navigator;

}

mixin TermsOfUseRoute {
openTermsOfUse(TermsOfUseInitialParams initialParams) {
navigator.push(
context,
TermsOfUsePage(cubit: getIt(param1:initialParams),));
}

AppNavigator get navigator;

BuildContext get context;
}
