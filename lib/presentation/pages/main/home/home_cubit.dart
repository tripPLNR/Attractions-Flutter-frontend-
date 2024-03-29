import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:triplaner/domain/entities/city.dart';
import 'package:triplaner/domain/entities/location_info.dart';
import 'package:triplaner/domain/entities/site.dart';
import 'package:triplaner/domain/entities/top_activity.dart';
import 'package:triplaner/domain/entities/user.dart';
import 'package:triplaner/domain/repositories/database_repository.dart';
import 'package:triplaner/domain/stores/bottom_nav_store.dart';
import 'package:triplaner/domain/stores/currency_store.dart';
import 'package:triplaner/domain/stores/user_store.dart';
import 'package:triplaner/domain/stores/wishlist/wishlist_store.dart';
import 'package:triplaner/network/api_endpoint.dart';
import 'package:triplaner/presentation/base_cubit/base_cubit.dart';
import 'package:triplaner/presentation/base_cubit/internet_connectivity_cubit.dart';
import 'package:triplaner/presentation/pages/authentication/login/login_initial_params.dart';
import 'package:triplaner/presentation/pages/confirmation/confirmation_initial_params.dart';
import 'package:triplaner/presentation/pages/main/activites/activities_initial_params.dart';
import 'package:triplaner/presentation/pages/main/bottom_navigation/bottom_navigation_cubit.dart';
import 'package:triplaner/presentation/pages/main/bottom_navigation/bottom_navigation_initial_params.dart';
import 'package:triplaner/presentation/pages/main/destination_detail/destination_detail_initial_params.dart';
import 'package:triplaner/presentation/pages/main/site_detail/site_detail_initial_params.dart';
import 'package:triplaner/presentation/pages/no_internet/no_internet_initial_params.dart';
import 'package:triplaner/util/alert/app_snackbar.dart';
import 'package:triplaner/util/dependency/app_dependency.dart';
import 'package:triplaner/util/services/location/location_service.dart';
import 'home_initial_params.dart';
import 'home_state.dart';
import 'home_navigator.dart';

class HomeCubit extends BaseCubit<HomeState> with ConnectivityMixin<HomeState> {
  HomeNavigator navigator;
  HomeInitialParams initialParams;
  AppSnackBar snackBar;
  DatabaseRepository databaseRepository;
  LocationService locationService;
  WishListStore wishListStore;
  UserStore userStore;
  CurrencyStore currencyStore;
  BottomNavStore bottomNavStore;

  HomeCubit({
    required this.navigator,
    required this.initialParams,
    required this.snackBar,
    required this.databaseRepository,
    required this.locationService,
    required this.wishListStore,
    required this.bottomNavStore,
    required this.userStore,
    required this.currencyStore,
  }) : super(HomeState.initial(initialParams: initialParams));

  @override
  void onConnectivityChanged(bool isConnected) {
    if (isConnected) {
      debugPrint("INTERNET CONNECTED...HOME");
    }
  }

  BuildContext get context => navigator.context;

  onInit() {
    _listenToWishList();
    _getAll();
    _getWishList();
    _listenToCurrencyChange();
    emit(state.copyWith(showAppBar: false));
  }

  _getAll() {
    _getPopularGateways();
    _getSighSeeingTours();
    _getTopActivities();
    _getAttractionWorldWide();
    _getWaterAdventures();
    _getMoreToExplore();
  }

  refreshAction() {
    _getPopularGateways(isRefresh: true);
    _getSighSeeingTours(isRefresh: true);
    _getTopActivities(isRefresh: true);
    _getAttractionWorldWide(isRefresh: true);
    _getWaterAdventures(isRefresh: true);
    _getMoreToExplore(isRefresh: true);
  }

  _getWishList() {
    if (state.wishListSites.isEmpty && userStore.state != User.empty()) {
      databaseRepository.getMyWishListSites().then((value) {
        wishListStore.setWishList(value);
      }).onError((error, stackTrace) {
        handleException(error.toString(), context);
      });
    }
  }

  _getPopularGateways({bool isRefresh = false}) async {
    try {
      if (state.cities.isNotEmpty && !isRefresh) return;
      emit(state.copyWith(loadingPopularGateways: true));
      List<City> cities = await databaseRepository.getPopularDestinations();
      emit(state.copyWith(loadingPopularGateways: false, cities: cities));
    } catch (e) {
      emit(state.copyWith(loadingPopularGateways: false));
      snackBar.show(context: context, info: e.toString());
      debugPrint(e.toString());
    }
  }

  _getTopActivities({bool isRefresh = false}) async {
    try {
      if (state.topActivities.isNotEmpty && !isRefresh) return;
      emit(state.copyWith(loadingTopActivities: true));
      List<TopActivity> topActivities =
          await databaseRepository.getTopActivities();
      emit(state.copyWith(
          loadingTopActivities: false, topActivities: topActivities));
    } catch (e) {
      emit(state.copyWith(loadingTopActivities: false));
      snackBar.show(context: context, info: e.toString());
      debugPrint(e.toString());
    }
  }

  _getSighSeeingTours({bool isRefresh = false}) async {
    try {
      if (state.siteSeeingTours.isNotEmpty && !isRefresh) return;
      emit(state.copyWith(loadingSiteSeeingTours: true));
      List<Site> sites = await databaseRepository.getSiteSeeingTours();
      emit(state.copyWith(
          loadingSiteSeeingTours: false, siteSeeingTours: sites));
    } catch (e) {
      emit(state.copyWith(loadingSiteSeeingTours: false));
      snackBar.show(context: context, info: e.toString());
    }
  }

  _getAttractionWorldWide({bool isRefresh = false}) async {
    try {
      if (state.attractionsWorldWide.isNotEmpty && !isRefresh) return;
      emit(state.copyWith(loadingAttractionWorldWide: true));
      List<Site> sites = await databaseRepository.getAttractionsWorldWide();
      emit(state.copyWith(
          loadingAttractionWorldWide: false, attractionsWorldWide: sites));
    } catch (e) {
      emit(state.copyWith(loadingAttractionWorldWide: false));
      snackBar.show(context: context, info: e.toString());
    }
  }

  _getWaterAdventures({bool isRefresh = false}) async {
    try {
      if (state.waterAdventures.isNotEmpty && !isRefresh) return;
      emit(state.copyWith(loadingWaterAdventures: true));
      List<Site> sites = await databaseRepository.getWaterAdventures();
      emit(state.copyWith(
          loadingWaterAdventures: false, waterAdventures: sites));
    } catch (e) {
      emit(state.copyWith(loadingWaterAdventures: false));
      snackBar.show(context: context, info: e.toString());
    }
  }

  _getMoreToExplore({bool isRefresh = false}) async {
    try {
      if (state.moreToExplore.isNotEmpty && !isRefresh) return;
      emit(state.copyWith(loadingMoreToExplore: true));
      List<Site> sites = await databaseRepository.getMoreToExplore();
      emit(state.copyWith(loadingMoreToExplore: false, moreToExplore: sites));
    } catch (e) {
      emit(state.copyWith(loadingMoreToExplore: false));
      snackBar.show(context: context, info: e.toString());
    }
  }

  destinationTapAction(City city) {
    navigator.openDestinationDetail(DestinationDetailInitialParams(city: city));
  }

  activityAction(TopActivity activity) {
    navigator.openActivities(ActivitiesInitialParams(
      endpoint: "${APIEndpoint.getTopActivityDetail}/${activity.name}",
      title: activity.name ?? "N/A",
    ));
  }

  onNearbyAttraction() async {
    try {
      emit(state.copyWith(stackLoading: true));
      LocationInfo locationInfo = await locationService.getCityName();
      emit(state.copyWith(stackLoading: false));
      navigator.openActivities(ActivitiesInitialParams(
          endpoint: APIEndpoint.getNearbyAttractions,
          title: locationInfo.city ?? locationInfo.country ?? "N/A",
          latitude: locationInfo.latitude,
          longitude: locationInfo.longitude,
          parameters: {
            "lat": locationInfo.latitude.toString(),
            "lng": locationInfo.longitude.toString()
          }));
    } catch (e) {
      emit(state.copyWith(stackLoading: false));
      snackBar.show(context: context, info: e.toString());
    }
  }

  onGuidedTour() {
    navigator.openActivities(ActivitiesInitialParams(
        endpoint: APIEndpoint.getGuidedTours, title: "Guided & Private tours",showNearbyButton: true));
  }

  seeMoreAction() {
    navigator.openActivities(ActivitiesInitialParams(
        endpoint: APIEndpoint.getExploreMore, title: "More to explore"));
  }

  onSiteTap(Site site) {
    navigator.openSiteDetail(SiteDetailInitialParams(site: site));
  }

  updateAppbarStatus(bool show) {
    emit(state.copyWith(showAppBar: show));
  }

  _listenToWishList() {
    emit(state.copyWith(wishListSites: wishListStore.state.sites));
    wishListStore.stream.listen((event) {
      emit(state.copyWith(wishListSites: event.sites));
    });
  }

  _listenToCurrencyChange() {
    currencyStore.stream.listen((event) {
      refreshAction();
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

  openSearchScreen() {
    debugPrint("tapped");
    bottomNavStore.changeScreen(1);
  }
}
