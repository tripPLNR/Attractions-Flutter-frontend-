import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:triplaner/util/alert/app_snackbar.dart';
import 'wishlist_initial_params.dart';
import 'wishlist_state.dart';
import 'wishlist_navigator.dart';


class WishlistCubit extends Cubit<WishlistState> {
WishlistNavigator navigator;
WishlistInitialParams initialParams;
AppSnackBar snackBar;
WishlistCubit({required this.navigator,required this.initialParams,required this.snackBar}) : super(WishlistState.initial(initialParams:initialParams));

BuildContext get context => navigator.context;
}
