import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:triplaner/domain/entities/product_review.dart';
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

  }

  // _getAllReviews() async {
  //   try {
  //     emit(state.copyWith(loading: true));
  //     List<ProductReview> reviewsRating = await databaseRepository.getReviewsOfSite(site: initialParams.site);
  //     emit(state.copyWith(reviewRating: reviewsRating, loading: false,));
  //   } catch (e) {
  //     emit(state.copyWith(loading: false));
  //     snackBar.show(context: context, info: e.toString());
  //   }
  // }
  //
  // getMoreReviews() async {
  //   try {
  //     emit(state.copyWith(loadingMore: true));
  //     List<ProductReview> moreRatings =
  //         await databaseRepository.getReviewsOfSite(
  //       site: initialParams.site,
  //       take: 10,
  //       skip: state.reviewRating.length,
  //     );
  //     state.reviewRating.addAll(moreRatings);
  //
  //     emit(state.copyWith(reviewRating: state.reviewRating, loadingMore: false,noMoreRecord:moreRatings.isEmpty));
  //   } catch (e) {
  //     emit(state.copyWith(loadingMore: false));
  //     snackBar.show(context: context, info: e.toString());
  //   }
  // }



}
