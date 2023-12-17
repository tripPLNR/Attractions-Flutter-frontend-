import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:triplaner/util/app_assets.dart';

class AccountTile extends StatelessWidget {
  final String title;
  final String iconPath;
  final VoidCallback onTap;
  final bool hide;

  const AccountTile(
      {Key? key,
      required this.title,
      required this.onTap,
      required this.iconPath,
      this.hide = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return hide
        ? const SizedBox()
        : InkWell(
            onTap: onTap,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: SizedBox(
              height: 72.h,
              width: 1.sw,
              // margin: EdgeInsets.only(top: 5.h),
              child: Center(
                child: Column(
                  children: [
                    Row(
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
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0,
                              color: Theme.of(context).colorScheme.onBackground
                          ),
                        ),
                        Expanded(
                            child: Align(
                          alignment: Alignment.centerRight,
                          child: Icon(
                            Icons.arrow_forward_ios_sharp,
                            color: Theme.of(context).colorScheme.primary,
                            size: 20.r,
                          ),
                        ))
                      ],
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    const Divider(
                      thickness: 1,
                      height: 0,
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
