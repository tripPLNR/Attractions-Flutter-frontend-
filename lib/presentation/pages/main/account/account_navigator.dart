import 'package:flutter/material.dart';
import 'package:triplaner/presentation/pages/authentication/login/login_navigator.dart';
import 'package:triplaner/presentation/pages/confirmation/confirmation_navigator.dart';
import 'package:triplaner/presentation/pages/main/account/about_us/about_us_navigator.dart';
import 'package:triplaner/presentation/pages/main/account/change_password/change_password_navigator.dart';
import 'package:triplaner/presentation/pages/main/account/currencies/currencies_navigator.dart';
import 'package:triplaner/presentation/pages/main/account/privacy_policy/privacy_policy_navigator.dart';
import 'package:triplaner/presentation/pages/main/account/terms_of_use/terms_of_use_navigator.dart';
import '../../../../../navigation/app_navigator.dart';
import '../../../../../util/dependency/app_dependency.dart';
import 'account_page.dart';
import 'account_cubit.dart';
import 'account_initial_params.dart';

class AccountNavigator
    with
        LoginRoute,
        ConfirmationRoute,
        AboutUsRoute,
        ChangePasswordRoute,
        PrivacyPolicyRoute,
        TermsOfUseRoute,
        CurrenciesRoute
{
  AccountNavigator(this.navigator);

  @override
  late BuildContext context;

  @override
  late AppNavigator navigator;
}

mixin AccountRoute {
  openAccount(AccountInitialParams initialParams) {
    navigator.push(
        context,
        AccountPage(
          cubit: getIt(param1: initialParams),
        ));
  }

  AppNavigator get navigator;

  BuildContext get context;
}
