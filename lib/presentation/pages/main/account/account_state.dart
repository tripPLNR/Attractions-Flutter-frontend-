import 'package:triplaner/domain/entities/user.dart';

import 'account_initial_params.dart';

class AccountState {
  final bool loading;
  final bool stackLoading;

  final User user;

  const AccountState({
    required this.loading,
    required this.user,
    required this.stackLoading,
  });

  factory AccountState.initial({required AccountInitialParams initialParams}) =>
      AccountState(loading: false, user: User.empty(), stackLoading: false);

  AccountState copyWith({bool? loading, User? user, bool? stackLoading}) =>
      AccountState(
        loading: loading ?? this.loading,
        user: user ?? this.user,
        stackLoading: stackLoading ?? this.stackLoading,
      );
}
