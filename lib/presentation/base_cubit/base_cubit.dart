import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:triplaner/domain/usecases/logout_usecase.dart';
import 'package:triplaner/util/dependency/app_dependency.dart';
abstract class BaseCubit<T> extends Cubit<T> {
  BaseCubit(T initialState) : super(initialState);


  void handleException(String error,BuildContext context) {
    if(error.contains("Unauthorized")){
      LogoutUseCase logoutUseCase=getIt();
      logoutUseCase.execute();
    }
  }


}