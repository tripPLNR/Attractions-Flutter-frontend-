
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
    ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
        content: Text(info,style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.bold),),
        backgroundColor: getColor(snackBarType),
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
}