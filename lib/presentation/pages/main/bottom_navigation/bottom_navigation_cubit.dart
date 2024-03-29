import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:triplaner/domain/stores/bottom_nav_store.dart';
import 'package:triplaner/presentation/base_cubit/base_cubit.dart';
import 'package:triplaner/presentation/base_cubit/internet_connectivity_cubit.dart';
import 'package:triplaner/presentation/pages/main/site_detail/site_detail_initial_params.dart';
import 'package:triplaner/presentation/pages/no_internet/no_internet_initial_params.dart';
import 'package:triplaner/util/services/deep_linking/deep_link_service.dart';
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
  DeepLinkService deepLinkService;

  BottomNavigationCubit({
    required this.navigator,
    required this.initialParams,
    required this.snackBar,
    required this.bottomNavStore,
    required this.deepLinkService,
  }) : super(BottomNavigationState.initial(initialParams: initialParams)) {
    setupConnectivityListener();
  }

  BuildContext get context => navigator.context;

  onInit() {
    _listenToBottomNavStore();
    _listenToDeepLink();
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

  _listenToDeepLink() {
    deepLinkService.startListening(onStart: () {
      emit(state.copyWith(stackLoading: true));
    }, onEnd: (site) {
      emit(state.copyWith(stackLoading: false));
      navigator.openSiteDetail(SiteDetailInitialParams(site: site));
    }, onError: (error) {
      emit(state.copyWith(stackLoading: false));
      snackBar.show(context: context, info: error);
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
