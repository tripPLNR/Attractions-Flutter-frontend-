import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:triplaner/presentation/widgets/custom_button.dart';
import 'package:triplaner/presentation/widgets/custon_safe_area.dart';
import 'package:triplaner/presentation/widgets/otp_textfield.dart';
import 'package:triplaner/util/app_assets.dart';
import 'package:triplaner/util/app_extentions.dart';
import 'package:triplaner/util/app_style.dart';
import '../../../../util/app_constant.dart';
import 'otp_cubit.dart';
import 'otp_initial_params.dart';
import 'otp_state.dart';

class OtpPage extends StatefulWidget {
  final OtpCubit cubit;

  const OtpPage({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<OtpPage> createState() => _OtpState();
}

class _OtpState extends State<OtpPage> {
  OtpCubit get cubit => widget.cubit;

  @override
  void initState() {
    super.initState();
    cubit.navigator.context = context;
    cubit.onInit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<OtpCubit, OtpState>(
            bloc: cubit,
            builder: (context, state) {
              return Padding(
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
                        "OTP Verification",
                        style: AppStyle.authHeadingStyle(context),
                      ),
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    RichText(
                        text: TextSpan(
                      text: "We have sent OTP to ",
                          style: AppStyle.authSubHeadingStyle(context),
                          children: [
                            TextSpan(
                              text: state.emailOrPhoneNumber,
                              style: AppStyle.authSubHeadingStyle(context).copyWith(fontWeight:FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary
                              ),
                            ),
                            const TextSpan(
                              text: ". Please check your inbox or spam folder.",
                            ),

                          ]
                    )),
                    SizedBox(
                      height: 31.h,
                    ),
                    OtpTextField(
                      onSubmit: cubit.onSubmitOtp,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.h),
                      child: state.resending
                          ? Center(
                              child: Text(
                                "Resending....",
                                style: AppStyle.authSubHeadingStyle(context),
                              ),
                            )
                          : state.remainingSeconds == 0
                              ? Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                          text:
                                              'Did not receive the OTP? ',
                                          style: AppStyle.authSubHeadingStyle(
                                              context),
                                          children: [
                                            TextSpan(
                                              text: 'Send Code Again.',
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = cubit.resendOtp,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 0,
                                                decoration:
                                                    TextDecoration.underline,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                              ),
                                            )
                                          ]),
                                    ],
                                  ),
                                  textAlign: TextAlign.center,
                                )
                              : Text(
                                  state.remainingSeconds.toTimeString(),
                                  style: AppStyle.authSubHeadingStyle(context),
                                ),
                    ),
                    SizedBox(
                      height: 31.h,
                    ),
                    CustomButton(
                      text: "Verify",
                      action: cubit.verifyOtp,
                      isLoading: state.loading,
                    ),
                  ],
                ),
              );
            }));
  }
}
