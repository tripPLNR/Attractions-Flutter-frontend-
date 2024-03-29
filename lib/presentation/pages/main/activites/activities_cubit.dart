import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:triplaner/domain/entities/activity_result.dart';
import 'package:triplaner/domain/entities/location_info.dart';
import 'package:triplaner/domain/entities/site.dart';
import 'package:triplaner/domain/stores/filter/filter_store_store.dart';
import 'package:triplaner/domain/stores/user_store.dart';
import 'package:triplaner/domain/stores/wishlist/wishlist_store.dart';
import 'package:triplaner/network/api_endpoint.dart';
import 'package:triplaner/presentation/pages/main/activites/calendar/calendar_initial_params.dart';
import 'package:triplaner/presentation/pages/main/activites/filter/filter_initial_params.dart';
import 'package:triplaner/presentation/pages/main/site_detail/site_detail_initial_params.dart';
import 'package:triplaner/util/app_assets.dart';
import 'package:triplaner/util/services/location/location_service.dart';
import '../../../../domain/entities/user.dart';
import '../../../../domain/repositories/database_repository.dart';
import '../../../../util/alert/app_snackbar.dart';
import '../../authentication/login/login_initial_params.dart';
import '../../confirmation/confirmation_initial_params.dart';
import 'activities_initial_params.dart';
import 'activities_state.dart';
import 'activities_navigator.dart';

class ActivitiesCubit extends Cubit<ActivitiesState> {
  ActivitiesNavigator navigator;
  ActivitiesInitialParams initialParams;
  AppSnackBar snackBar;
  DatabaseRepository databaseRepository;
  UserStore userStore;
  FilterStore filterStore;
  LocationService locationService;
  WishListStore wishListStore;

  ActivitiesCubit({
    required this.navigator,
    required this.initialParams,
    required this.snackBar,
    required this.databaseRepository,
    required this.wishListStore,
    required this.userStore,
    required this.filterStore,
    required this.locationService,
  }) : super(ActivitiesState.initial(initialParams: initialParams));

  BuildContext get context => navigator.context;

  List<Map<String, dynamic>> menu = [
    {
      "title": "Filter",
      "iconPath": AppAssets.filter,
    },
    {
      "title": "Date",
      "iconPath": AppAssets.date,
    },
    {
      "title": "Duration",
      "iconPath": AppAssets.duration,
    },
    {
      "title": "Price",
      "iconPath": AppAssets.price,
    },
  ];

  onInit() {
    _getSitesFromEndpoint();
    _listenToWishList();
    _listenToFilter();
  }

  _listenToFilter() {
    filterStore.stream.listen((event) {
      emit(state.copyWith(
          loading: event.loading,
          sites: event.filteredSites,
          noMoreSites: event.noMoreRecord,
          title: event.selectedActivity.isEmpty
              ? initialParams.title
              : event.selectedActivity));
    });
  }

  _getSitesFromEndpoint() async {
    try {
      emit(state.copyWith(loading: true));
      ActivityResult activityResult =
          await databaseRepository.getSitesFromEndpoint(
        endpoint: state.endpointUrl,
        params: state.parameters,
      );
      emit(state.copyWith(
        loading: false,
        sites: activityResult.sites,
        noMoreSites: activityResult.sites?.isEmpty,
        totalActivities: activityResult.count,
      ));
    } catch (e) {
      emit(state.copyWith(loading: false));
      snackBar.show(context: context, info: e.toString());
    }
  }

  getMoreSitesFromEndpoint() async {
    try {
      emit(state.copyWith(loadingMore: true));
      ActivityResult activityResult =
          await databaseRepository.getSitesFromEndpoint(
        endpoint: state.endpointUrl,
        skip: state.sites.length,
        take: 10,
        params: state.parameters,
      );
      state.sites.addAll(activityResult.sites ?? []);
      emit(state.copyWith(
        loadingMore: false,
        sites: state.sites,
        noMoreSites: activityResult.sites?.isEmpty,
        totalActivities: activityResult.count,
      ));
    } catch (e) {
      emit(state.copyWith(loadingMore: false));
      snackBar.show(context: context, info: e.toString());
    }
  }

  onTapAction(Site site) {
    navigator.openSiteDetail(SiteDetailInitialParams(site: site));
  }

  openFilterPage() {
    navigator.openFilter(FilterInitialParams(
        clearFilter: () {
          _getSitesFromEndpoint();
        },
        searchLocation: initialParams.searchLocation,
        longitude: initialParams.longitude,
        latitude: initialParams.latitude));
  }

  onScrollReachesEndGetRecord() {
    getNextRecordAccordingToFilter();
  }

  getNextRecordAccordingToFilter() {
    if (filterStore.state.isFilterApplied) {
      _getMoreFilterSites();
    } else if (state.calendarFilterMode) {
      _getMoreSitesAccordingToDate();
    } else {
      getMoreSitesFromEndpoint();
    }
  }

  _getMoreFilterSites() async {
    try {
      emit(state.copyWith(loadingMore: true));
      await filterStore.getMoreFilterSites(
          skip: state.sites.length,
          take: 10,
          searchLocation: initialParams.searchLocation,
          latitude: initialParams.latitude,
          longitude: initialParams.longitude);
      emit(state.copyWith(loadingMore: false));
    } catch (e) {
      emit(state.copyWith(loadingMore: false));
      snackBar.show(context: context, info: e.toString());
    }
  }

  getNearbyAttraction() async {
    try {
      emit(state.copyWith(loading: true));
      LocationInfo locationInfo = await locationService.getCityName();
      Map<String, dynamic>? previousParam = initialParams.parameters;
      Map<String, dynamic>? newParams = {
        "lat": locationInfo.latitude.toString(),
        "lng": locationInfo.longitude.toString()
      };
      if (previousParam == null) {
        debugPrint("previosu params are ${null}");
        emit(state.copyWith(parameters: newParams));
      } else {
        previousParam.addAll(newParams);
        emit(state.copyWith(parameters: previousParam));
      }

      _getSitesFromEndpoint();
    } catch (e) {
      emit(state.copyWith(loading: false));
      snackBar.show(context: context, info: e.toString());
    }
  }

  //
  // updateFilterButtonVisibility(bool show) {
  //   if(state.showFilterButton==show)return;
  //   //emit(state.copyWith(showFilterButton: show));
  // }

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

  disposeAll() {
    filterStore.resetFilter();
  }

  openCalendarAction() {
    navigator.openCalendar(CalendarInitialParams(
        dateTime: dateTime,
        onSelectDate: (date) {
          _getSitesAccordingToDate(date);
        },
        onClear: () {
          dateTime = null;
          emit(state.copyWith(calendarFilterMode: false));
          _getSitesFromEndpoint();
        }));
  }

  DateTime? dateTime;

  _getSitesAccordingToDate(DateTime dateTime) async {
    try {
      this.dateTime = dateTime;
      emit(state.copyWith(loading: true));
      List<Site> sites =
          await databaseRepository.filterByDate(dateTime: dateTime);
      emit(state.copyWith(
        loading: false,
        sites: sites,
        calendarFilterMode: true,
      ));
    } catch (e) {
      emit(state.copyWith(loading: false));
      snackBar.show(context: context, info: e.toString());
    }
  }

  _getMoreSitesAccordingToDate() async {
    try {
      emit(state.copyWith(loadingMore: true));
      List<Site> sites = await databaseRepository.filterByDate(
          dateTime: dateTime!, take: 10, skip: state.sites.length);
      state.sites.addAll(sites);
      emit(state.copyWith(
          loadingMore: false, sites: state.sites, noMoreSites: sites.isEmpty));
    } catch (e) {
      emit(state.copyWith(loadingMore: false));
      snackBar.show(context: context, info: e.toString());
    }
  }
}
