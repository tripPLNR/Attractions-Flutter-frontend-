import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:triplaner/presentation/pages/authentication/login/widgets/login_form_background.dart';
import 'package:triplaner/presentation/widgets/custom_button.dart';
import 'package:triplaner/presentation/widgets/custom_loader.dart';
import 'package:triplaner/presentation/widgets/custom_textfield.dart';
import 'package:triplaner/util/app_assets.dart';
import 'package:triplaner/util/app_constant.dart';
import 'package:triplaner/util/app_funtions.dart';
import 'package:triplaner/util/app_style.dart';
import 'package:triplaner/util/app_theme.dart';
import 'login_cubit.dart';
import 'login_initial_params.dart';
import 'login_state.dart';
import 'widgets/login_top_text.dart';

class LoginPage extends StatefulWidget {
  final LoginCubit cubit;

  const LoginPage({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  LoginCubit get cubit => widget.cubit;

  @override
  void initState() {
    super.initState();
    cubit.navigator.context = context;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(AppAssets.aboutUsHeader),
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
            child: BlocBuilder<LoginCubit, LoginState>(
                bloc: cubit,
                builder: (context, state) {
                  return IgnorePointer(
                    ignoring: state.loading || state.socialLogging,
                    child: LoginFormBackground(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Login",
                                  style: AppStyle.authHeadingStyle(context),
                                )),
                            SizedBox(
                              height: 24.h,
                            ),
                            CustomTextField(
                              controller: cubit.txtEmail,
                              hint: "Enter email address",
                              prefixPath: AppAssets.email,
                              label: "Email Address",
                            ),
                            CustomTextField(
                              controller: cubit.txtPassword,
                              hint: "Enter password",
                              prefixPath: AppAssets.password,
                              label: "Password",
                              suffixPath: state.isPasswordVisible?AppAssets.notVisible:AppAssets.visible,
                              hide: !state.isPasswordVisible,
                              suffixAction: cubit.togglePassword,
                              bottomPadding: 0,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                  onPressed: cubit.forgetAction,
                                  child: Text(
                                    "Forgot Password ?",
                                    style: TextStyle(
                                        letterSpacing: 0,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600),
                                  )),
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            CustomButton(
                              text: "LOGIN",
                              action: cubit.loginAction,
                              isLoading: state.loading,
                            ),
                            SizedBox(
                              height: 24.h,
                            ),
                            SvgPicture.asset(AppAssets.or),
                            SizedBox(
                              height: 14.h,
                            ),
                            state.socialLogging
                                ? CustomLoader()
                                : Row(
                              mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                                      child: InkWell(
                                        onTap: cubit.googleLoginAction,
                                        child: SvgPicture.asset(AppAssets.google),
                                      ),
                                    ),
                                    Visibility(
                                      visible: Platform.isIOS,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                                        child: InkWell(
                                          onTap: cubit.appleLoginAction,
                                          child: SvgPicture.asset(AppAssets.apple),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                            SizedBox(
                              height: 20.h,
                            ),
                            InkWell(
                              onTap: cubit.signupAction,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.h),
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                          text: 'Create an account? ',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: 'Sign Up',
                                              style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary),
                                            )
                                          ]),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
