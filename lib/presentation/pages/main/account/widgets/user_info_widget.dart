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
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: Text(user.firstName![0].toUpperCase(),
                  style: TextStyle(color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700
                  ),
                ),
              ),
              SizedBox(width: 10.w,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${user.firstName} ${user.lastName}",style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp
                  ),),
                  Text("${user.email}",style: TextStyle(
                      fontSize: 12.sp,
                      fontStyle: FontStyle.italic
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
