import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:triplaner/presentation/widgets/custom_image_slider.dart';
import 'package:triplaner/util/app_assets.dart';
import 'package:triplaner/util/app_constant.dart';

class SiteDetailTop extends StatelessWidget {
  final List<String> images;

  const SiteDetailTop({Key? key, required this.images}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomImageSlider(
          width: 1.sw,
          images: images,
        ),
        Padding(
          padding: AppConstant.screenPadding.copyWith(top: MediaQuery.of(context).viewPadding.top+16.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: SvgPicture.asset(
                  AppAssets.circularBack,
                ),
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    AppAssets.circularShare,
                    height: 40.h,
                    width: 40.h,
                  ),
                  SizedBox(
                    width: 6.w,
                  ),
                  SvgPicture.asset(
                    AppAssets.circularBookmark,
                    height: 40.h,
                    width: 40.h,
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
