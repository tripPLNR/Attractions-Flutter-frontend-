import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:triplaner/util/app_assets.dart';

class AccountTile extends StatelessWidget {
  final String title;
  final String iconPath;
  final VoidCallback onTap;
  final bool hideDivider;

  const AccountTile(
      {Key? key,
      required this.title,
      required this.onTap,
      required this.iconPath,
      this.hideDivider = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
          children: [
            InkWell(
              onTap: onTap,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      iconPath,
                      height: 48.h,
                      width: 48.h,
                    ),
                    SizedBox(
                      width: 12.w,
                    ),
                    Text(
                      title,
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0,
                          color: Theme.of(context).colorScheme.onBackground
                      ),
                    ),
                    Expanded(
                        child: Align(
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.arrow_forward_ios_sharp,
                        color: Theme.of(context).colorScheme.secondary,
                        size: 18.r,
                      ),
                    ))
                  ],
                ),
              ),
            ),
            hideDivider?const SizedBox():Divider(
              thickness: 1,
              height: 0,
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),

            )
          ],
        );
  }
}
