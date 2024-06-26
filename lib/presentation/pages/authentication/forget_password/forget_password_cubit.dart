import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:triplaner/domain/repositories/auth_repository.dart';
import 'package:triplaner/presentation/base_cubit/base_cubit.dart';
import 'package:triplaner/presentation/pages/authentication/otp/otp_initial_params.dart';
import 'package:triplaner/util/alert/app_snackbar.dart';
import 'forget_password_initial_params.dart';
import 'forget_password_state.dart';
import 'forget_password_navigator.dart';

class ForgetPasswordCubit extends BaseCubit<ForgetPasswordState> {
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
      int userId = await authRepository.forgetPassword(email: email);
      navigator.openOtp(OtpInitialParams(
        emailOrPhoneNumber: email,
        userId: userId.toString(),
      ));
    } catch (e) {
      handleException(e.toString(), context);
    } finally {
      emit(state.copyWith(loading: false));
    }
  }
}
