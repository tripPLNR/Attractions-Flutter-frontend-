import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:triplaner/presentation/widgets/custom_button.dart';
import 'package:triplaner/presentation/widgets/custom_textfield.dart';
import 'package:triplaner/util/app_assets.dart';
import 'package:triplaner/util/app_constant.dart';
import 'package:triplaner/util/app_funtions.dart';
import 'package:triplaner/util/app_style.dart';
import 'signup_cubit.dart';
import 'signup_initial_params.dart';
import 'signup_state.dart';

class SignupPage extends StatefulWidget {
  final SignupCubit cubit;

  const SignupPage({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupState();
}

class _SignupState extends State<SignupPage> {
  SignupCubit get cubit => widget.cubit;

  @override
  void initState() {
    super.initState();
    cubit.navigator.context = context;
    AppFunctions.transparentStatusBar(blackText: true);
  }
  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    AppFunctions.transparentStatusBar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: AppConstant.screenPadding.copyWith(top: AppConstant.authTopPadding+MediaQuery.of(context).viewPadding.top),
        child: BlocBuilder<SignupCubit, SignupState>(
            bloc: cubit,
            builder: (context, state) {
              return SingleChildScrollView(
                child: IgnorePointer(
                  ignoring: state.loading,
                  child: Column(
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: SvgPicture.asset(
                              AppAssets.circularBack,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          )),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Sign Up",
                          style: AppStyle.authHeadingStyle(context),
                        ),
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      CustomTextField(
                        controller: cubit.txtFirstName,
                        hint: "First Name",
                        label: "First Name",
                        prefixPath: AppAssets.user,
                      ),
                      CustomTextField(
                        controller: cubit.txtLastName,
                        hint: "Last Name",
                        label: "Last Name",
                        prefixPath: AppAssets.user,
                      ),
                      CustomTextField(
                        controller: cubit.txtEmail,
                        hint: "Email Address",
                        label: "Email Address",
                        prefixPath: AppAssets.email,
                      ),
                      CustomTextField(
                        controller: cubit.txtPassword,
                        hint: "Password",
                        label: "Password",
                        prefixPath: AppAssets.password,
                        suffixPath: state.passwordVisible?AppAssets.notVisible:AppAssets.visible,
                        hide: !state.passwordVisible,
                        suffixAction: cubit.togglePassword,
                      ),
                      SizedBox(
                        height: 32.h,
                      ),
                      CustomButton(
                        text: "SIGN UP",
                        action: cubit.signUpAction,
                        isLoading: state.loading,
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      InkWell(
                        onTap: cubit.loginAction,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.h),
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Already have an Account? ',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'Login',
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
              );
            }),
      ),
    );
  }
}
