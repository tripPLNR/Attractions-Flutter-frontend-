import 'about_us_initial_params.dart';

class AboutUsState {
final bool loading;
const AboutUsState({required this.loading});

factory AboutUsState.initial({required AboutUsInitialParams initialParams}) => AboutUsState(loading: false);

AboutUsState copyWith({bool? loading}) => AboutUsState(loading: loading??this.loading);
}
