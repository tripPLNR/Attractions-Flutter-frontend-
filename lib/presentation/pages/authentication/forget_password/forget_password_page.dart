import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
            bloc: cubit,
            builder: (context, state) {
              return IgnorePointer(
                ignoring: state.loading,
                child: Padding(
                  padding: AppConstant.screenPadding
                      .copyWith(top: AppConstant.authTopPadding),
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
                          "Enter your email address and we will send a link to reset your password",
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
      ),
    );
  }
}
