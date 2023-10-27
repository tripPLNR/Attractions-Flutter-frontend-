import 'package:flutter/material.dart';
import '../../../../../navigation/app_navigator.dart';
import '../../../../../util/dependency/app_dependency.dart';
import 'site_detail_page.dart';
import 'site_detail_cubit.dart';
import 'site_detail_initial_params.dart';



class SiteDetailNavigator with SiteDetailRoute{
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
SiteDetailPage(cubit: getIt(param1:initialParams),));
}

AppNavigator get navigator;

BuildContext get context;
}
