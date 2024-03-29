import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:triplaner/presentation/widgets/custom_appbar.dart';
import 'package:triplaner/presentation/widgets/stack_loader.dart';
import 'package:triplaner/util/app_assets.dart';
import 'package:triplaner/util/app_constant.dart';
import 'package:triplaner/util/app_funtions.dart';
import 'package:triplaner/util/app_style.dart';
import 'account_cubit.dart';
import 'account_initial_params.dart';
import 'account_state.dart';
import 'widgets/account_card.dart';
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
          centerTitle: true,
        ),
        body: BlocBuilder<AccountCubit, AccountState>(
            bloc: cubit,
            builder: (context, state) {
              return Stack(
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: AppConstant.screenPadding.copyWith(bottom: 100.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          cubit.isLoggedIn()
                              ? Padding(
                                padding:  EdgeInsets.only(top: 15.h),
                                child: AccountCard(
                                    title: "Account",
                                    children: [
                                      UserInfoWidget(user: state.user,),
                                      // AccountTile(
                                      //   title: "Profile",
                                      //   onTap: (){},
                                      //   iconPath: AppAssets.user,
                                      // ),
                                      AccountTile(
                                        title: "Change Password",
                                        onTap: cubit.changePasswordAction,
                                        iconPath: AppAssets.changePassword,
                                      ),
                                      AccountTile(
                                        title: "Delete Account",
                                        onTap: cubit.deleteAccount,
                                        iconPath: AppAssets.deleteAccount,
                                        hideDivider: true,
                                      ),
                                    ],
                                  ),
                              )
                              : LoginTile(
                                  onLogin: cubit.loginAction,
                                ),
                          AccountCard(
                            title: 'Preferences',
                            children: [
                              AccountTile(
                                title: "Currency",
                                onTap: cubit.openCurrenciesPage,
                                iconPath: AppAssets.currencies,
                                hideDivider: true,
                              ),
                            ],
                          ),
                          AccountCard(
                            title: 'About',
                            children: [
                              AccountTile(
                                title: "About Us",
                                onTap: cubit.aboutUsAction,
                                iconPath: AppAssets.aboutUs,
                              ),
                              AccountTile(
                                title: "Share App",
                                onTap: cubit.shareAppAction,
                                iconPath: AppAssets.shareApp,
                              ),
                              AccountTile(
                                title: "Send Us Feedback",
                                onTap: cubit.sendUsFeedBackAction,
                                iconPath: AppAssets.feedBack,
                                hideDivider: true,
                              ),
                            ],
                          ),
                          AccountCard(
                            title: 'Legal',
                            children: [
                              AccountTile(
                                title: "Privacy Policy",
                                onTap: cubit.privacyPolicyAction,
                                iconPath: AppAssets.privacyPolicy,
                              ),
                              AccountTile(
                                title: "Terms of Use",
                                onTap: cubit.termsOfUseAction,
                                iconPath: AppAssets.termsOfUse,
                                hideDivider: true,
                              ),
                            ],
                          ),
                          Visibility(
                            visible: cubit.isLoggedIn(),
                            child: AccountTile(
                              title: "Logout",
                              onTap: cubit.logoutAction,
                              iconPath: AppAssets.logout,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  StackLoader(
                    show: state.stackLoading,
                  )
                ],
              );
            }));
  }

  Widget _title(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Text(
        title,
        style: AppStyle.accountTileHeading(context),
      ),
    );
  }
}
