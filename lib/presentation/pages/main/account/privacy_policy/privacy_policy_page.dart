import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../widgets/custom_appbar.dart';
import 'privacy_policy_cubit.dart';
import 'privacy_policy_initial_params.dart';
import 'privacy_policy_state.dart';

class PrivacyPolicyPage extends StatefulWidget {
  final PrivacyPolicyCubit cubit;

  const PrivacyPolicyPage({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<PrivacyPolicyPage> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicyPage> {
  PrivacyPolicyCubit get cubit => widget.cubit;

  @override
  void initState() {
    super.initState();
    cubit.navigator.context = context;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Privacy Policy",
      ),
      body: const SizedBox(),
    );
  }
}
