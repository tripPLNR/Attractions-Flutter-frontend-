
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../app_colors.dart';

enum SnackBarType{
  ERROR,
  SUCCESS,
  INFO
}

class AppSnackBar{
  show({required BuildContext context,required String info,SnackBarType snackBarType=SnackBarType.ERROR}){
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
         shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.only(
             topLeft: Radius.circular(10.r),
             topRight: Radius.circular(10.r),

           ),
         ),
        content: Row(
          children: [
             Icon(getLeadingIcon(snackBarType),color:Colors.white,),
            SizedBox(width: 10.w,),
            Text(info,style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.bold),),
          ],
        ),
        backgroundColor: getColor(snackBarType),
         //behavior: SnackBarBehavior.floating,
         padding: EdgeInsets.symmetric(vertical: 15.h,horizontal: 10.w),
         elevation: 6.0,
      ),
    );
  }

  Color getColor(SnackBarType snackBarType){
    switch(snackBarType){
      case SnackBarType.ERROR:
        return Colors.red;
      case SnackBarType.INFO:
        return AppColors.primaryColor;
      case SnackBarType.SUCCESS:
        return Colors.green;
    }
  }

  IconData getLeadingIcon(SnackBarType snackBarType){
    switch(snackBarType){
      case SnackBarType.ERROR:
        return Icons.close;
      case SnackBarType.INFO:
        return Icons.info;
      case SnackBarType.SUCCESS:
        return Icons.check_circle;
    }
  }
}