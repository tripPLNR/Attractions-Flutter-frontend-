import '../../../../../domain/entities/review_rating.dart';
import 'reviews_initial_params.dart';

class ReviewsState {
  final bool loading;
  final bool loadingMore;
  final bool noMoreRecord;


  final List<ReviewRating> reviewRating;

  const ReviewsState(
      {required this.loading,
      required this.reviewRating,
      required this.loadingMore,
      required this.noMoreRecord,

      });

  factory ReviewsState.initial({required ReviewsInitialParams initialParams}) =>
      const ReviewsState(loading: false, reviewRating: [], loadingMore: false,noMoreRecord:false);

  ReviewsState copyWith(
          {bool? loading,
           bool? noMoreRecord,

          List<ReviewRating>? reviewRating,
          bool? loadingMore}) =>
      ReviewsState(
        loading: loading ?? this.loading,
        noMoreRecord:noMoreRecord??this.noMoreRecord,
        reviewRating: reviewRating ?? this.reviewRating,
        loadingMore: loadingMore ?? this.loadingMore,
      );
}
