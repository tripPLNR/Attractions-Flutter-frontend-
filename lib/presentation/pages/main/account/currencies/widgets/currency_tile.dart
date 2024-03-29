import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:triplaner/domain/entities/app_currency.dart';
import 'package:triplaner/util/app_assets.dart';

class CurrencyTile extends StatelessWidget {
  final AppCurrency currency;
  final VoidCallback? onTap;

  final bool isSelected;

  const CurrencyTile({Key? key,this.isSelected=false,required this.currency,this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.secondary,
          ),
          borderRadius: BorderRadius.circular(20.r),
        ),
        padding: EdgeInsets.symmetric(vertical: 9.h,horizontal: 20.w),
        margin: EdgeInsets.symmetric(vertical: 6.h),
        child: Row(
          children: [
            Expanded(
              child: Text('${currency.name}',style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600
              ),),
            ),

            SvgPicture.asset(isSelected?AppAssets.selectedRadio:AppAssets.unSelectedRadio),
          ],
        ),
      ),
    );
  }
}
