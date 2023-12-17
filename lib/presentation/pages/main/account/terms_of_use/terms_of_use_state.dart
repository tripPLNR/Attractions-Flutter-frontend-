import 'terms_of_use_initial_params.dart';

class TermsOfUseState {
final bool loading;
const TermsOfUseState({required this.loading});

factory TermsOfUseState.initial({required TermsOfUseInitialParams initialParams}) => TermsOfUseState(loading: false);

TermsOfUseState copyWith({bool? loading}) => TermsOfUseState(loading: loading??this.loading);
}
