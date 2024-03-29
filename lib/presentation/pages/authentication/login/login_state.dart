import 'package:equatable/equatable.dart';

import 'login_initial_params.dart';

class LoginState extends Equatable{
  final bool loading;
  final bool isPasswordVisible;
  final bool socialLogging;

  const LoginState(
      {required this.loading,
      required this.isPasswordVisible,
      required this.socialLogging});

  factory LoginState.initial({required LoginInitialParams initialParams}) =>
      const LoginState(
          loading: false, isPasswordVisible: false, socialLogging: false);

  LoginState copyWith(
          {bool? loading, bool? isPasswordVisible, bool? socialLogging}) =>
      LoginState(
        loading: loading ?? this.loading,
        isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
        socialLogging: socialLogging ?? this.socialLogging,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [
    loading,isPasswordVisible,socialLogging
  ];
}
