import 'package:equatable/equatable.dart';
import 'package:triplaner/domain/entities/site.dart';

import 'activities_initial_params.dart';

class ActivitiesState extends Equatable {
  final bool loading;
  final bool stackLoading;

  final Map<String, dynamic>? parameters;
  final List<Site> sites;
  final int totalActivities;
  final List<Site> wishListSites;
  final bool loadingMore;
  final bool noMoreSites;
  final bool calendarFilterMode;
  final String endpointUrl;
  final String title;

  const ActivitiesState({
    required this.loading,
    required this.stackLoading,
    required this.parameters,
    required this.sites,
    required this.totalActivities,
    required this.loadingMore,
    required this.noMoreSites,
    required this.wishListSites,
    required this.endpointUrl,
    required this.calendarFilterMode,
    required this.title,
  });

  factory ActivitiesState.initial(
          {required ActivitiesInitialParams initialParams}) =>
      ActivitiesState(
        loading: false,
        stackLoading: false,
        parameters: initialParams.parameters,
        sites: [],
        totalActivities: 0,
        loadingMore: false,
        noMoreSites: false,
        wishListSites: [],
        calendarFilterMode: false,
        endpointUrl: initialParams.endpoint,
        title: initialParams.title,
      );

  ActivitiesState copyWith({
    bool? loading,
    bool? stackLoading,
    Map<String, dynamic>? parameters,
    List<Site>? sites,
    int? totalActivities,
    List<Site>? wishListSites,
    bool? loadingMore,
    bool? noMoreSites,
    bool? calendarFilterMode,
    bool? hideFilterButton,
    String? endpointUrl,
    String? title,
  }) =>
      ActivitiesState(
        loading: loading ?? this.loading,
        parameters: parameters ?? this.parameters,
        stackLoading: stackLoading ?? this.stackLoading,
        sites: sites ?? this.sites,
        totalActivities: totalActivities ?? this.totalActivities,
        wishListSites: wishListSites ?? this.wishListSites,
        loadingMore: loadingMore ?? this.loadingMore,
        noMoreSites: noMoreSites ?? this.noMoreSites,
        endpointUrl: endpointUrl ?? this.endpointUrl,
        title: title ?? this.title,
        calendarFilterMode: calendarFilterMode ?? this.calendarFilterMode,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [
        totalActivities,
        loading,
        sites,
        wishListSites,
        loadingMore,
        noMoreSites,
        endpointUrl,
        title,
        calendarFilterMode,
        parameters,
      ];
}
