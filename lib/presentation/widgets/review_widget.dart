import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:triplaner/presentation/widgets/custom_star_rating.dart';
import 'package:triplaner/util/app_style.dart';
import 'package:triplaner/util/custom_readmore.dart';

class ReviewWidget extends StatelessWidget {
  const ReviewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.tertiary,
                radius: 25.r,
                child: Center(
                  child: Text(
                    "JS",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "John Smith ",
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 2.h,),
                    SizedBox(
                      width: 230.w,
                      child: const CustomReadMore(
                        text:"Love their drink specials. Bartenders super nice. Spent a week at UCSF and ers super nice. Spent a week at UCSF and ent a week at UCSF and ers super nice. Spent a week at UCSF andent a week at UCSF and ers super nice. Spent a week at UCSF and "),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5.h,horizontal: 7.w),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiary,
                  borderRadius: BorderRadius.circular(7.r),
                ),
                child: const Row(
                  children: [
                    CustomStarRating(oneStarMode: true,),
                    Text(" 5.0",style: TextStyle(fontWeight: FontWeight.bold,letterSpacing: 0),)
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 18.h,),
          const Divider(
            thickness: 1,
            height: 0,
          ),
        ],
      ),
    );
  }
}
