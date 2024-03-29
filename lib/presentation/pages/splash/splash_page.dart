import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:triplaner/util/app_assets.dart';
import 'splash_cubit.dart';

class SplashPage extends StatefulWidget {
  final SplashCubit cubit;

  const SplashPage({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashState();
}

class _SplashState extends State<SplashPage> {
  SplashCubit get cubit => widget.cubit;

  @override
  void initState() {
    super.initState();
    cubit.navigator.context = context;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              AppAssets.splashLogo,
              height: 60.h,
            ),
            SizedBox(height: 10.h,),
            DefaultTextStyle(
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                    color: Theme.of(context).colorScheme.onPrimary
                ),
              textAlign: TextAlign.center,
              child: AnimatedTextKit(
                isRepeatingAnimation: false,
                animatedTexts: [
                  TypewriterAnimatedText('Discover, plan and conquer',
                  speed: const Duration(milliseconds: 70),
                    textAlign: TextAlign.center
                  ),
                ],
                onFinished: (){
                  cubit.onInit();
                },
                onTap: () {
                  print("Tap Event");
                },
              ),
            ),
            // Text("Discover, plan and conquer",style: TextStyle(
            //   fontWeight: FontWeight.w500,
            //   fontSize: 16.sp,
            //   color: Theme.of(context).colorScheme.onPrimary
            // ),),
          ],
        ),
      ),
    );
  }
}
