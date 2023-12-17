import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:triplaner/domain/entities/review_rating.dart';
import 'package:triplaner/domain/repositories/database_repository.dart';
import 'package:triplaner/util/alert/app_snackbar.dart';
import 'package:triplaner/util/app_extentions.dart';
import 'reviews_initial_params.dart';
import 'reviews_state.dart';
import 'reviews_navigator.dart';

class ReviewsCubit extends Cubit<ReviewsState> {
  ReviewsNavigator navigator;
  ReviewsInitialParams initialParams;
  DatabaseRepository databaseRepository;
  AppSnackBar snackBar;

  ReviewsCubit(
      {required this.navigator,
      required this.initialParams,
      required this.databaseRepository,
      required this.snackBar})
      : super(ReviewsState.initial(initialParams: initialParams));

  BuildContext get context => navigator.context;

  onInit() {
    _getAllReviews();
  }

  _getAllReviews() async {
    try {
      emit(state.copyWith(loading: true));
      List<ReviewRating> reviewsRating =
          await databaseRepository.getReviewsOfSite(site: initialParams.site);
      if (reviewsRating.isEmpty) {
        reviewsRating = _generateRandomReviews(
            (initialParams.site.ratings?.ratings ?? 0)-(reviewsRating.length),
            initialParams.site.ratings?.reviewersCount ?? 0);
      }
      emit(state.copyWith(reviewRating: reviewsRating, loading: false,noMoreRecord:reviewsRating.length<10));
    } catch (e) {
      emit(state.copyWith(loading: false));
      snackBar.show(context: context, info: e.toString());
    }
  }

  getMoreReviews() async {
    try {
      emit(state.copyWith(loadingMore: true));
      List<ReviewRating> moreRatings =
          await databaseRepository.getReviewsOfSite(
        site: initialParams.site,
        take: 10,
        skip: state.reviewRating.length,
      );
      state.reviewRating.addAll(moreRatings);

      emit(state.copyWith(reviewRating: state.reviewRating, loadingMore: false,noMoreRecord:moreRatings.isEmpty));
    } catch (e) {
      emit(state.copyWith(loadingMore: false));
      snackBar.show(context: context, info: e.toString());
    }
  }

  List<ReviewRating> _generateRandomReviews(
      double avgStarRating, int numberOfReviews) {
    if (avgStarRating < 0 || avgStarRating > 5) {
      throw ArgumentError(
          'Invalid average star rating. Must be between 0 and 5.');
    }

    if (numberOfReviews <= 0) {
      throw ArgumentError('Number of reviews must be greater than 0.');
    }

    List<ReviewRating> reviews = [];

    // Generate random ratings
    List<double> randomRatings =
        _generateRandomRatings(avgStarRating, numberOfReviews);

    // Populate ReviewRating objects
    for (int i = 0; i < numberOfReviews; i++) {
      // Generate random date and time within the last 365 days
      DateTime randomDate = DateTime.now().subtract(
        Duration(days: Random().nextInt(365)),
      );
      reviews.add(
        ReviewRating(
          userName: 'Anonymous User',
          review: 'No feedback given',
          rating: double.parse(randomRatings[i].toStringAsFixed(1)),
          date: randomDate.toDayMonthNameAndYear(),
        ),
      );
    }

    return reviews;
  }

  List<double> _generateRandomRatings(
      double avgStarRating, int numberOfReviews) {
    Random random = Random();
    List<double> ratings = [];
    double totalRating = avgStarRating * numberOfReviews;

    for (int i = 0; i < numberOfReviews - 1; i++) {

      double randomRating = (totalRating / (numberOfReviews - i)) +
          (random.nextDouble() - 0.5) * 2;
      ratings.add(randomRating.clamp(0, 5));
      totalRating -= randomRating;
    }

    ratings.add(totalRating.clamp(
        0, 5)); // Ensure the last rating makes up for any rounding errors

    return ratings;
  }
}
