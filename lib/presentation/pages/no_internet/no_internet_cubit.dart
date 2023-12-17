import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:triplaner/presentation/base_cubit/base_cubit.dart';
import 'package:triplaner/presentation/base_cubit/internet_connectivity_cubit.dart';
import 'package:triplaner/util/services/internet/internet_connection_service.dart';
import 'no_internet_initial_params.dart';
import 'no_internet_state.dart';
import 'no_internet_navigator.dart';

class NoInternetCubit extends BaseCubit<NoInternetState> with ConnectivityMixin{
  NoInternetNavigator navigator;
  NoInternetInitialParams initialParams;
  NoInternetCubit(
      {required this.navigator,
      required this.initialParams})
      : super(NoInternetState.initial(initialParams: initialParams)){
    setupConnectivityListener();
  }

  BuildContext get context => navigator.context;

  onRefresh(){
  }

  @override
  void onConnectivityChanged(bool isConnected) {
    if(isConnected){
      Navigator.canPop(context)?Navigator.pop(context):null;
    }
  }

}
