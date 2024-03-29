import 'reset_password_initial_params.dart';

class ResetPasswordState {
  final bool loading;
  final bool hidePassword;

  const ResetPasswordState({required this.loading, required this.hidePassword});

  factory ResetPasswordState.initial(
          {required ResetPasswordInitialParams initialParams}) =>
      ResetPasswordState(loading: false, hidePassword: true);

  ResetPasswordState copyWith({bool? loading, bool? hidePassword}) =>
      ResetPasswordState(
        loading: loading ?? this.loading,
        hidePassword: hidePassword ?? this.hidePassword,
      );
}
