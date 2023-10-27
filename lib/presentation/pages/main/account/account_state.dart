import 'package:triplaner/domain/entities/user.dart';

import 'account_initial_params.dart';

class AccountState {
final bool loading;
final User user;

const AccountState({required this.loading,required this.user});

factory AccountState.initial({required AccountInitialParams initialParams}) => AccountState(loading: false,user: User.empty());

AccountState copyWith({bool? loading,User? user}) => AccountState(loading: loading??this.loading,user: user??this.user);
}
