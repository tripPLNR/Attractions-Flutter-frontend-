import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:triplaner/presentation/widgets/custom_appbar.dart';
import 'package:triplaner/presentation/widgets/custom_textfield.dart';
import 'package:triplaner/util/app_assets.dart';
import '../../../../util/app_constant.dart';
import '../../../widgets/custom_button.dart';
import 'reset_password_cubit.dart';
import 'reset_password_initial_params.dart';
import 'reset_password_state.dart';

class ResetPasswordPage extends StatefulWidget {
  final ResetPasswordCubit cubit;

  const ResetPasswordPage({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPasswordPage> {
  ResetPasswordCubit get cubit => widget.cubit;

  @override
  void initState() {
    super.initState();
    cubit.navigator.context = context;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Reset Password",
      ),
      body: BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
          bloc: cubit,
          builder: (context, state) {
            return IgnorePointer(
              ignoring: state.loading,
              child: Padding(
                padding: AppConstant.screenPadding.copyWith(
                    top: AppConstant.authTopPadding +
                        MediaQuery.of(context).viewPadding.top),
                child: Column(
                  children: [
                    CustomTextField(
                      controller: cubit.txtNewPassword,
                      hint: "Enter new password",
                      prefixPath: AppAssets.password,
                      label: "New Password",
                      suffixPath: state.hidePassword
                          ? AppAssets.visible
                          : AppAssets.notVisible,
                      hide: state.hidePassword,
                      suffixAction: cubit.togglePasswordVisibility,
                    ),
                    CustomTextField(
                      controller: cubit.txtConfirmNewPassword,
                      hint: "Enter new password again",
                      prefixPath: AppAssets.password,
                      label: "Confirm New Password",
                      suffixPath: state.hidePassword
                          ? AppAssets.visible
                          : AppAssets.notVisible,
                      hide: state.hidePassword,
                      suffixAction: cubit.togglePasswordVisibility,
                      bottomPadding: 0,
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    CustomButton(
                      text: "Reset Password",
                      action: cubit.resetPassword,
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
