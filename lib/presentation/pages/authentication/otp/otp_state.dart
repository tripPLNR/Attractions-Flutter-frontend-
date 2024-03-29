import 'otp_initial_params.dart';

class OtpState {
  final bool loading;
  final bool resending;
  final String enteredOTP;
  final String emailOrPhoneNumber;
  final int remainingSeconds;
  const OtpState({
    required this.loading,
    required this.enteredOTP,
    required this.emailOrPhoneNumber,
    required this.resending,
    required this.remainingSeconds,
  });

  factory OtpState.initial({required OtpInitialParams initialParams}) =>
      OtpState(
        loading: false,
        enteredOTP:"",
        remainingSeconds:60*5,
        emailOrPhoneNumber: initialParams.emailOrPhoneNumber,
        resending: false,
      );

  OtpState copyWith(
          {bool? loading,
          String? enteredOTP,
          String? emailOrPhoneNumber,
          bool? resending,
            int? remainingSeconds,
          }) =>
      OtpState(
        loading: loading ?? this.loading,
        enteredOTP: enteredOTP ?? this.enteredOTP,
        emailOrPhoneNumber: emailOrPhoneNumber ?? this.emailOrPhoneNumber,
        resending: resending ?? this.resending,
        remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      );
}
