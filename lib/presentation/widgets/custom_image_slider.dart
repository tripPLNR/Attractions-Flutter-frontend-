import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'custom_cache_image.dart';

class CustomImageSlider extends StatefulWidget {
  List<String> images;
  double? height;
  double? width;
  BorderRadius? borderRadius;

  CustomImageSlider({Key? key, required this.images,this.height,this.width,this.borderRadius}) : super(key: key);

  @override
  State<CustomImageSlider> createState() => _CustomImageSliderState();
}

class _CustomImageSliderState extends State<CustomImageSlider> {

  int pageIndex=0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:widget.height??280.h,
      width:widget.width?? 1.sw,
      child: Stack(
        children: [
          CarouselSlider(
            options: CarouselOptions(
                height: widget.height??280.h,
                // aspectRatio: 16 / 9,
                 viewportFraction: 1,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: false,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                 enlargeFactor: 0.1,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index,reason){
                  setState(() {
                    pageIndex=index;
                  });
                }
            ),
            items: widget.images.map((imgUrl) {
              return Builder(
                builder: (BuildContext context) {
                  return Hero(
                    tag: imgUrl,
                    child: CustomCacheImage(
                      imgUrl: imgUrl,
                      width: widget.width,
                      borderRadius: widget.borderRadius??BorderRadius.only(
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
                child: Container(
                  padding: EdgeInsets.all(5.h),
                  margin: EdgeInsets.symmetric(horizontal: 5.w),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(50.r),
                  ),
                  child: AnimatedSmoothIndicator(
                    activeIndex: pageIndex,
                    count: widget.images.length,
                    // count: widget.images.length>5?5:widget.images.length,
                    effect: JumpingDotEffect(
                        activeDotColor: Theme.of(context).colorScheme.primary,
                        dotColor: Theme.of(context).colorScheme.onPrimary,
                        spacing: 10,
                        dotHeight: 10.h,
                        dotWidth: 10.h
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}