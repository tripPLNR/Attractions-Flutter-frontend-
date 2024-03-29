import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:triplaner/util/app_style.dart';

class AccountCard extends StatelessWidget {
  final List<Widget> children;
  final String title;

  const AccountCard({Key? key, required this.children, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppStyle.accountTileHeading(context),
              ),

              ...children,
            ],
          ),
          SizedBox(height: 5.h,),
          Container(
            height: 5.h,
            width: 1.sw,
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
          )
        ],
      ),
    );
  }
}
