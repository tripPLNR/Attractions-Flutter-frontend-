import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:triplaner/domain/usecases/logout_usecase.dart';
import 'package:triplaner/util/alert/app_snackbar.dart';
import 'package:triplaner/util/dependency/app_dependency.dart';
abstract class BaseCubit<T> extends Cubit<T> {
  BaseCubit(T initialState) : super(initialState);


  void handleException(String error,BuildContext context,{VoidCallback? onSessionExpired}) {
    AppSnackBar snackBar=getIt();
    if(error.contains("Unauthorized")){
      snackBar.show(context: context, info: "Session expired, please login",snackBarType: SnackBarType.INFO);
      LogoutUseCase logoutUseCase=getIt();
      logoutUseCase.execute();
      if(onSessionExpired!=null){
        onSessionExpired();
      }
    }else{
      snackBar.show(context: context, info: error);
    }
  }


}