import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../util/app_assets.dart';
import 'load_more_button.dart';

class CustomSingleChildScrollViewWithLoadMore extends StatefulWidget {
  final VoidCallback onLoadMore;
  final Widget child;
  final bool isLoadingMore;
  final bool isEmpty;
  final bool enableScrollUp;

  const CustomSingleChildScrollViewWithLoadMore({
    super.key,
    required this.onLoadMore,
    required this.child,
    this.isLoadingMore = false,
    this.isEmpty = false,
    this.enableScrollUp = false,
  });

  @override
  State<CustomSingleChildScrollViewWithLoadMore> createState() =>
      _CustomSingleChildScrollViewWithLoadMoreState();
}

class _CustomSingleChildScrollViewWithLoadMoreState
    extends State<CustomSingleChildScrollViewWithLoadMore> {
  final ScrollController _scrollController = ScrollController();

  bool showIcon = false;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        debugPrint(notification.metrics.extentBefore.toString());
        if (notification.metrics.extentBefore > 300) {
          setState(() {
            showIcon = true;
          });
        } else {
          setState(() {
            showIcon = false;
          });
        }
        if (notification is ScrollEndNotification &&
            notification.metrics.extentAfter == 0.0) {
          // onScrollEndReached.call();
        }
        return false;
      },
      child: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: <Widget>[
                widget.child,
                widget.isEmpty == true
                    ? const SizedBox()
                    : LoadMoreButton(
                        onLoadMore: widget.onLoadMore,
                        isLoading: widget.isLoadingMore,
                        isEmpty: widget.isEmpty,
                      ),
              ],
            ),
          ),
          Positioned.fill(
              child: Align(
                  alignment: Alignment.bottomRight,
                  child: Visibility(
                    visible: widget.enableScrollUp && showIcon,
                    child: GestureDetector(
                      onTap: () {
                        _scrollController.animateTo(
                          0,
                          duration: const Duration(milliseconds: 500),
                          // Adjust the duration as needed.
                          curve: Curves
                              .easeIn, // Use a different curve if desired.
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 50.h),
                        child: SvgPicture.asset(
                          AppAssets.scrollUp,
                          height: 50.h,
                        ),
                      ),
                    ),
                  ))),
        ],
      ),
    );
  }
}
