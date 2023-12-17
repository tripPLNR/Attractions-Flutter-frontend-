import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:triplaner/domain/entities/user.dart';
import 'package:triplaner/domain/stores/user_store.dart';
import 'package:triplaner/domain/usecases/delete_account_usecase.dart';
import 'package:triplaner/domain/usecases/logout_usecase.dart';
import 'package:triplaner/presentation/pages/authentication/login/login_initial_params.dart';
import 'package:triplaner/presentation/pages/confirmation/confirmation_initial_params.dart';
import 'package:triplaner/presentation/pages/main/account/about_us/about_us_initial_params.dart';
import 'package:triplaner/presentation/pages/main/account/change_password/change_password_initial_params.dart';
import 'package:triplaner/presentation/pages/main/account/privacy_policy/privacy_policy_initial_params.dart';
import 'package:triplaner/presentation/pages/main/account/terms_of_use/terms_of_use_initial_params.dart';
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
  DeleteAccountUseCase deleteAccountUseCase;
  AccountCubit({
    required this.navigator,
    required this.initialParams,
    required this.snackBar,
    required this.userStore,
    required this.logoutUseCase,
    required this.deleteAccountUseCase,

  }) : super(AccountState.initial(initialParams: initialParams));

  BuildContext get context => navigator.context;

  User get user => userStore.state;

  onInit() {
    emit(state.copyWith(user: user));
    userStore.stream.listen((event) {
      emit(state.copyWith(user: event));
    });
  }

  bool isLoggedIn() {
    return state.user != User.empty();
  }

  loginAction() {
    navigator.openLogin(const LoginInitialParams());
  }

  logoutAction() async {
    try {
      navigator.openConfirmation(ConfirmationInitialParams(
          title: "",
          subtitle: "Do you want to logout?",
          btnText: "Logout",
          btnAction: () async {
            await logoutUseCase.execute();
          }));
    } catch (e) {
      snackBar.show(context: context, info: e.toString());
    }
  }

  deleteAccount() {
    navigator.openConfirmation(ConfirmationInitialParams(
        title: "We’re sorry to see you go!",
        subtitle: "Your account history will be deleted with us. Should you ever wish to return, we’ll be here to assist you.",
        btnText: "Delete",
        btnAction: () async {
          try {
            await logoutUseCase.execute();
          } catch (e) {
            snackBar.show(context: context, info: e.toString());
          }
        }));
  }

  aboutUsAction(){
    navigator.openAboutUs(const AboutUsInitialParams());
  }
  changePasswordAction(){
    navigator.openChangePassword(const ChangePasswordInitialParams());
  }
  privacyPolicyAction(){
    navigator.openPrivacyPolicy(const PrivacyPolicyInitialParams());
  }
  termsOfUseAction(){
    navigator.openTermsOfUse(const TermsOfUseInitialParams());
  }

  shareAppAction(){
    Share.share('Hello, use this app');
  }



}
