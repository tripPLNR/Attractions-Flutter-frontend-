import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:triplaner/util/app_funtions.dart';
import 'redirect_popup_initial_params.dart';
import 'redirect_popup_state.dart';
import 'redirect_popup_navigator.dart';

class RedirectPopupCubit extends Cubit<RedirectPopupState> {
  RedirectPopupNavigator navigator;
  RedirectPopupInitialParams initialParams;

  RedirectPopupCubit({required this.navigator, required this.initialParams})
      : super(RedirectPopupState.initial(initialParams: initialParams));

  BuildContext get context => navigator.context;


  navigate(){
    Navigator.pop(context);
    AppFunctions.launchUrlInBrowser(initialParams.url);
  }

}
