import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../util/app_assets.dart';
import '../../../../../util/app_theme.dart';
import '../../../../widgets/custom_textfield.dart';

class HomeTop extends StatelessWidget {
  final VoidCallback onSearchTap;
  const HomeTop({Key? key,required this.onSearchTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Container(
      width: 1.sw,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(13.r),bottomRight: Radius.circular(13.r)),
          image: DecorationImage(
              image: AssetImage(
                AppAssets.homeTop,
              ),
              fit: BoxFit.cover
          )
      ),
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 53.h,),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(text: 'Explore with',style: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w400,
                    fontFamily: AppTheme.numBrushScriptFontFamily,
                    color: Theme.of(context).colorScheme.onPrimary
                )),
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
          // SizedBox(height: 21.h,),
          CustomTextField(
            controller: TextEditingController(),
            prefixPath: AppAssets.search,
            readOnly: true,
            onTap:onSearchTap,
            label: "",
            hint: "Search Destinations, Activities......",
            bottomPadding: 0,
          ),
        ],
      ),
    );
  }
}
