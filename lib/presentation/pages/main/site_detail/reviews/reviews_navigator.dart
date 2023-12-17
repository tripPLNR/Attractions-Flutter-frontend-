import 'package:flutter/material.dart';
import '../../../../../navigation/app_navigator.dart';
import '../../../../../util/dependency/app_dependency.dart';
import 'reviews_page.dart';
import 'reviews_cubit.dart';
import 'reviews_initial_params.dart';



class ReviewsNavigator {
ReviewsNavigator(this.navigator);

@override
late BuildContext context;

@override
late AppNavigator navigator;

}

mixin ReviewsRoute {
openReviews(ReviewsInitialParams initialParams) {
navigator.push(
context,
ReviewsPage(cubit: getIt(param1:initialParams),));
}

AppNavigator get navigator;

BuildContext get context;
}
