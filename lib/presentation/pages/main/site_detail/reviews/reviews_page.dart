import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:triplaner/domain/entities/review_rating.dart';
import 'package:triplaner/presentation/widgets/custom_appbar.dart';
import 'package:triplaner/presentation/widgets/custom_single_child_scroll_view.dart';
import 'package:triplaner/util/app_constant.dart';
import '../../../../widgets/review_widget.dart';
import 'reviews_cubit.dart';
import 'reviews_initial_params.dart';
import 'reviews_state.dart';

class ReviewsPage extends StatefulWidget {
  final ReviewsCubit cubit;

  const ReviewsPage({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<ReviewsPage> createState() => _ReviewsState();
}

class _ReviewsState extends State<ReviewsPage> {
  ReviewsCubit get cubit => widget.cubit;

  @override
  void initState() {
    super.initState();
    cubit.navigator.context = context;
    cubit.onInit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Reviews',
        centerTitle: true,
      ),
      body: BlocBuilder<ReviewsCubit, ReviewsState>(
          bloc: cubit,
          builder: (context, state) {
        return CustomSingleChildScrollViewWithLoadMore(
          isLoadingMore: state.loadingMore,
          noMoreText: "No more reviews",
          noMoreRecord: state.noMoreRecord,
          onScrollEndReached: () {
           cubit.getMoreReviews();
          },
          enableScrollUp: true,
          onLoadMore: () {
            cubit.getMoreReviews();
          },
          child: Padding(
            padding: AppConstant.screenPadding.copyWith(top: 20.h),
            child: Skeletonizer(
              enabled: state.loading,
              child: ListView.builder(
                itemCount: state.loading ? 10 : state.reviewRating.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  ReviewRating reviewRating = state.loading
                      ? ReviewRating.empty()
                      : state.reviewRating[index];
                  return ReviewWidget(
                    reviewRating: reviewRating,
                  );
                },
              ),
            ),
          ),
        );
      }),
    );
  }
}
