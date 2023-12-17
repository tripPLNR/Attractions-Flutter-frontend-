import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:triplaner/presentation/widgets/custom_image_slider.dart';
import 'package:triplaner/util/app_assets.dart';
import 'package:triplaner/util/app_constant.dart';

class SiteDetailTop extends StatelessWidget {
  final List<String> images;
  final VoidCallback onShare;
  final VoidCallback? onBack;
  final VoidCallback? onBookMarkTap;
  final bool isBookMarked;

  const SiteDetailTop({Key? key, required this.images,required this.onShare,this.onBack,required this.isBookMarked,required this.onBookMarkTap}) : super(key: key);

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
                onTap: onBack??(){
                  Navigator.pop(context);
                },
                child: SvgPicture.asset(
                  AppAssets.circularBack,
                ),
              ),
              Row(
                children: [
                  InkWell(
                    onTap: onShare,
                    child: SvgPicture.asset(
                      AppAssets.circularShare,
                      height: 40.h,
                      width: 40.h,
                    ),
                  ),
                  SizedBox(
                    width: 6.w,
                  ),
                  GestureDetector(
                    onTap: onBookMarkTap,
                    child: SvgPicture.asset(
                      isBookMarked?
                      AppAssets.bookmarked:
                      AppAssets.circularBookmark,
                      height: 40.h,
                      width: 40.h,
                    ),
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
