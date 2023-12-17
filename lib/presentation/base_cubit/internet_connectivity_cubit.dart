import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'base_cubit.dart';

mixin ConnectivityMixin<T> on BaseCubit<T> {
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  void onConnectivityChanged(bool isConnected);

  void setupConnectivityListener() {
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((result) {
      onConnectivityChanged(result != ConnectivityResult.none);
    });
  }



  @override
  Future<void> close() {
    _connectivitySubscription.cancel();
    debugPrint("Subscription cancelled....");
    return super.close();
  }
}