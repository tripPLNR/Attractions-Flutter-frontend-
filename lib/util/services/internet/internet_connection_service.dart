import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:triplaner/navigation/app_navigator.dart';
import 'package:triplaner/presentation/pages/no_internet/no_internet_initial_params.dart';
import 'package:triplaner/presentation/pages/no_internet/no_internet_page.dart';
import 'package:triplaner/util/dependency/app_dependency.dart';

class InternetConnectionService extends Cubit<bool> {
  AppNavigator appNavigator;

  InternetConnectionService({required this.appNavigator}) : super(false);

  final Connectivity _connectivity = Connectivity();

  onInit() async {
    debugPrint("INTERNET listening.....");
    ConnectivityResult connectivityResult =
        await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      _moveToNoInternetPage();
      return;
    }
    _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        debugPrint("NO INTERNET.....");

        /// no internet connection
        _moveToNoInternetPage();
      } else {
        /// got internet
        debugPrint("GOTTTTTT INTERNET.....");
        if (AppNavigator.navigatorKey.currentState != null) {
          Navigator.pop(AppNavigator.navigatorKey.currentState!.context);
        }
      }
    });
  }

  _moveToNoInternetPage() async {
    if( AppNavigator.navigatorKey.currentState==null){
     await Future.delayed(const Duration(seconds: 3));
    }
    appNavigator.push(
        AppNavigator.navigatorKey.currentState!.context,
    NoInternetPage(
    cubit: getIt(param1: const NoInternetInitialParams())));
  }
}
