import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:triplaner/util/app_assets.dart';
import 'package:triplaner/util/app_constant.dart';
import 'package:triplaner/util/app_theme.dart';

class HomeAppBar extends StatelessWidget {
  final VoidCallback onSearchTap;
  const HomeAppBar({Key? key,required this.onSearchTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: 1.sw,
      padding:AppConstant.screenPadding.copyWith(top: 30.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(13.r),
          bottomRight: Radius.circular(13.r),
        ),
          image: DecorationImage(
              image: AssetImage(
                AppAssets.homeTop,
              ),
              fit: BoxFit.cover
          )
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text.rich(
              TextSpan(
                children: [
                  WidgetSpan(
                    child: SizedBox(
                      height: 40.h,
                      child: Stack(
                        children: [
                          SvgPicture.asset(AppAssets.t,),
                          Text('   ripPLNR',style: TextStyle(
                              fontSize: 32.sp,
                              fontWeight: FontWeight.w400,
                              fontFamily: AppTheme.petronaFontFamily,
                              color: Theme.of(context).colorScheme.primary
                          )),
                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ),
            GestureDetector(
                onTap: onSearchTap,
                child: SvgPicture.asset(AppAssets.circularSearch,color: Theme.of(context).colorScheme.surface,)),
          ],
        ),
      ),
    );
  }
}
