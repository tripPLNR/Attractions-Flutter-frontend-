import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginTile extends StatelessWidget {
  final VoidCallback onLogin;
  const LoginTile({Key? key,required this.onLogin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onLogin,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Column(
          children: [
            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Login",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 26.sp,
                      color: Theme.of(context)
                          .colorScheme
                          .primary),
                ),
                Icon(
                  Icons.arrow_forward_ios_sharp,
                  color: Theme.of(context)
                      .colorScheme
                      .primary,
                  size: 20.r,
                ),
              ],
            ),
            SizedBox(
              height: 12.h,
            ),
            const Divider(
              height: 0,
              thickness: 1,
            )
          ],
        ),
      ),
    );
  }
}
