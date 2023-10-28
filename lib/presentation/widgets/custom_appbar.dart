import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:triplaner/util/app_assets.dart';
import 'package:triplaner/util/app_constant.dart';
import 'package:triplaner/util/app_style.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? action;
  final bool hideBack;
  final int? actionFlex;
  const CustomAppBar({
    super.key,
    required this.title,
    this.action,
    this.hideBack=false,
    this.actionFlex=1,

  });

  @override
  Size get preferredSize => Size.fromHeight(100.h);

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
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.centerLeft,
              child: hideBack?const SizedBox():GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: SvgPicture.asset(
                    AppAssets.circularBack,
                    height: 40.h,
                    width: 40.w,
                  )),
            ),
          ),
          Expanded(
            flex: 5,
            child: Align(
              alignment: Alignment.center,
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
