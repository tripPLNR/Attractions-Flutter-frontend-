import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:triplaner/presentation/base_cubit/base_cubit.dart';
import 'package:triplaner/presentation/base_cubit/internet_connectivity_cubit.dart';
import 'package:triplaner/presentation/pages/main/bottom_navigation/bottom_navigation_initial_params.dart';
import 'package:triplaner/presentation/pages/main/home/home_initial_params.dart';
import 'package:triplaner/presentation/pages/no_internet/no_internet_initial_params.dart';
import 'package:triplaner/util/alert/app_snackbar.dart';
import '../../../domain/usecases/check_user_login_usecase.dart';
import 'splash_initial_params.dart';
import 'splash_state.dart';
import 'splash_navigator.dart';

class SplashCubit extends BaseCubit<SplashState> with ConnectivityMixin {
  SplashNavigator navigator;
  SplashInitialParams initialParams;
  AppSnackBar snackBar;
  CheckUserLoginUseCase checkUserLoginUseCase;

  SplashCubit({
    required this.navigator,
    required this.initialParams,
    required this.snackBar,
    required this.checkUserLoginUseCase,
  }) : super(SplashState.initial(initialParams: initialParams));

  BuildContext get context => navigator.context;

  void onInit() {
    debugPrint("Splash Internet Listening started....");
    setupConnectivityListener();
    _checkIfUserExists();
  }

  _checkIfUserExists() async {
    try {
      if (state.loading) return;
      emit(state.copyWith(loading: true));
      ConnectivityResult result=await Connectivity().checkConnectivity();
      if(result==ConnectivityResult.none){
        emit(state.copyWith(loading: false));
        navigator.openNoInternet(const NoInternetInitialParams());
        return;
      }
      await Future.delayed(const Duration(seconds: 1));
      await checkUserLoginUseCase.execute();
      emit(state.copyWith(loading: false));
      close();
      navigator.openBottomNavigation(const BottomNavigationInitialParams());
    } catch (e) {
      emit(state.copyWith(loading: false));
      snackBar.show(context: context, info: e.toString());
    }
  }


  @override
  void onConnectivityChanged(bool isConnected) {
    if (isConnected) {
      _checkIfUserExists();
    } else {
      navigator.openNoInternet(const NoInternetInitialParams());
    }
  }


}
