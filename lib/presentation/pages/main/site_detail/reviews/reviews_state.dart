import 'package:triplaner/domain/entities/product_review.dart';

import 'reviews_initial_params.dart';

class ReviewsState {
  final bool loading;
  final bool loadingMore;
  final bool noMoreRecord;


  final List<ProductReview> reviewRating;

  const ReviewsState(
      {required this.loading,
      required this.reviewRating,
      required this.loadingMore,
      required this.noMoreRecord,

      });

  factory ReviewsState.initial({required ReviewsInitialParams initialParams}) =>
       ReviewsState(loading: false, reviewRating: initialParams.site.productReviews??[], loadingMore: false,noMoreRecord:false);

  ReviewsState copyWith(
          {bool? loading,
           bool? noMoreRecord,

          List<ProductReview>? reviewRating,
          bool? loadingMore}) =>
      ReviewsState(
        loading: loading ?? this.loading,
        noMoreRecord:noMoreRecord??this.noMoreRecord,
        reviewRating: reviewRating ?? this.reviewRating,
        loadingMore: loadingMore ?? this.loadingMore,
      );
}
