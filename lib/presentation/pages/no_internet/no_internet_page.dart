import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:triplaner/util/app_assets.dart';
import 'package:triplaner/util/app_theme.dart';
import '../../../util/app_constant.dart';
import '../../widgets/custom_button.dart';
import 'no_internet_cubit.dart';
import 'no_internet_initial_params.dart';
import 'no_internet_state.dart';

class NoInternetPage extends StatefulWidget {
  final NoInternetCubit cubit;

  const NoInternetPage({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<NoInternetPage> createState() => _NoInternetState();
}

class _NoInternetState extends State<NoInternetPage> {
  NoInternetCubit get cubit => widget.cubit;

  @override
  void initState() {
    super.initState();
    cubit.navigator.context = context;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          body: Center(
            child: Padding(
              padding: AppConstant.screenPadding,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(AppAssets.noInternet,height: 250.h,),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "Please refresh or check the internet connection!",
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontFamily: AppTheme.montserratAlternates,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 23.h,
                  ),
                  Padding(
                    padding:
                        AppConstant.screenPadding.copyWith(bottom: 20.h, top: 20.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            height: 5.h,
                            width: 100.w,
                            child: Divider(
                              height: 0,
                              thickness: 1,
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondary
                                  .withOpacity(0.5),
                            )),
                        CustomButton(
                          text: "Refresh",
                          action:cubit.onRefresh,
                          width: 89.w,
                          height: 32.h,
                        ),
                        SizedBox(
                            height: 5.h,
                            width: 100.w,
                            child: Divider(
                              height: 0,
                              thickness: 1,
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondary
                                  .withOpacity(0.5),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
