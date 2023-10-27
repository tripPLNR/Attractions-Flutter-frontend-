import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:triplaner/util/app_assets.dart';

class CustomCacheImage extends StatelessWidget {
  final String imgUrl;
  final double? width;
  final double? height;
  final double? radius;
  final BorderRadius? borderRadius;

  const CustomCacheImage(
      {Key? key,
      required this.imgUrl,
      this.width,
      this.height,
      this.radius,
      this.borderRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(radius ?? 0),
      child: CachedNetworkImage(
        imageUrl: imgUrl,
        height: height,
        width: width,
        fit: BoxFit.cover,
        placeholder: (child, url) => SvgPicture.asset(
          AppAssets.placeHolderImage,
          height: height,
          width: width,
          fit: BoxFit.cover,
        ),
        errorWidget: (child, url,obj) => SvgPicture.asset(
          AppAssets.placeHolderImage,
          height: height,
          width: width,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
