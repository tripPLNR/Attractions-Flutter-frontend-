import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:triplaner/presentation/widgets/custom_chip.dart';
import 'package:triplaner/presentation/widgets/custom_loader.dart';

import '../../util/app_assets.dart';
import 'load_more_button.dart';

class CustomSingleChildScrollViewWithLoadMore extends StatefulWidget {
  final VoidCallback onLoadMore;
  final VoidCallback? onScrollEndReached;

  final Widget child;
  final String? noMoreText;
  final bool isLoadingMore;
  final bool isEmpty;
  final bool noMoreRecord;
  final bool enableScrollUp;

  final VoidCallback? filterAction;

  const CustomSingleChildScrollViewWithLoadMore(
      {super.key,
      required this.onLoadMore,
      this.onScrollEndReached,
      this.noMoreText,
      required this.child,
      this.isLoadingMore = false,
      this.isEmpty = false,
      this.noMoreRecord = false,
      this.enableScrollUp = false,
      this.filterAction});

  @override
  State<CustomSingleChildScrollViewWithLoadMore> createState() =>
      _CustomSingleChildScrollViewWithLoadMoreState();
}

class _CustomSingleChildScrollViewWithLoadMoreState
    extends State<CustomSingleChildScrollViewWithLoadMore> {
  final ScrollController _scrollController = ScrollController();
  ValueNotifier<bool> showIconNotifier = ValueNotifier<bool>(false);
  ValueNotifier<ScrollDirection?> scrollDirectionNotifier =
      ValueNotifier<ScrollDirection?>(null);

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        scrollDirectionNotifier.value = ScrollDirection.reverse;
      } else if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        scrollDirectionNotifier.value = ScrollDirection.forward;
      } else {
        scrollDirectionNotifier.value = null;
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    showIconNotifier.dispose();
    scrollDirectionNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification.metrics.axisDirection == AxisDirection.right) {
            return false;
          }
          if (notification.metrics.extentBefore > 1600) {
            debugPrint("Show Icon: true");
            showIconNotifier.value = true;
          } else {
            debugPrint("Show Icon: false");
            showIconNotifier.value = false;
          }

          /// 1. if user is 1600 pixel is up from bottom
          /// 2. if it's not already loading
          /// 3. if record is not ended yet
          /// 4. then auto call api
          if (notification is ScrollEndNotification &&
              notification.metrics.extentAfter <= 1600 &&
              widget.isLoadingMore == false &&
              widget.noMoreRecord == false) {
            if (widget.onScrollEndReached != null) {
              widget.onScrollEndReached!();
            }
          }
          return false;
        },
        child: ValueListenableBuilder<ScrollDirection?>(
            valueListenable: scrollDirectionNotifier,
            builder: (context, scrollDirection, child) {
              return Stack(
                children: [
                  CustomScrollView(
                    controller: _scrollController,
                    slivers: [
                      SliverToBoxAdapter(
                        child: widget.child,
                      ),
                      if (widget.isEmpty == false)
                        SliverToBoxAdapter(
                          child: widget.noMoreRecord
                              ? Center(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 15.h),
                                    child: Text(
                                      "No more records",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.w700,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      ),
                                    ),
                                  ),
                                )
                              : widget.isLoadingMore
                                  ? CustomLoader()
                                  : LoadMoreButton(
                                      onLoadMore: widget.onLoadMore,
                                      isLoading: widget.isLoadingMore,
                                      isEmpty: widget.isEmpty,
                                    ),
                        ),
                    ],
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: ValueListenableBuilder<bool>(
                        valueListenable: showIconNotifier,
                        builder: (context, showIcon, child) {
                          if (widget.enableScrollUp && showIcon) {
                            return GestureDetector(
                              onTap: () {
                                _scrollController.animateTo(
                                  0,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeIn,
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
                            );
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                    ),
                  ),
                ],
              );
            }),
      ),
      floatingActionButton: widget.filterAction != null
          ? ValueListenableBuilder<ScrollDirection?>(
              valueListenable: scrollDirectionNotifier,
              builder: (context, scrollDirection, child) {
                return scrollDirectionNotifier.value == ScrollDirection.reverse
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomChip(
                            title: "Activities & filters",
                            assetPath: AppAssets.filter,
                            onTap: () {
                              widget.filterAction!();
                            },
                          ),
                        ],
                      )
                    : SizedBox();
              })
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
