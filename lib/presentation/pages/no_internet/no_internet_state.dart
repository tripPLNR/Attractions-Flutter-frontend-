import 'no_internet_initial_params.dart';

class NoInternetState {
final bool loading;
const NoInternetState({required this.loading});

factory NoInternetState.initial({required NoInternetInitialParams initialParams}) => NoInternetState(loading: false);

NoInternetState copyWith({bool? loading}) => NoInternetState(loading: loading??this.loading);
}
