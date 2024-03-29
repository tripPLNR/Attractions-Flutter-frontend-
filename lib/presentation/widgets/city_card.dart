import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:triplaner/domain/entities/city.dart';
import 'package:triplaner/util/app_constant.dart';
import 'package:triplaner/util/app_theme.dart';

import 'custom_cache_image.dart';

class CityCard extends StatelessWidget {
  final City city;
  final VoidCallback? onTap;
  const CityCard({Key? key, required this.city,this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding:EdgeInsets.symmetric(horizontal: 8.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomCacheImage(
              imgUrl: city.thumbnail!,
              height: 130.h,
              width: 120.w,
              radius: 16.r,
            ),
            SizedBox(height: 4.h,),
            Text(
              "${city.cityName}",
              style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0,
                  color: Theme.of(context).colorScheme.onBackground),
            ),
            Text(
              "${city.countryName}",
              style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0,
                  color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5)),
            ),
          ],
        ),
      ),
    );
    // return  Container(
    //   height: 130.h,
    //   width: 120.w,
    //   margin: const EdgeInsets.symmetric(horizontal: 8),
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(16.r),
    //     image:  DecorationImage(
    //       image:CachedNetworkImageProvider(city.thumbnail!),
    //       fit: BoxFit.cover
    //     )
    //   ),
    //   child: Padding(
    //     padding:  EdgeInsets.all(8.h),
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.end,
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Text("${city.name}",style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w500,
    //         color: Theme.of(context).colorScheme.surface
    //         ),)
    //       ],
    //     ),
    //   ),
    // );
  }
}
