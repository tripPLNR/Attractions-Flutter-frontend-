import 'change_password_initial_params.dart';

class ChangePasswordState {
  final bool loading;
  final bool isPasswordVisible;

  const ChangePasswordState(
      {required this.loading, required this.isPasswordVisible});

  factory ChangePasswordState.initial(
          {required ChangePasswordInitialParams initialParams}) =>
      ChangePasswordState(loading: false, isPasswordVisible: false);

  ChangePasswordState copyWith({bool? loading, bool? isPasswordVisible}) =>
      ChangePasswordState(
        loading: loading ?? this.loading,
          isPasswordVisible:isPasswordVisible??this.isPasswordVisible
      );
}
