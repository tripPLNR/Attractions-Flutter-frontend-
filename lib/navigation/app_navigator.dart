import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../util/app_colors.dart';
import 'routing_animation.dart';

final GlobalKey<ScaffoldState> globalKey = GlobalKey(); // Create a key


class AppNavigator {

  push(BuildContext context, Widget page) {
    Navigator.push(
      context,
      RoutingAnimation(child: page),
    );
  }

  pushAndClearAllPrevious(BuildContext context, Widget page) {
    Navigator.pushAndRemoveUntil<dynamic>(
      context,
      RoutingAnimation(child: page),
      (route) => false, //if you want to disable back feature set to false
    );
  }

  showBottomSheet(BuildContext context, Widget page,{double? height,EdgeInsets? padding}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      constraints: BoxConstraints(
        maxHeight: height??600.h
      ),
      backgroundColor: AppColors.whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(40.r)),
      ),
      builder: (context) =>  ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(40.r)),
        clipBehavior: Clip.antiAlias, // Set clipBehavior to Clip.antiAlias
        child: Padding(
          padding:padding??EdgeInsets.only(left: 30.w,top: 25.h,right: 30.h,bottom: 10),
          child: page,
        ),
      ),
    );

  }

  pop(BuildContext context) {
    Navigator.pop(context);
  }

  showDialogBox(BuildContext context, Widget page) {
    showDialog(
        context: context,
        //barrierColor: Theme.of(context).colorScheme.tertiaryContainer.withOpacity(0.6),
      //  barrierColor: Colors.transparent,

        builder: (context) {
          return page;
        });
  }
}
