import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'privacy_policy_initial_params.dart';
import 'privacy_policy_state.dart';
import 'privacy_policy_navigator.dart';


class PrivacyPolicyCubit extends Cubit<PrivacyPolicyState> {
PrivacyPolicyNavigator navigator;
PrivacyPolicyInitialParams initialParams;
PrivacyPolicyCubit({required this.navigator,required this.initialParams}) : super(PrivacyPolicyState.initial(initialParams:initialParams));

BuildContext get context => navigator.context;
}
