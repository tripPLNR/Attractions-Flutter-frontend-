import 'dart:math';

import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';
import 'package:triplaner/domain/entities/booking_response.dart';
import 'package:triplaner/domain/entities/site.dart';
import 'package:triplaner/domain/entities/user.dart';
import 'package:triplaner/domain/stores/user_store.dart';
import 'package:triplaner/domain/stores/wishlist/wishlist_store.dart';
import 'package:triplaner/presentation/base_cubit/base_cubit.dart';
import 'package:triplaner/presentation/pages/main/activites/calendar/calendar_initial_params.dart';
import 'package:triplaner/presentation/pages/main/site_detail/check_availability/check_availability_initial_params.dart';
import 'package:triplaner/presentation/pages/main/site_detail/redirect_popup/redirect_popup_initial_params.dart';
import 'package:triplaner/presentation/pages/main/site_detail/reviews/reviews_initial_params.dart';
import 'package:triplaner/util/alert/app_snackbar.dart';
import 'package:triplaner/util/app_extentions.dart';
import 'package:triplaner/util/app_funtions.dart';

import '../../../../domain/entities/product_review.dart';
import '../../../../domain/repositories/database_repository.dart';
import '../../authentication/login/login_initial_params.dart';
import '../../confirmation/confirmation_initial_params.dart';
import 'site_detail_initial_params.dart';
import 'site_detail_state.dart';
import 'site_detail_navigator.dart';

class SiteDetailCubit extends BaseCubit<SiteDetailState> {
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

  final ScrollController scrollController = ScrollController();

  /// starting dummy positions for widgets
  double overViewStartingIndex = 0;
  double includesStartingIndex = 590;
  double excludesStartingIndex = 870;
  double locationStartingIndex = 0;
  double ratingStartingIndex = 1080;
  double cancellationPolicyStartingIndex = 0;

  /// widgets keys for scrolling to desired position
  final GlobalKey overViewWidgetKey = GlobalKey();
  final GlobalKey includesWidgetKey = GlobalKey();
  final GlobalKey excludesWidgetKey = GlobalKey();
  final GlobalKey locationWidgetKey = GlobalKey();
  final GlobalKey reviewWidgetKey = GlobalKey();
  final GlobalKey cancellationPolicyWidgetKey = GlobalKey();

  onInit() {
    _getSiteDetails();
    _listenToWishList();
    _addScrollListener();
  }

  _getSiteDetails({String? siteId}) async {
    try {
      emit(state.copyWith(loading: true,showAppbar: false));
      Site site = await databaseRepository.getSiteById(id: siteId ?? initialParams.site.id!);
      emit(state.copyWith(site: site, reviewsRatings: site.productReviews,similarExperiences: []));
      _updateMenuLength();
      getAndSetOffsets();
      checkAvailabilityForDate(DateTime.now());
    } catch (e) {
      handleException(e.toString(), context);
    } finally {
      emit(state.copyWith(loading: false));
    }
  }

  /// get scroll positions of widgets for scrolling to exact points on menu tap
  getAndSetOffsets() async {
    await Future.delayed(const Duration(milliseconds: 500));
    overViewStartingIndex = _getWidgetPosition(overViewWidgetKey);
    includesStartingIndex = _getWidgetPosition(includesWidgetKey);
    excludesStartingIndex = _getWidgetPosition(excludesWidgetKey);
    locationStartingIndex = _getWidgetPosition(locationWidgetKey);
    ratingStartingIndex = _getWidgetPosition(reviewWidgetKey);
    cancellationPolicyStartingIndex = _getWidgetPosition(cancellationPolicyWidgetKey);
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
      return 0;
    }
  }

  navigateToTabSection(String menu) async {
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
      case 'Location':
        _scrollToPosition(locationStartingIndex);
        break;
      case 'Reviews':
        _scrollToPosition(ratingStartingIndex);
        break;
      case 'Cancellation Policy':
        _scrollToPosition(cancellationPolicyStartingIndex);
        break;
    }
  }

  _scrollToPosition(double offset) {
    scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 500),
      // Adjust the duration as needed.
      curve: Curves.easeIn, // Use a different curve if desired.
    );
  }

  _updateMenuLength() {
    List<String> updatedMenu = List.from(state.menus);
    if (state.site.inclusions!.isEmpty) {
      updatedMenu.remove("Includes");
    }
    if (state.site.exclusions!.isEmpty) {
      updatedMenu.remove("Excludes");
    }
    if (state.site.latitude == null || state.site.latitude == 0) {
      updatedMenu.remove("Location");
    }
    emit(state.copyWith(menus: updatedMenu, selectedMenuIndex: 0));
  }

  updateSelectedMenu(int index) async {
    emit(state.copyWith(selectedMenuIndex: index));
  }

  getSimilarExperiences() async {
    try {
      /// if we already got then no need to call
      if (state.similarExperiences.isNotEmpty || state.loadingSimilarExperiences) return;
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
       sitesStacks.add(state.site);
      _getSiteDetails(siteId: site.id);
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
    if (state.showAppbar == show) return;
    emit(state.copyWith(showAppbar: show));
  }

  shareAction() {
    AppFunctions.shareSite(state.site);
  }

  bookNowAction() {
    navigator.openRedirectPopup(RedirectPopupInitialParams(
      url: state.site.productUrl??"http://www.google.com",
    ));
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

  void _addScrollListener() {
    scrollController.addListener(() {
      double currentScrollPosition = scrollController.position.pixels;
      debugPrint("CURRENT POSITION ==> : $currentScrollPosition");

      /// update appbar code
      updateAppbarView(currentScrollPosition >= 180);

      /// update underline bar below menu
      if (currentScrollPosition >= cancellationPolicyStartingIndex) {
        updateSelectedMenu((state.menus.indexOf('Cancellation Policy')));
      } else if (currentScrollPosition >= ratingStartingIndex &&
          state.menus.contains("Reviews")) {
        updateSelectedMenu((state.menus.indexOf('Reviews')));
        getSimilarExperiences();
      } else if (currentScrollPosition >= locationStartingIndex &&
          state.menus.contains("Location")) {
        getSimilarExperiences();
        updateSelectedMenu((state.menus.indexOf('Location')));
      } else if (currentScrollPosition >= excludesStartingIndex &&
          state.menus.contains("Excludes")) {
        updateSelectedMenu((state.menus.indexOf('Excludes')));
      } else if (currentScrollPosition >= includesStartingIndex &&
          state.menus.contains("Includes")) {
        updateSelectedMenu((state.menus.indexOf('Includes')));
      } else if (currentScrollPosition > overViewStartingIndex &&
          state.menus.contains("Overview")) {
        updateSelectedMenu((state.menus.indexOf('Overview')));
      }
    });
  }

  checkAvailabilityForDate(DateTime dateTime) async {
    try {
      emit(state.copyWith(
          checkAvailabilityDate: dateTime, checkingAvailability: true));
      BookingResponse bookingResponse = await databaseRepository
          .checkAvailability(site: state.site, date: dateTime);
      debugPrint("response : ${bookingResponse.toJson()}");
      emit(state.copyWith(checkingAvailability: false, bookingResponse: bookingResponse));

    } catch (e) {
      snackBar.show(context: context, info: e.toString());
      emit(state.copyWith(checkingAvailability: false));
    }
  }
  final EasyInfiniteDateTimelineController horizontalDateController = EasyInfiniteDateTimelineController();


  selectDate() async {
    navigator.openCalendar(CalendarInitialParams(onSelectDate: (date) {
      checkAvailabilityForDate(date);
      horizontalDateController.animateToDate(date);
    }, onClear: () {
      checkAvailabilityForDate(DateTime.now());
      horizontalDateController.animateToDate(DateTime.now());
    }));
  }

  clearCheckAvailabilityDate() async {
    checkAvailabilityForDate(DateTime.now());
    horizontalDateController.animateToDate(DateTime.now());
  }
}
