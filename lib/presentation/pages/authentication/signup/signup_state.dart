import 'package:equatable/equatable.dart';

import 'signup_initial_params.dart';

class SignupState extends Equatable{
  final bool loading;
  final bool passwordVisible;
  final bool confirmPasswordVisible;

  const SignupState(
      {required this.loading,
      required this.confirmPasswordVisible,
      required this.passwordVisible});

  factory SignupState.initial({required SignupInitialParams initialParams}) =>
      const SignupState(
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

  @override
  // TODO: implement props
  List<Object?> get props => [
    loading,passwordVisible,confirmPasswordVisible
  ];
}
