import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:triplaner/domain/entities/user.dart';
import 'package:triplaner/domain/stores/user_store.dart';
import 'package:triplaner/domain/usecases/logout_usecase.dart';
import 'package:triplaner/presentation/pages/authentication/login/login_initial_params.dart';
import 'package:triplaner/presentation/pages/confirmation/confirmation_initial_params.dart';
import 'package:triplaner/util/alert/app_snackbar.dart';
import 'account_initial_params.dart';
import 'account_state.dart';
import 'account_navigator.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountNavigator navigator;
  AccountInitialParams initialParams;
  AppSnackBar snackBar;
  UserStore userStore;
  LogoutUseCase logoutUseCase;
  AccountCubit(
      {required this.navigator,
      required this.initialParams,
      required this.snackBar,
      required this.userStore,
      required this.logoutUseCase,

      })
      : super(AccountState.initial(initialParams: initialParams));

  BuildContext get context => navigator.context;

  User get user => userStore.state;

  onInit(){
    emit(state.copyWith(user: user));
    userStore.stream.listen((event) {
      emit(state.copyWith(user: event));
    });
  }
  bool isLoggedIn(){
    return state.user!=User.empty();
  }
  loginAction(){
    navigator.openLogin(const LoginInitialParams());
  }

  logoutAction() async {
    try{
      navigator.openConfirmation(ConfirmationInitialParams(
        title: "Logout",
        subtitle: "Do you really want to logout?",
        btnText: "Logout",
        btnAction: () async {
          await logoutUseCase.execute();
        }
      ));
    }catch(e){
      snackBar.show(context: context, info: e.toString());
    }
  }
}
