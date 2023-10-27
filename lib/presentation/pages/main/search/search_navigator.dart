import 'package:flutter/material.dart';
import '../../../../../navigation/app_navigator.dart';
import '../../../../../util/dependency/app_dependency.dart';
import 'search_page.dart';
import 'search_cubit.dart';
import 'search_initial_params.dart';



class SearchNavigator {
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
SearchPage(cubit: getIt(param1:initialParams),));
}

AppNavigator get navigator;

BuildContext get context;
}
