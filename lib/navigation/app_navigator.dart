import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../presentation/widgets/custom_blur_background.dart';
import '../util/app_colors.dart';
import 'routing_animation.dart';



class AppNavigator {
  static final  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  push(BuildContext context, Widget page) {
    Navigator.push(
      context,
      RoutingAnimation(child: page),
    );
  }

  replace(BuildContext context, Widget page) {
    Navigator.pushReplacement(
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

  showBottomSheet(BuildContext context, Widget page,
      {double? height, EdgeInsets? padding}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      constraints: BoxConstraints(maxHeight: 1.sh),
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (context) => CustomBlurBackground(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            height: height??600.h,
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
              clipBehavior: Clip.antiAlias,
              // Set clipBehavior to Clip.antiAlias
              child: page,
            ),
          ),
        ),
      ),
    );
  }
  pop(BuildContext context) {
    Navigator.pop(context);
  }

  showDialogBox(BuildContext context, Widget page) {
    showCupertinoDialog(
        context: context,
        //barrierColor: Theme.of(context).colorScheme.tertiaryContainer.withOpacity(0.6),
      //  barrierColor: Colors.transparent,

        builder: (context) {
          return page;
        });
  }
}
