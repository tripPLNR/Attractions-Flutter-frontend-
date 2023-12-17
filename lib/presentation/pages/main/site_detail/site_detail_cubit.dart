import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';
import 'package:triplaner/data/models/review_rating_json.dart';
import 'package:triplaner/domain/entities/site.dart';
import 'package:triplaner/domain/entities/user.dart';
import 'package:triplaner/domain/stores/user_store.dart';
import 'package:triplaner/domain/stores/wishlist/wishlist_store.dart';
import 'package:triplaner/presentation/pages/main/activites/calendar/calendar_initial_params.dart';
import 'package:triplaner/presentation/pages/main/site_detail/check_availability/check_availability_initial_params.dart';
import 'package:triplaner/presentation/pages/main/site_detail/reviews/reviews_initial_params.dart';
import 'package:triplaner/util/alert/app_snackbar.dart';
import 'package:triplaner/util/app_extentions.dart';
import '../../../../domain/entities/review_rating.dart';
import '../../../../domain/repositories/database_repository.dart';
import '../../authentication/login/login_initial_params.dart';
import '../../confirmation/confirmation_initial_params.dart';
import 'site_detail_initial_params.dart';
import 'site_detail_state.dart';
import 'site_detail_navigator.dart';

class SiteDetailCubit extends Cubit<SiteDetailState> {
  SiteDetailNavigator navigator;
  SiteDetailInitialParams initialParams;
  AppSnackBar snackBar;
  DatabaseRepository databaseRepository;
  UserStore userStore;
  WishListStore wishListStore;

  SiteDetailCubit(
      {required this.navigator,
      required this.initialParams,
      required this.databaseRepository,
      required this.snackBar,
      required this.wishListStore,
      required this.userStore})
      : super(SiteDetailState.initial(initialParams: initialParams));

  BuildContext get context => navigator.context;

  /// TODO: MOVE THIS TO CUBIT AND REFACTOR CODE
  final ScrollController scrollController = ScrollController();

  /// starting dummy positions for widgets
  double overViewStartingIndex = 0;
  double includesStartingIndex = 590;
  double excludesStartingIndex = 870;
  double ratingStartingIndex = 1080;

  /// widgets keys for scrolling to desired position
  final GlobalKey overViewWidgetKey = GlobalKey();
  final GlobalKey includesWidgetKey = GlobalKey();
  final GlobalKey excludesWidgetKey = GlobalKey();
  final GlobalKey reviewWidgetKey = GlobalKey();

  onInit() {
    _listenToWishList();
    _getReviewsOfSite();
    _updateMenuLength();
    _addScrollListener();
  }

  /// get scroll positions of widgets for scrolling to exact points on menu tap
  getAndSetOffsets() async {
    await Future.delayed(const Duration(milliseconds: 500));
    overViewStartingIndex = _getWidgetPosition(overViewWidgetKey);
    includesStartingIndex = _getWidgetPosition(includesWidgetKey);
    excludesStartingIndex = _getWidgetPosition(excludesWidgetKey);
    ratingStartingIndex = _getWidgetPosition(reviewWidgetKey);
    debugPrint("OVERVIEW : $overViewStartingIndex");
    debugPrint("INCLUDES : $includesStartingIndex");
    debugPrint("EXCLUDES : $excludesStartingIndex");
    debugPrint("RATINGS : $ratingStartingIndex");
  }

  double _getWidgetPosition(GlobalKey widgetKey) {
    try {
      RenderBox renderBox =
          widgetKey.currentContext!.findRenderObject() as RenderBox;
      Offset widgetOffset = renderBox.localToGlobal(Offset.zero);
      double currentOffset = scrollController.position.pixels;
      debugPrint("Widget offset value is : $widgetOffset");
      debugPrint("ScrollController value is : $currentOffset");
      return widgetOffset.dy - 140.h;
    } catch (e) {
      debugPrint(e.toString());
      return 100000;
    }
  }

  navigateToTabSection(String menu) {
    switch (menu) {
      case 'Overview':
        _scrollToPosition(overViewStartingIndex);
        break;
      case 'Includes':
        _scrollToPosition(includesStartingIndex);
        break;
      case 'Excludes':
        _scrollToPosition(excludesStartingIndex);
        break;
      case 'Review':
        _scrollToPosition(ratingStartingIndex);
        break;
    }
  }

  _scrollToPosition(double offset) {
    debugPrint("Scroll offer ${offset}");
    scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 500),
      // Adjust the duration as needed.
      curve: Curves.easeIn, // Use a different curve if desired.
    );
  }

  _updateMenuLength() {
    if (state.site.inclusions!.isEmpty) {
      state.menus.remove("Includes");
    } else if (state.site.exclusions!.isEmpty) {
      state.menus.remove("Excludes");
    }
    emit(state.copyWith(menus: state.menus, selectedMenuIndex: 0));
  }

  updateSelectedMenu(int index) {
    emit(state.copyWith(selectedMenuIndex: index));
  }

  getSimilarExperiences() async {
    try {
      /// if we already got then no need to call
      if (state.similarExperiences.isNotEmpty ||
          state.loadingSimilarExperiences) return;
      emit(state.copyWith(loadingSimilarExperiences: true));
      List<Site> sites = await databaseRepository.getSimilarExperiences(
          siteId: state.site.id!, take: 5);
      emit(state.copyWith(
          loadingSimilarExperiences: false,
          similarExperiences: sites.take(5).toList()));
    } catch (e) {
      emit(state.copyWith(loadingSimilarExperiences: false));
      snackBar.show(context: context, info: e.toString());
    }
  }

  List<Site> sitesStacks = [];

  similarExperienceTap(Site site) {
    try {
      _scrollToPosition(0);
      sitesStacks.add(state.site);
      emit(state.copyWith(
          site: site,
          similarExperiences: [],
          reviewsRatings: [],
          menus: ["Overview", "Includes", "Excludes", "Review"]));
      _getReviewsOfSite();
      _updateMenuLength();
    } catch (e) {
      debugPrint("GOT ERROR : ${e.toString()}");
    }
  }

  popSite() {
    if (sitesStacks.isNotEmpty) {
      /// this will move to top and listener calculate menu positions for scroll
      _scrollToPosition(0);
      emit(state.copyWith(site: sitesStacks.last, similarExperiences: []));
      sitesStacks.removeLast();
      _updateMenuLength();
    } else {
      Navigator.pop(context);
    }
  }

  updateAppbarView(bool show) {
    emit(state.copyWith(showAppbar: show));
  }

  shareAction() {
    Share.share('check out my website https://google.com');
  }

  checkAvailabilityAction() {
    navigator.openCheckAvailability(const CheckAvailabilityInitialParams());
  }

  openReviewsPage() {
    navigator.openReviews(ReviewsInitialParams(site: state.site));
  }

  _listenToWishList() {
    emit(state.copyWith(wishListSites: wishListStore.state.sites));
    wishListStore.stream.listen((event) {
      emit(state.copyWith(wishListSites: event.sites));
    });
  }

  bool isBookMarked(Site site) {
    return state.wishListSites.contains(site);
  }

  void onBookMarkTap(Site site) {
    if (userStore.state == User.empty()) {
      navigator.openConfirmation(ConfirmationInitialParams(
          title: "",
          subtitle: "Login or Create free account to add to the Wishlist.",
          btnText: "Login",
          btnAction: () {
            navigator.openLogin(const LoginInitialParams());
          }));
      return;
    }
    if (isBookMarked(site)) {
      wishListStore.removeFromWishList(site, context);
      databaseRepository.addOrRemoveFromWishList(siteId: site.id!);
    } else {
      wishListStore.addIntoWishList(site, context);
      databaseRepository.addOrRemoveFromWishList(siteId: site.id!);
    }
  }

  _getReviewsOfSite() async {
    try {
      emit(state.copyWith(loadingReviews: true));
      List<ReviewRating> reviewRating =
          await databaseRepository.getReviewsOfSite(site: initialParams.site);
      if (reviewRating.isEmpty) {
        reviewRating = _generateRandomReviews(
            (initialParams.site.ratings?.ratings ?? 0)-reviewRating.length,
            initialParams.site.ratings?.reviewersCount ?? 0);
      }
      emit(state.copyWith(
          reviewsRatings: reviewRating.take(2).toList(),
          loadingReviews: false));
    } catch (e) {
      emit(state.copyWith(loadingReviews: false));
      debugPrint("Got error while getting reviews${e.toString()}");
    }
  }

  updateTextShowMore(bool isTextCollapsed) {
    emit(state.copyWith(isTextCollapsed: isTextCollapsed));
    debugPrint("is text colapsed : ${state.isTextCollapsed}");
  }

  void _addScrollListener() {
    scrollController.addListener(() {
      double currentScrollPosition = scrollController.position.pixels;
      debugPrint("CURRENT POSITION ==> : $currentScrollPosition");

      /// update appbar code
      updateAppbarView(currentScrollPosition >= 180);

      /// update underline bar below menu
      if (currentScrollPosition >= ratingStartingIndex &&
          state.menus.contains("Review")) {
        updateSelectedMenu(state.menus.length - 1);
        getSimilarExperiences();
      } else if (currentScrollPosition >= excludesStartingIndex &&
          state.menus.contains("Excludes")) {
        updateSelectedMenu(2);
        getSimilarExperiences();
      } else if (currentScrollPosition >= includesStartingIndex &&
          state.menus.contains("Includes")) {
        updateSelectedMenu(1);
      } else if (currentScrollPosition > overViewStartingIndex &&
          state.menus.contains("Overview")) {
        updateSelectedMenu(0);
      }

      /// get indexes of menus
      if (currentScrollPosition == 0.0) {
        getAndSetOffsets();
      }
    });
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
          date: randomDate.toDayMonthNameAndYear()
        ),
      );
    }

    return reviews;
  }

  checkAvailabilityForDate(DateTime dateTime) {
    emit(state.copyWith(checkAvailabilityDate: dateTime));

    /// TODO: CALL API TO CHECK AVAILABILITY
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

  selectDate() async {
    navigator.openCalendar(CalendarInitialParams(
        onSelectDate: (date) {
          checkAvailabilityForDate(date);
        },
        onClear: () {
          checkAvailabilityForDate(DateTime.now());
        }));
  }

  clearCheckAvailabilityDate() async {
    checkAvailabilityForDate(DateTime.now());
  }
}
