import 'signup_initial_params.dart';

class SignupState {
  final bool loading;
  final bool passwordVisible;
  final bool confirmPasswordVisible;

  const SignupState(
      {required this.loading,
      required this.confirmPasswordVisible,
      required this.passwordVisible});

  factory SignupState.initial({required SignupInitialParams initialParams}) =>
      SignupState(
          loading: false,
          passwordVisible: false,
          confirmPasswordVisible: false);

  SignupState copyWith(
          {bool? loading,
          bool? passwordVisible,
          bool? confirmPasswordVisible}) =>
      SignupState(
        loading: loading ?? this.loading,
        passwordVisible: passwordVisible ?? this.passwordVisible,
        confirmPasswordVisible:
            confirmPasswordVisible ?? this.confirmPasswordVisible,
      );
}
