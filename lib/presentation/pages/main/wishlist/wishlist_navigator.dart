import 'package:flutter/material.dart';
import '../../../../../navigation/app_navigator.dart';
import '../../../../../util/dependency/app_dependency.dart';
import 'wishlist_page.dart';
import 'wishlist_cubit.dart';
import 'wishlist_initial_params.dart';



class WishlistNavigator {
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
