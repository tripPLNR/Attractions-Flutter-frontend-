import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:triplaner/presentation/widgets/custom_button.dart';
import 'package:triplaner/util/app_assets.dart';
import 'package:triplaner/util/app_constant.dart';
import '../../../../../util/app_style.dart';
import '../../../../widgets/custom_appbar.dart';
import '../../../../widgets/custom_textfield.dart';
import 'change_password_cubit.dart';
import 'change_password_initial_params.dart';
import 'change_password_state.dart';

class ChangePasswordPage extends StatefulWidget {
  final ChangePasswordCubit cubit;

  const ChangePasswordPage({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePasswordPage> {
  ChangePasswordCubit get cubit => widget.cubit;

  @override
  void initState() {
    super.initState();
    cubit.navigator.context = context;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Change Password",
      ),
      body: BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
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
                      controller: cubit.txtCurrentPassword,
                      hint: "Enter current password",
                      prefixPath: AppAssets.password,
                      label: "Current Password",
                      suffixPath: state.isPasswordVisible
                          ? AppAssets.notVisible
                          : AppAssets.visible,
                      hide: !state.isPasswordVisible,
                      suffixAction: cubit.togglePassword,
                    ),
                    CustomTextField(
                      controller: cubit.txtNewPassword,
                      hint: "Enter new password",
                      prefixPath: AppAssets.password,
                      label: "New Password",
                      suffixPath: state.isPasswordVisible
                          ? AppAssets.notVisible
                          : AppAssets.visible,
                      hide: !state.isPasswordVisible,
                      suffixAction: cubit.togglePassword,
                    ),
                    CustomTextField(
                      controller: cubit.txtConfirmNewPassword,
                      hint: "Enter new password again",
                      prefixPath: AppAssets.password,
                      label: "Confirm New Password",
                      suffixPath: state.isPasswordVisible
                          ? AppAssets.notVisible
                          : AppAssets.visible,
                      hide: !state.isPasswordVisible,
                      suffixAction: cubit.togglePassword,
                      bottomPadding: 0,
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    CustomButton(
                        text: "Change Password",
                        action: cubit.changePasswordAction,
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
