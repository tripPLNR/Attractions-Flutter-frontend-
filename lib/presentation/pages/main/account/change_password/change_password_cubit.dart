import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:triplaner/domain/repositories/database_repository.dart';
import 'package:triplaner/presentation/base_cubit/base_cubit.dart';
import 'package:triplaner/presentation/pages/authentication/login/login_initial_params.dart';
import 'package:triplaner/util/alert/app_snackbar.dart';
import '../../../../../domain/usecases/change_password_usecase.dart';
import 'change_password_initial_params.dart';
import 'change_password_state.dart';
import 'change_password_navigator.dart';

class ChangePasswordCubit extends BaseCubit<ChangePasswordState> {
  ChangePasswordNavigator navigator;
  ChangePasswordInitialParams initialParams;
  AppSnackBar snackBar;
  ChangePasswordUseCase changePasswordUseCase;

  ChangePasswordCubit(
      {required this.navigator,
      required this.initialParams,
      required this.snackBar,
      required this.changePasswordUseCase})
      : super(ChangePasswordState.initial(initialParams: initialParams));

  BuildContext get context => navigator.context;

  final txtCurrentPassword = TextEditingController();
  final txtNewPassword = TextEditingController();
  final txtConfirmNewPassword = TextEditingController();

  String currentPassword = "", newPassword = "", confirmNewPassword = "";

  _getValues() {
    currentPassword = txtCurrentPassword.text;
    newPassword = txtNewPassword.text;
    confirmNewPassword = txtConfirmNewPassword.text;
  }

  bool _isEmpty() {
    if (currentPassword.isEmpty ||
        newPassword.isEmpty ||
        confirmNewPassword.isEmpty) {
      snackBar.show(
          context: navigator.context,
          info: "Please fill all fields.",
          snackBarType: SnackBarType.INFO);
      return true;
    }
    return false;
  }

  _isPasswordMatches() {
    if (newPassword != confirmNewPassword) {
      snackBar.show(
          context: navigator.context,
          info: "Password does not matches.",
          snackBarType: SnackBarType.INFO);
      return false;
    }
    return true;
  }

  Future<void> changePasswordAction() async {
    _getValues();
    if (_isEmpty()) return;
    if (!_isPasswordMatches()) return;
    try {
      emit(state.copyWith(loading: true));
      await changePasswordUseCase.execute(
          newPassword: newPassword, currentPassword: currentPassword);
      _resetTextFields();
      emit(state.copyWith(loading: false));
      if (context.mounted) {
        snackBar.show(
            context: context,
            info: "Password changed successfully",
            snackBarType: SnackBarType.SUCCESS);
      }
    } catch (e) {
      if (context.mounted) {
        handleException(e.toString(), context, onSessionExpired: () {
          Navigator.pop(context);
          navigator.openLogin(const LoginInitialParams());
        });
      }
    } finally {
      emit(state.copyWith(loading: false));
    }
  }

  void togglePassword() {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  _resetTextFields() {
    txtCurrentPassword.text = "";
    txtConfirmNewPassword.text = "";
    txtNewPassword.text = "";
  }
}
