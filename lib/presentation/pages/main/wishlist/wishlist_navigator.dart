import 'package:flutter/material.dart';
import 'package:triplaner/presentation/pages/authentication/login/login_navigator.dart';
import 'package:triplaner/presentation/pages/confirmation/confirmation_navigator.dart';
import 'package:triplaner/presentation/pages/main/site_detail/site_detail_navigator.dart';
import '../../../../../navigation/app_navigator.dart';
import '../../../../../util/dependency/app_dependency.dart';
import 'wishlist_page.dart';
import 'wishlist_cubit.dart';
import 'wishlist_initial_params.dart';



class WishlistNavigator with ConfirmationRoute,LoginRoute,SiteDetailRoute{
WishlistNavigator(this.navigator);

@override
late BuildContext context;

@override
late AppNavigator navigator;

}

mixin WishlistRoute {
openWishlist(WishlistInitialParams initialParams) {
navigator.push(
context,
WishlistPage(cubit: getIt(param1:initialParams),));
}

AppNavigator get navigator;

BuildContext get context;
}
