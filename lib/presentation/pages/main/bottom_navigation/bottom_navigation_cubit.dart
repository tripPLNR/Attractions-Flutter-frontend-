import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:triplaner/domain/stores/bottom_nav_store.dart';
import 'package:triplaner/presentation/base_cubit/base_cubit.dart';
import 'package:triplaner/presentation/base_cubit/internet_connectivity_cubit.dart';
import 'package:triplaner/presentation/pages/no_internet/no_internet_initial_params.dart';
import '../../../../util/alert/app_snackbar.dart';
import 'bottom_navigation_initial_params.dart';
import 'bottom_navigation_state.dart';
import 'bottom_navigation_navigator.dart';

class BottomNavigationCubit extends BaseCubit<BottomNavigationState>
    with ConnectivityMixin<BottomNavigationState> {
  BottomNavigationNavigator navigator;
  BottomNavigationInitialParams initialParams;
  AppSnackBar snackBar;
  BottomNavStore bottomNavStore;

  BottomNavigationCubit({
    required this.navigator,
    required this.initialParams,
    required this.snackBar,
    required this.bottomNavStore,
  }) : super(BottomNavigationState.initial(initialParams: initialParams)) {
    setupConnectivityListener();
  }

  BuildContext get context => navigator.context;

  onInit() {
    _listenToBottomNavStore();
  }

  changePage(int index) {
    emit(state.copyWith(selectedIndex: index));
    bottomNavStore.changeScreen(index);
  }

  changeSearchMode() {
    emit(state.copyWith(isSearchModeON: !state.isSearchModeON));
  }

  _listenToBottomNavStore() {
    emit(state.copyWith(selectedIndex: bottomNavStore.state));
    bottomNavStore.stream.listen((event) {
      emit(state.copyWith(selectedIndex: event));
    });
  }

  @override
  void onConnectivityChanged(bool isConnected) {
    /// if internet not connected then move user to not internet connection page
    if (!isConnected) {
      debugPrint("GOTO NO INTERNET PAGE....");
      navigator.openNoInternet(const NoInternetInitialParams());
    }
  }
}
