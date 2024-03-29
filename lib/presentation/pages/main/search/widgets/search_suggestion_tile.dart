import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:triplaner/domain/entities/search_location.dart';
import 'package:triplaner/domain/entities/search_suggestion.dart';
import 'package:triplaner/util/app_assets.dart';
import 'package:triplaner/util/app_constant.dart';
import 'package:triplaner/util/app_style.dart';

class SearchSuggestionTile extends StatelessWidget {
  final SearchLocation searchSuggestion;
  final VoidCallback onTap;

  const SearchSuggestionTile({Key? key,required this.searchSuggestion,required this.onTap}) : super(key: key);

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
                  SvgPicture.asset(AppAssets.location,height: 32.h,width: 32.h,),
                  SizedBox(width: 12.w,),
                  Expanded(
                    child: Text("${searchSuggestion.name}",style: AppStyle.searchResultTextStyle(context),),
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
