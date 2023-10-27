import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../util/app_assets.dart';
import '../../../../../util/app_constant.dart';
import 'login_top_text.dart';

class LoginFormBackground extends StatelessWidget {
  final Widget child;
  const LoginFormBackground({Key? key,required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return      Column(
      children: [
        Padding(
          padding: AppConstant.screenPadding.copyWith(top: 16.h),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: SvgPicture.asset(
                    AppAssets.circularBack,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              const LoginTopText(),
            ],
          ),
        ),
        Expanded(
          child: Container(
            width: 1.sw,
            margin: EdgeInsets.only(top: 11.h),
            padding:
            EdgeInsets.symmetric(horizontal: 24.h, vertical: 16.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(24.r),
                topLeft: Radius.circular(24.r),
              ),
              color: Theme.of(context).colorScheme.surface,
            ),
            child: child
          ),
        )
      ],
    );
  }
}
