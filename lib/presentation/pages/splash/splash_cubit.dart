import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:triplaner/presentation/pages/main/bottom_navigation/bottom_navigation_initial_params.dart';
import 'package:triplaner/presentation/pages/main/home/home_initial_params.dart';
import 'package:triplaner/util/alert/app_snackbar.dart';
import '../../../domain/usecases/check_user_login_usecase.dart';
import 'splash_initial_params.dart';
import 'splash_state.dart';
import 'splash_navigator.dart';

class SplashCubit extends Cubit<SplashState> {
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
    _checkIfUserExists();
  }


  _checkIfUserExists() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      await checkUserLoginUseCase.execute();
      navigator.openBottomNavigation(const BottomNavigationInitialParams());

    }catch(e){
      emit(state.copyWith(loading: false));
      snackBar.show(context: context, info: e.toString());
    }
  }
}
