import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginTile extends StatelessWidget {
  final VoidCallback onLogin;

  const LoginTile({Key? key, required this.onLogin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: onLogin,
            child: Container(
              width: 1.sw,
              padding: EdgeInsets.symmetric(vertical: 22.h),
              margin: EdgeInsets.symmetric(vertical: 10.h),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.15),
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Login or Signup",
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    SizedBox(width: 20.w,),
                    Icon(Icons.arrow_forward_ios_rounded,size: 18.r,
                      color: Theme.of(context).colorScheme.primary,
                    )
                  ],
                ),
              ),
            ),
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
