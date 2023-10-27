import 'confirmation_initial_params.dart';

class ConfirmationState {
final bool loading;
const ConfirmationState({required this.loading});

factory ConfirmationState.initial({required ConfirmationInitialParams initialParams}) => ConfirmationState(loading: false);

ConfirmationState copyWith({bool? loading}) => ConfirmationState(loading: loading??this.loading);
}
