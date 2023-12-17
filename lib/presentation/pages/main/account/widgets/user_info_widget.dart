import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:triplaner/domain/entities/user.dart';

class UserInfoWidget extends StatelessWidget {
  final User user;
  const UserInfoWidget({Key? key,required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 28.r,
                backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.15),
                child: Text(user.firstName.toString().substring(0,2).toUpperCase(),
                  style: TextStyle(color: Theme.of(context).colorScheme.primary,
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w700,
                    letterSpacing: 0
                  ),
                ),
              ),
              SizedBox(width: 10.w,),
              // SizedBox(
              //   width:1.sw-100.w,
              //   child: Text("${user.email}",style: TextStyle(
              //       fontSize: 24.sp,
              //       fontWeight: FontWeight.bold,
              //     overflow: TextOverflow.ellipsis
              //   ),),
              // ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${user.firstName} ${user.lastName}",style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 24.sp,
                    color: Theme.of(context).colorScheme.onBackground
                  ),),
                  Text("${user.email}",style: TextStyle(
                      fontSize: 14.sp,
                      color: Theme.of(context).colorScheme.onBackground
                  ),),

                ],
              )
            ],
          ),
          SizedBox(height: 12.h,),
          const Divider(height: 0,thickness: 1,)
        ],
      ),
    );
  }
}
