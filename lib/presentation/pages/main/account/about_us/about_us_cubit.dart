import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'about_us_initial_params.dart';
import 'about_us_state.dart';
import 'about_us_navigator.dart';


class AboutUsCubit extends Cubit<AboutUsState> {
AboutUsNavigator navigator;
AboutUsInitialParams initialParams;
AboutUsCubit({required this.navigator,required this.initialParams}) : super(AboutUsState.initial(initialParams:initialParams));

BuildContext get context => navigator.context;
}
