import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:triplaner/util/app_assets.dart';

class CustomCacheImage extends StatefulWidget {
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
  State<CustomCacheImage> createState() => _CustomCacheImageState();
}

class _CustomCacheImageState extends State<CustomCacheImage> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: widget.borderRadius ?? BorderRadius.circular(widget.radius ?? 0),
      child: CachedNetworkImage(
        imageUrl: widget.imgUrl.isEmpty?"https://i0.wp.com/thinkfirstcommunication.com/wp-content/uploads/2022/05/placeholder-1-1.png?fit=1200%2C800&ssl=1":widget.imgUrl,
        height: widget.height,
        width: widget.width,
        fit: BoxFit.cover,
        progressIndicatorBuilder: (child, url,downloadProgress) => SvgPicture.asset(
          AppAssets.placeHolderImage,
          height: widget.height,
          width: widget.width,
          fit: BoxFit.cover,
        ),
        errorWidget: (child, url,obj) => SvgPicture.asset(
          AppAssets.placeHolderImage,
          height: widget.height,
          width: widget.width,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
