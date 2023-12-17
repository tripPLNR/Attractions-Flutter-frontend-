import 'package:flutter/material.dart';
import '../../../../../navigation/app_navigator.dart';
import '../../../../../util/dependency/app_dependency.dart';
import 'privacy_policy_page.dart';
import 'privacy_policy_cubit.dart';
import 'privacy_policy_initial_params.dart';



class PrivacyPolicyNavigator {
PrivacyPolicyNavigator(this.navigator);

@override
late BuildContext context;

@override
late AppNavigator navigator;

}

mixin PrivacyPolicyRoute {
openPrivacyPolicy(PrivacyPolicyInitialParams initialParams) {
navigator.push(
context,
PrivacyPolicyPage(cubit: getIt(param1:initialParams),));
}

AppNavigator get navigator;

BuildContext get context;
}
