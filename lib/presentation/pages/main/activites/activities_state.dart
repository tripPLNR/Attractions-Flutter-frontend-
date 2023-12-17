import 'package:triplaner/domain/entities/site.dart';

import 'activities_initial_params.dart';

class ActivitiesState {
  final bool loading;
  final List<Site> sites;
  final List<Site> wishListSites;
  final bool loadingMore;
  final bool noMoreSites;
  final bool showFilterButton;
  final bool calendarFilterMode;

  final String endpointUrl;
  final String title;

  const ActivitiesState(
      {required this.loading,
      required this.sites,
      required this.loadingMore,
      required this.noMoreSites,
      required this.showFilterButton,
      required this.wishListSites,
      required this.endpointUrl,
      required this.calendarFilterMode,
      required this.title});

  factory ActivitiesState.initial(
          {required ActivitiesInitialParams initialParams}) =>
      ActivitiesState(
          loading: false,
          sites: [],
          loadingMore: false,
          noMoreSites: false,
          showFilterButton: true,
          wishListSites: [],
          calendarFilterMode: false,
          endpointUrl: initialParams.endpoint,
          title: initialParams.title);

  ActivitiesState copyWith({
    bool? loading,
    List<Site>? sites,
    List<Site>? wishListSites,
    bool? loadingMore,
    bool? noMoreSites,
    bool? showFilterButton,
    bool? calendarFilterMode,
    String? endpointUrl,
    String? title,
  }) =>
      ActivitiesState(
        loading: loading ?? this.loading,
        sites: sites ?? this.sites,
        wishListSites: wishListSites ?? this.wishListSites,
        loadingMore: loadingMore ?? this.loadingMore,
        noMoreSites: noMoreSites ?? this.noMoreSites,
        endpointUrl: endpointUrl ?? this.endpointUrl,
        showFilterButton: showFilterButton ?? this.showFilterButton,
        title: title ?? this.title,
        calendarFilterMode: calendarFilterMode ?? this.calendarFilterMode,
      );
}
