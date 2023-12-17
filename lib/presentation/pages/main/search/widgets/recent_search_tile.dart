import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:triplaner/domain/entities/search_location.dart';
import 'package:triplaner/domain/entities/search_suggestion.dart';
import 'package:triplaner/util/app_assets.dart';
import 'package:triplaner/util/app_constant.dart';

class RecentSearchTile extends StatelessWidget {
  final String search;
  final VoidCallback onTap;

  const RecentSearchTile({Key? key,required this.search,required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onTap,
      child: Padding(
        padding:  EdgeInsets.only(bottom: 10.h),
        child: Column(
          children: [
            Padding(
              padding: AppConstant.screenPadding,
              child: Row(
                children: [
                  Icon(Icons.refresh,size: 20.h,),
                  SizedBox(width: 12.w,),
                  Expanded(
                    child: Text(search,style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600
                    ),),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h,),
            const Divider(
              thickness: 0.5,
              height: 0,
            )
          ],
        ),
      ),
    );
  }
}
