import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'terms_of_use_initial_params.dart';
import 'terms_of_use_state.dart';
import 'terms_of_use_navigator.dart';


class TermsOfUseCubit extends Cubit<TermsOfUseState> {
TermsOfUseNavigator navigator;
TermsOfUseInitialParams initialParams;
TermsOfUseCubit({required this.navigator,required this.initialParams}) : super(TermsOfUseState.initial(initialParams:initialParams));

BuildContext get context => navigator.context;
}
