import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:triplaner/presentation/widgets/custon_safe_area.dart';
import 'package:triplaner/util/app_funtions.dart';
import 'package:triplaner/util/app_style.dart';
import '../../../../util/app_assets.dart';
import '../../../../util/app_constant.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_textfield.dart';
import 'forget_password_cubit.dart';
import 'forget_password_initial_params.dart';
import 'forget_password_state.dart';

class ForgetPasswordPage extends StatefulWidget {
  final ForgetPasswordCubit cubit;

  const ForgetPasswordPage({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPasswordPage> {
  ForgetPasswordCubit get cubit => widget.cubit;

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
      body: BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
          bloc: cubit,
          builder: (context, state) {
            return IgnorePointer(
              ignoring: state.loading,
              child: Padding(
                padding: AppConstant.screenPadding
                    .copyWith(top: AppConstant.authTopPadding+MediaQuery.of(context).viewPadding.top),
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
                    SizedBox(
                      height: 36.h,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Forgot Password",
                        style: AppStyle.authHeadingStyle(context),
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Enter your registered email address and we’ll send you OTP to reset you password",
                        style: AppStyle.authSubHeadingStyle(context),
                      ),
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    CustomTextField(
                      controller: cubit.txtEmail,
                      hint: "Enter email",
                      label: "Email",
                      prefixPath: AppAssets.email,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomButton(
                      text: "SEND",
                      action: cubit.forgetPasswordAction,
                      isLoading: state.loading,
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
