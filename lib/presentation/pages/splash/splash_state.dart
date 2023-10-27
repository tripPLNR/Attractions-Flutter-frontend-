import 'splash_initial_params.dart';

class SplashState {
final bool loading;
const SplashState({required this.loading});

factory SplashState.initial({required SplashInitialParams initialParams}) => SplashState(loading: false);

SplashState copyWith({bool? loading}) => SplashState(loading: loading??this.loading);
}
