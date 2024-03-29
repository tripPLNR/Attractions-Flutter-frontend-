import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:triplaner/presentation/widgets/custom_blur_background.dart';
import 'package:triplaner/util/app_assets.dart';
import 'package:triplaner/util/app_constant.dart';
import 'package:triplaner/util/app_funtions.dart';
import 'package:triplaner/util/app_theme.dart';
import 'redirect_popup_cubit.dart';
import 'redirect_popup_initial_params.dart';
import 'redirect_popup_state.dart';
import 'widget/custom_progress_indicator.dart';

class RedirectPopupPage extends StatefulWidget {
  final RedirectPopupCubit cubit;

  const RedirectPopupPage({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<RedirectPopupPage> createState() => _RedirectPopupState();
}

class _RedirectPopupState extends State<RedirectPopupPage> {
  RedirectPopupCubit get cubit => widget.cubit;

  @override
  void initState() {
    super.initState();
    cubit.navigator.context = context;
  }

  @override
  Widget build(BuildContext context) {
    return CustomBlurBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: BlocBuilder<RedirectPopupCubit, RedirectPopupState>(
            bloc: cubit,
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 22.w)
                        .copyWith(bottom: 20.h, top: 21.h),
                    margin: AppConstant.screenPadding,
                    width: 1.sw,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          AppAssets.logo,
                          width: 150.w,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        Text("Hold onto your hats! You’re being directed to affiliates platform to secure the purchase.",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: AppTheme.montserratAlternates,
                          fontWeight: FontWeight.w600,
                        ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20.h,),
                        CustomProgressIndicator(
                          onAnimationComplete: (){
                            cubit.navigate();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
