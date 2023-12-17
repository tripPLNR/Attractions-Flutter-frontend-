import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:triplaner/presentation/widgets/custom_appbar.dart';
import 'about_us_cubit.dart';
import 'about_us_initial_params.dart';
import 'about_us_state.dart';

class AboutUsPage extends StatefulWidget {
  final AboutUsCubit cubit;

  const AboutUsPage({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<AboutUsPage> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUsPage> {
  AboutUsCubit get cubit => widget.cubit;

  @override
  void initState() {
    super.initState();
    cubit.navigator.context = context;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "About Us",
      ),
      body: const SizedBox(),
    );
  }
}
