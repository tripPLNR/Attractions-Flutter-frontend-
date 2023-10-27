import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../../../../util/alert/app_snackbar.dart';
import 'bottom_navigation_initial_params.dart';
import 'bottom_navigation_state.dart';
import 'bottom_navigation_navigator.dart';

class BottomNavigationCubit extends Cubit<BottomNavigationState> {
  BottomNavigationNavigator navigator;
  BottomNavigationInitialParams initialParams;
  AppSnackBar snackBar;
  BottomNavigationCubit({
    required this.navigator,
    required this.initialParams,
    required this.snackBar,
  }) : super(BottomNavigationState.initial(initialParams: initialParams));

  BuildContext get context => navigator.context;

  changePage(int index){
    emit(state.copyWith(selectedIndex: index));
  }

  changeSearchMode(){
    emit(state.copyWith(isSearchModeON: !state.isSearchModeON));
  }
}
