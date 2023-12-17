import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:triplaner/presentation/widgets/custom_loader.dart';

import '../../util/app_assets.dart';
import 'load_more_button.dart';

class CustomSingleChildScrollViewWithLoadMore extends StatefulWidget {
  final VoidCallback onLoadMore;
  final VoidCallback? onScrollEndReached;
  final VoidCallback? onScrollUp;
  final VoidCallback? onScrollDown;

  final Widget child;
  final String? noMoreText;
  final bool isLoadingMore;
  final bool isEmpty;
  final bool noMoreRecord;
  final bool enableScrollUp;

  const CustomSingleChildScrollViewWithLoadMore({
    super.key,
    required this.onLoadMore,
    this.onScrollEndReached,
    this.onScrollDown,
    this.noMoreText,
    this.onScrollUp,
    required this.child,
    this.isLoadingMore = false,
    this.isEmpty = false,
    this.noMoreRecord = false,
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
        debugPrint(notification.metrics.axisDirection.toString());
        if (_scrollController.position.userScrollDirection ==
            ScrollDirection.reverse) {
          widget.onScrollDown == null ? null : widget.onScrollDown!();
          //the setState function
        } else if (_scrollController.position.userScrollDirection ==
            ScrollDirection.forward) {
          widget.onScrollUp == null ? null : widget.onScrollUp!();
          //setState function
        }
        if (notification.metrics.axisDirection == AxisDirection.right) {
          return false;
        }
        if (notification.metrics.extentBefore > 1600) {
          setState(() {
            showIcon = true;
          });
        } else {
          setState(() {
            showIcon = false;
          });
        }
        /// 1. if user is 1600 pixel is up from bottom
        /// 2. if it's not already loading
        /// 3. if record is not ended yet
        /// 4. then auto call api
        if (notification is ScrollEndNotification && notification.metrics.extentAfter <= 1600 && widget.isLoadingMore == false && widget.noMoreRecord==false) {
          if (widget.onScrollEndReached != null) {
            widget.onScrollEndReached!();
          }
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
                    : widget.noMoreRecord
                        ? Padding(
                          padding: EdgeInsets.symmetric(vertical: 15.h),
                          child: Text(
                            widget.noMoreText??"No more records",
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w700,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondary),
                            ),
                        )
                        : widget.isLoadingMore?
                          CustomLoader():
                          LoadMoreButton(
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
                          height: 45.h,
                        ),
                      ),
                    ),
                  ))),
        ],
      ),
    );
  }
}
