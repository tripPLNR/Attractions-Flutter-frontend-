import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:triplaner/presentation/widgets/custom_button.dart';
import 'package:triplaner/util/app_constant.dart';
import '../../../util/app_assets.dart';
import 'confirmation_cubit.dart';
import 'confirmation_initial_params.dart';
import 'confirmation_state.dart';

class ConfirmationPage extends StatefulWidget {
  final ConfirmationCubit cubit;

  const ConfirmationPage({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<ConfirmationPage> createState() => _ConfirmationState();
}

class _ConfirmationState extends State<ConfirmationPage> {
  ConfirmationCubit get cubit => widget.cubit;

  @override
  void initState() {
    super.initState();
    cubit.navigator.context = context;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: BlocBuilder(
          bloc:cubit,
          builder: (context,state) {
            state as ConfirmationState;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 22.w)
                      .copyWith(bottom: 33.h, top: 21.h),
                  margin: AppConstant.screenPadding,
                  width: 1.sw,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                          child: SimpleShadow(
                            opacity: 0.6,
                            // Default: 0.5
                            color: const Color(0xff000000).withOpacity(0.15),
                            // This is the shadow color with alpha (transparency)
                            offset: const Offset(0, 0),
                            // Offset in (dx, dy) format
                            child: SvgPicture.asset(
                              AppAssets.logo,
                              width: 150.h,
                              color: Theme.of(context).primaryColor,
                            ),
                          )),
                      Center(
                        child: Text(
                          cubit.subTitle ?? "Are you sure?",
                          style: TextStyle( fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.onBackground),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomButton(
                            text: "Cancel",
                            action: () {
                              Navigator.pop(context);
                            },
                            height: 35.h,
                            width: 100.w,
                            fontSize: 14.sp,
                            isSecondaryButton: true,
                          ),
                          CustomButton(
                            text: cubit.btnText ?? "Confirm",
                            action: () {
                              Navigator.pop(context);
                              cubit.btnAction();
                            },
                            height: 35.h,
                            fontSize: 14.sp,
                            width: 100.w,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}
