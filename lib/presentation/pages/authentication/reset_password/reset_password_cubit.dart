import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:triplaner/domain/repositories/auth_repository.dart';
import 'package:triplaner/presentation/base_cubit/base_cubit.dart';
import 'package:triplaner/util/alert/app_snackbar.dart';
import 'reset_password_initial_params.dart';
import 'reset_password_state.dart';
import 'reset_password_navigator.dart';

class ResetPasswordCubit extends BaseCubit<ResetPasswordState> {
  ResetPasswordNavigator navigator;
  ResetPasswordInitialParams initialParams;
  AuthRepository authRepository;
  AppSnackBar snackBar;

  ResetPasswordCubit({
    required this.navigator,
    required this.initialParams,
    required this.authRepository,
    required this.snackBar,
  }) : super(ResetPasswordState.initial(initialParams: initialParams));

  BuildContext get context => navigator.context;

  final txtNewPassword = TextEditingController();
  final txtConfirmNewPassword = TextEditingController();

  String newPassword = "", confirmNewPassword = "";

  _getValues() {
    newPassword = txtNewPassword.text;
    confirmNewPassword = txtConfirmNewPassword.text;
  }

  bool _isEmpty() {
    if (newPassword.isEmpty || confirmNewPassword.isEmpty) {
      snackBar.show(
          context: context,
          info: "Please fill all fields.",
          snackBarType: SnackBarType.INFO);
      return true;
    }
    return false;
  }

  bool _isPasswordMatches() {
    if (newPassword != confirmNewPassword) {
      snackBar.show(
          context: context,
          info: "Password does not matches.",
          snackBarType: SnackBarType.INFO);
      return false;
    }
    return true;
  }

  togglePasswordVisibility() {
    emit(state.copyWith(hidePassword: !state.hidePassword));
  }

  resetPassword() async {
    try {
      _getValues();
      if (_isEmpty()) return;
      if (!_isPasswordMatches()) return;

      emit(state.copyWith(loading: true));
      await authRepository.resetPassword(
        userId: initialParams.userId,
        confirmPassword: newPassword,
        newPassword: newPassword,
      );
      snackBar.show(
          context: context,
          info: "Password reset successfully",
          snackBarType: SnackBarType.SUCCESS);

      /// pop 2 times to login page
      Navigator.of(context)
        ..pop()
        ..pop();
    } catch (e) {
      handleException(e.toString(), context);
    } finally {
      emit(state.copyWith(loading: false));
    }
  }
}
