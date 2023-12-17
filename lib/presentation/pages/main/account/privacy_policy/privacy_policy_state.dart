import 'privacy_policy_initial_params.dart';

class PrivacyPolicyState {
final bool loading;
const PrivacyPolicyState({required this.loading});

factory PrivacyPolicyState.initial({required PrivacyPolicyInitialParams initialParams}) => PrivacyPolicyState(loading: false);

PrivacyPolicyState copyWith({bool? loading}) => PrivacyPolicyState(loading: loading??this.loading);
}
