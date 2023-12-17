import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:triplaner/navigation/app_navigator.dart';
import 'package:triplaner/util/app_assets.dart';
import 'package:triplaner/util/app_constant.dart';
import 'package:triplaner/util/app_style.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double? height;

  final Widget? titleWidget;
  final List<Widget>? action;
  final bool hideBack;
  final bool centerTitle;

  final int? actionFlex;
  final VoidCallback? onBack;
  const CustomAppBar({
    super.key,
    required this.title,
    this.titleWidget,
    this.height,
    this.action,
    this.hideBack=false,
    this.centerTitle=false,
    this.actionFlex=1,
    this.onBack,

  });

  @override
  Size get preferredSize => Size.fromHeight(height??AppConstant.appBarHeight);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: preferredSize.height,
      padding: EdgeInsets.symmetric(horizontal: 24.w).copyWith(top: MediaQuery.of(context).viewPadding.top),
      decoration: BoxDecoration(
          gradient: AppStyle.linearGradient(),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(13.r),
              bottomRight: Radius.circular(13.r))),
      child: titleWidget??Row(
        children: [
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.centerLeft,
              child: hideBack?const SizedBox():GestureDetector(
                  onTap: onBack??() {
                   Navigator.pop(context);
                  },
                  child: SvgPicture.asset(
                    AppAssets.circularBack,
                    height: 40.h,
                    width: 40.h,
                  )),
            ),
          ),
          Expanded(
            flex: 5,
            child: Align(
              alignment:centerTitle?Alignment.center:action == null?Alignment.centerLeft:Alignment.center,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 21.sp,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.onPrimary),
                ),
              ),
            ),
          ),
          Expanded(
            flex: actionFlex??1,
            child: action == null
                ? const SizedBox()
                : Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: action!,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
