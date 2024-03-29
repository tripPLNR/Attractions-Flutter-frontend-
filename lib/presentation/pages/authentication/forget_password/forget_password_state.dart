import 'package:equatable/equatable.dart';

import 'forget_password_initial_params.dart';

class ForgetPasswordState extends Equatable{
final bool loading;
const ForgetPasswordState({required this.loading});

factory ForgetPasswordState.initial({required ForgetPasswordInitialParams initialParams}) => ForgetPasswordState(loading: false);

ForgetPasswordState copyWith({bool? loading}) => ForgetPasswordState(loading: loading??this.loading);

  @override
  // TODO: implement props
  List<Object?> get props => [
    loading
  ];
}
