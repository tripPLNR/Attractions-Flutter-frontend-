import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:triplaner/presentation/widgets/custom_appbar.dart';
import 'terms_of_use_cubit.dart';
import 'terms_of_use_initial_params.dart';
import 'terms_of_use_state.dart';

class TermsOfUsePage extends StatefulWidget {
  final TermsOfUseCubit cubit;

  const TermsOfUsePage({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<TermsOfUsePage> createState() => _TermsOfUseState();
}

class _TermsOfUseState extends State<TermsOfUsePage> {
  TermsOfUseCubit get cubit => widget.cubit;

  @override
  void initState() {
    super.initState();
    cubit.navigator.context = context;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Terms of Use"
      ),
      body: const SizedBox(),
    );
  }
}
