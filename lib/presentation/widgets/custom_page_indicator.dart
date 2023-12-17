import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';

class CustomPageIndicator extends StatelessWidget {
  final int itemCount;
  final int currentIndex;

  CustomPageIndicator({
    super.key,
    required this.itemCount,
    required this.currentIndex,
  });

  final CarouselController controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.w,
      padding: EdgeInsets.symmetric(vertical: 5.h,horizontal: 5.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.r),
        color: Colors.white.withOpacity(0.3)
      ),
      child: PageViewDotIndicator(
          currentItem: currentIndex,
          count: itemCount,
          unselectedColor: Colors.white,
          selectedColor: Theme.of(context).primaryColor,
          size: const Size(12, 12),
          unselectedSize: const Size(8, 8),
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 5),
          padding: EdgeInsets.zero,
          fadeEdges: true,
          boxShape: BoxShape.circle, //defaults to circle
          onItemClicked: (index) {
          }
      ),
    );
    // _scrollIt();
    // return SizedBox(
    //   width: 100.w,
    //   child: CarouselSlider(
    //     carouselController: controller,
    //     items: [
    //       for (int index = 0; index < itemCount; index++)
    //         Padding(
    //           padding: EdgeInsets.symmetric(horizontal: 3.w),
    //           child: CircleAvatar(
    //             radius: 5,
    //             backgroundColor:currentIndex==index?
    //             Theme.of(context).primaryColor:Theme.of(context).colorScheme.surface,
    //           ),
    //         ),
    //     ],
    //     options: CarouselOptions(
    //       height: 20,
    //       viewportFraction: 0.45,
    //       onPageChanged: (val, _) {},
    //     ),
    //   ),
    // );
  }
  _scrollIt(){
    if(itemCount>3){
      if(currentIndex>2){
        debugPrint("Animated page");
        controller.animateToPage(currentIndex);
      }
    }
  }
}
