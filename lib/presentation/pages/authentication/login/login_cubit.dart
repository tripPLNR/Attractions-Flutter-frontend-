import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:triplaner/domain/usecases/login_usecase.dart';
import 'package:triplaner/presentation/pages/authentication/forget_password/forget_password_initial_params.dart';
import 'package:triplaner/presentation/pages/authentication/signup/signup_initial_params.dart';
import 'package:triplaner/presentation/pages/main/bottom_navigation/bottom_navigation_initial_params.dart';
import 'package:triplaner/util/alert/app_snackbar.dart';
import 'login_initial_params.dart';
import 'login_state.dart';
import 'login_navigator.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginNavigator navigator;
  LoginInitialParams initialParams;
  AppSnackBar snackBar;
  LoginUseCase loginUseCase;
  LoginCubit(
      {required this.navigator,
      required this.initialParams,
      required this.snackBar,
      required this.loginUseCase,

      })
      : super(LoginState.initial(initialParams: initialParams));

  BuildContext get context => navigator.context;

  /// textField controller

  final txtEmail = TextEditingController();
  final txtPassword = TextEditingController();

  String email = "", password = "";

  _getValues(){
    email=txtEmail.text.trim();
    password=txtPassword.text;
  }

  bool _isEmpty() {
    if (email.isEmpty || password.isEmpty) {
      snackBar.show(
          context: navigator.context, info: "Please enter email & password",snackBarType: SnackBarType.INFO);
      return true;
    }
    return false;
  }

  Future<void> loginAction() async {
    _getValues();
    if(_isEmpty())return;
    try{
      emit(state.copyWith(loading: true));
      await loginUseCase.execute(email: email, password: password);
      emit(state.copyWith(loading: false));
      navigator.openBottomNavigation(const BottomNavigationInitialParams());
    }catch(e){
      emit(state.copyWith(loading: false));
      snackBar.show(context: context, info: e.toString());
    }
  }

  void socialLoginAction(){
    if(Platform.isAndroid){
      _googleLoginAction();
    }else{
      _appleLoginAction();
    }
  }
  _googleLoginAction() async {
    try{
      emit(state.copyWith(socialLogging: true));
      await loginUseCase.execute(email: "", password: "",isGoogle: true);
      emit(state.copyWith(socialLogging: false));
      navigator.openBottomNavigation(const BottomNavigationInitialParams());
    }catch(e){
      emit(state.copyWith(socialLogging: false));
      snackBar.show(context: context, info: e.toString());
    }
  }

  _appleLoginAction() async {
    try{
      emit(state.copyWith(socialLogging: true));
      await loginUseCase.execute(email: "", password: "",isApple: true);
      emit(state.copyWith(socialLogging: false));
      navigator.openBottomNavigation(const BottomNavigationInitialParams());
    }catch(e){
      emit(state.copyWith(socialLogging: false));
      snackBar.show(context: context, info: e.toString());
    }
  }

  togglePassword() {
    debugPrint("tapped");
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  signupAction() {
    navigator.openSignup(const SignupInitialParams());
  }

  forgetAction() {
    navigator.openForgetPassword(const ForgetPasswordInitialParams());
  }
}
