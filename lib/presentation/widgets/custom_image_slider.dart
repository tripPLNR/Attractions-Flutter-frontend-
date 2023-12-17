import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_cache_image.dart';
import 'custom_page_indicator.dart';

class CustomImageSlider extends StatefulWidget {
  List<String> images;
  double? height;
  double? width;
  BorderRadius? borderRadius;
  int? maximumDotCounts;

  CustomImageSlider(
      {Key? key,
      required this.images,
      this.height,
      this.width,
      this.borderRadius,
      this.maximumDotCounts})
      : super(key: key);

  @override
  State<CustomImageSlider> createState() => _CustomImageSliderState();
}

class _CustomImageSliderState extends State<CustomImageSlider> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height ?? 320.h,
      width: widget.width ?? 1.sw,
      child: Stack(
        children: [
          CarouselSlider(
            options: CarouselOptions(
                height: widget.height ?? 320.h,
                // aspectRatio: 16 / 9,
                viewportFraction: 1,
                initialPage: 0,
                enableInfiniteScroll: false,
                reverse: false,
                autoPlay: false,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                enlargeFactor: 0.1,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index, reason) {
                  setState(() {
                    pageIndex = index;
                  });
                }),
            items: widget.images.map((imgUrl) {
              return Builder(
                builder: (BuildContext context) {
                  return Hero(
                    tag: imgUrl,
                    child: CustomCacheImage(
                      imgUrl: imgUrl,
                      width: widget.width,
                      borderRadius: widget.borderRadius ??
                          BorderRadius.only(
                            bottomLeft: Radius.circular(12.r),
                            bottomRight: Radius.circular(12.r),
                          ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 15.h),
                child: CustomPageIndicator(
                  currentIndex: pageIndex,
                  itemCount: widget.images.length,
                )
              ),
            ),
          )
        ],
      ),
    );
  }
}
