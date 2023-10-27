import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:triplaner/util/app_assets.dart';

class CustomCircularCacheImage extends StatelessWidget {
  final String imgUrl;
  final double? size;

  const CustomCircularCacheImage({Key? key, required this.imgUrl, this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imgUrl,
      imageBuilder: (context, imageProvider) => Container(
        width: size ?? 80.h,
        height: size ?? 80.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
        ),
      ),
      placeholder: (context, url) =>  CircleAvatar(
        backgroundImage: Svg(
          AppAssets.placeHolderImage,
          size: Size(size??80.h, size??80.h),
        ),
        maxRadius: (size??80.h)*0.5,
      ),
      errorWidget: (context, url, error) =>  CircleAvatar(
          backgroundImage: Svg(
            AppAssets.placeHolderImage,
            size: Size(size??80.h, size??80.h),
          ),
        maxRadius: (size??80.h)*0.5,
      )
    );
  }
}
