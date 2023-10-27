import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../util/app_assets.dart';
import '../../../../../util/app_theme.dart';
class LoginTopText extends StatelessWidget {
  const LoginTopText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: 'Explore with',style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w400,
                  fontFamily: AppTheme.numBrushScriptFontFamily,
                  color: Theme.of(context).colorScheme.onPrimary
              )),
              WidgetSpan(
                child: SizedBox(
                  height: 30.h,
                  child: Stack(
                    children: [
                      SvgPicture.asset(AppAssets.t,
                        color: Theme.of(context).colorScheme.surface,
                      ),
                      Text('     ripPLNR',style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w400,
                          fontFamily: AppTheme.petronaFontFamily,
                          color: Theme.of(context).colorScheme.onPrimary
                      )),
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),

        SizedBox(
          height: 7.h,
        ),
        Text(
          "tripPLNR is here to revolutionize the way you plan, experience & cherish your travels.",
          style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              fontFamily: AppTheme.montserratAlternates,
              color: Theme.of(context)
                  .colorScheme
                  .onPrimary
                  .withOpacity(0.6)),
        )
      ],
    );
  }
}
