import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:triplaner/domain/repositories/auth_repository.dart';
import 'package:triplaner/presentation/base_cubit/base_cubit.dart';
import 'package:triplaner/presentation/pages/authentication/reset_password/reset_password_initial_params.dart';
import 'package:triplaner/util/alert/app_snackbar.dart';
import 'otp_initial_params.dart';
import 'otp_state.dart';
import 'otp_navigator.dart';

class OtpCubit extends BaseCubit<OtpState> {
  OtpNavigator navigator;
  OtpInitialParams initialParams;
  AppSnackBar snackBar;
  AuthRepository authRepository;

  OtpCubit({
    required this.navigator,
    required this.initialParams,
    required this.snackBar,
    required this.authRepository,
  }) : super(OtpState.initial(initialParams: initialParams));

  BuildContext get context => navigator.context;
  late Timer _timer;

  onInit() {
    // _stopTimer();
    _startTimer();
  }

  resendOtp() async {
    try {
      if (state.remainingSeconds != 0) {
        snackBar.show(
            context: context,
            info: "Please wait for ${state.remainingSeconds} seconds.",
            snackBarType: SnackBarType.INFO);
        return;
      }
      emit(state.copyWith(resending: true));
      await authRepository.forgetPassword(
        email: state.emailOrPhoneNumber,
      );
      emit(state.copyWith(resending: false, remainingSeconds: 60*5));
      _startTimer();
      snackBar.show(
          context: context,
          info: "OTP resent successfully",
          snackBarType: SnackBarType.SUCCESS);
    } catch (e) {
      handleException(e.toString(), context);
    } finally {
      emit(state.copyWith(resending: false));
    }
  }

  verifyOtp() async {
    try {
      if (state.enteredOTP.isEmpty) {
        snackBar.show(
            context: context,
            info: "Please enter otp",
            snackBarType: SnackBarType.INFO);
        return;
      }
      emit(state.copyWith(loading: true));
      await authRepository.verifyOTP(
          otp: state.enteredOTP, userId: initialParams.userId);
      navigator.openResetPassword(ResetPasswordInitialParams(
        userId: initialParams.userId,
      ));
    } catch (e) {
      handleException(e.toString(), context);
    } finally {
      emit(state.copyWith(loading: false));
    }
  }

  _startTimer() {
    if (state.remainingSeconds > 0) {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        int updatedSeconds = state.remainingSeconds - 1;
        emit(state.copyWith(remainingSeconds: updatedSeconds));
        if (updatedSeconds == 0) {
          _stopTimer();
        }
      });
    }
  }

  void _stopTimer() {
    _timer.cancel();
  }

  onSubmitOtp(String otp) {
    emit(state.copyWith(enteredOTP: otp));
  }
}
