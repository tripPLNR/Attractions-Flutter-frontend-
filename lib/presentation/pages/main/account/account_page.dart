import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:triplaner/presentation/widgets/custom_appbar.dart';
import 'package:triplaner/util/app_assets.dart';
import 'package:triplaner/util/app_constant.dart';
import 'package:triplaner/util/app_funtions.dart';
import 'account_cubit.dart';
import 'account_initial_params.dart';
import 'account_state.dart';
import 'widgets/account_tile.dart';
import 'widgets/login_tile.dart';
import 'widgets/user_info_widget.dart';

class AccountPage extends StatefulWidget {
  final AccountCubit cubit;

  const AccountPage({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountState();
}

class _AccountState extends State<AccountPage> {
  AccountCubit get cubit => widget.cubit;

  @override
  void initState() {
    super.initState();
    cubit.navigator.context = context;
    cubit.onInit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          title: "Account",
          hideBack: true,
        ),
        body: BlocBuilder<AccountCubit, AccountState>(
            bloc: cubit,
            builder: (context, state) {
              return Padding(
                padding: AppConstant.screenPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    cubit.isLoggedIn()
                        ? UserInfoWidget(
                            user: cubit.user,
                          )
                        : LoginTile(
                            onLogin: cubit.loginAction,
                          ),
                    SizedBox(
                      height: 12.h,
                    ),
                    AccountTile(
                      title: "About Us",
                      onTap: () {},
                      iconPath: AppAssets.aboutUs,
                    ),
                    AccountTile(
                      title: "Password Change",
                      onTap: () {},
                      hide: !cubit.isLoggedIn(),
                      iconPath: AppAssets.changePassword,
                    ),
                    AccountTile(
                      title: "Share App",
                      onTap: () {},
                      iconPath: AppAssets.shareApp,
                    ),
                    AccountTile(
                      title: "Privacy Policy",
                      onTap: () {},
                      iconPath: AppAssets.privacyPolicy,
                    ),
                    AccountTile(
                      title: "Terms of Use",
                      onTap: () {},
                      iconPath: AppAssets.termsOfUse,
                    ),
                    AccountTile(
                      title: "Delete Account",
                      onTap: () {},
                      hide: !cubit.isLoggedIn(),
                      iconPath: AppAssets.deleteAccount,
                    ),
                    AccountTile(
                      title: "Logout",
                      onTap: cubit.logoutAction,
                      hide: !cubit.isLoggedIn(),
                      iconPath: AppAssets.logout,
                    ),
                  ],
                ),
              );
            }));
  }
}
