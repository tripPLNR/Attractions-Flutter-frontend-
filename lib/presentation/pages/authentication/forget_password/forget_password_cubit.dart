import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:triplaner/domain/repositories/auth_repository.dart';
import 'package:triplaner/util/alert/app_snackbar.dart';
import 'forget_password_initial_params.dart';
import 'forget_password_state.dart';
import 'forget_password_navigator.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordNavigator navigator;
  ForgetPasswordInitialParams initialParams;
  AppSnackBar snackBar;
  AuthRepository authRepository;

  ForgetPasswordCubit({
    required this.navigator,
    required this.initialParams,
    required this.snackBar,
    required this.authRepository,
  }) : super(ForgetPasswordState.initial(initialParams: initialParams));

  BuildContext get context => navigator.context;

  /// textField controller

  final txtEmail = TextEditingController();
  String email = "";

  _getValues() {
    email = txtEmail.text.trim();
  }

  bool _isEmpty() {
    if (email.isEmpty) {
      snackBar.show(
          context: navigator.context,
          info: "Please enter email address",
          snackBarType: SnackBarType.INFO);
      return true;
    }
    return false;
  }

  Future<void> forgetPasswordAction() async {
    _getValues();
    if (_isEmpty()) return;
    try {
      emit(state.copyWith(loading: true));
      await authRepository.forgetPassword(email: email);
      emit(state.copyWith(loading: false));
      Navigator.pop(context);
      snackBar.show(
          context: context,
          info: "Password reset link sent successfully",
          snackBarType: SnackBarType.SUCCESS);
    } catch (e) {
      emit(state.copyWith(loading: false));
      snackBar.show(context: context, info: e.toString());
    }
  }
}
