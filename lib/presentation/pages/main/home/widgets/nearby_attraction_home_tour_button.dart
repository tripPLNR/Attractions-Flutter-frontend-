import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../util/app_assets.dart';
import '../../../../../util/app_constant.dart';
import '../../../../../util/app_theme.dart';

class NearbyAttractionHomeTourButton extends StatelessWidget {
  final VoidCallback onNearbyAttractionTap;
  final VoidCallback onGuidedTourTap;

  const NearbyAttractionHomeTourButton({Key? key,required this.onGuidedTourTap,required this.onNearbyAttractionTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: AppConstant.screenPadding,
      padding: EdgeInsets.symmetric(horizontal: 6.w,vertical: 13.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r,),
        color: Theme.of(context).colorScheme.surface,
        border: Border.all(color:Theme.of(context).colorScheme.secondary.withOpacity(0.3),width: 1),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            customWidget(isPrimary: true,assetPath: AppAssets.nearbyAttraction,title: "Nearby Attractions",context:context,onTap: onNearbyAttractionTap),
            SizedBox(width: 16.w,),
            customWidget(assetPath: AppAssets.guidedPrivateTour,title: "Guided & Private tours",context:context,onTap: onGuidedTourTap),

          ],
        ),
      ),
    );
  }



  Widget customWidget({bool isPrimary=false,required String assetPath,required String title,required BuildContext context,required VoidCallback onTap}){
    return InkWell(
      onTap: onTap,
      child: Container(
        // width: 146.w,
        height: 46.h,
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            color: isPrimary?Theme.of(context).colorScheme.tertiary:Theme.of(context).colorScheme.surface,
            border: Border.all(
              width: 0.5,
              color:  isPrimary?Theme.of(context).colorScheme.primary:Theme.of(context).colorScheme.secondary,
            )
        ),
        child: Center(child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(assetPath,height: 24.h,width: 24.w,),
            SizedBox(width: 8.w,),
            SizedBox(
              width: 95.w,
              child: Text(title,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: AppTheme.montserrat,
                ),
              ),
            )
          ],
        ),),
      ),
    );
  }
}
