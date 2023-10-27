import 'package:triplaner/domain/entities/site.dart';
import 'package:triplaner/domain/entities/top_activity.dart';

import '../../../../domain/entities/city.dart';
import 'home_initial_params.dart';

class HomeState {
  final bool loading;
  final bool stackLoading;

  final bool loadingPopularGateways;
  final List<City> cities;

  final bool loadingTopActivities;
  final List<TopActivity> topActivities;

  final bool loadingSiteSeeingTours;
  final List<Site> siteSeeingTours;

  final bool loadingAttractionWorldWide;
  final List<Site> attractionsWorldWide;

  final bool loadingWaterAdventures;
  final List<Site> waterAdventures;

  final bool loadingMoreToExplore;
  final List<Site> moreToExplore;

  const HomeState({
    required this.loading,
    required this.stackLoading,

    required this.loadingPopularGateways,
    required this.cities,
    required this.loadingTopActivities,
    required this.topActivities,
    required this.loadingSiteSeeingTours,
    required this.siteSeeingTours,
    required this.loadingAttractionWorldWide,
    required this.attractionsWorldWide,
    required this.loadingWaterAdventures,
    required this.waterAdventures,
    required this.loadingMoreToExplore,
    required this.moreToExplore,

  });

  factory HomeState.initial({required HomeInitialParams initialParams}) =>
      const HomeState(
        loading: false,
        stackLoading: false,
        loadingPopularGateways: false,
        cities: [],
        loadingTopActivities: false,
        topActivities: [],
        loadingSiteSeeingTours: false,
        siteSeeingTours: [],
        loadingAttractionWorldWide:false,
        attractionsWorldWide: [],
        loadingWaterAdventures: false,
        waterAdventures: [],
        loadingMoreToExplore: false,
        moreToExplore: [],

      );

  HomeState copyWith({
    bool? loading,
    bool? stackLoading,

    bool? loadingPopularGateways,
    List<City>? cities,
    bool? loadingTopActivities,
    List<TopActivity>? topActivities,
    bool? loadingSiteSeeingTours,
    List<Site>? siteSeeingTours,
    bool? loadingAttractionWorldWide,
    List<Site>? attractionsWorldWide,
    bool? loadingWaterAdventures,
    List<Site>? waterAdventures,

    bool? loadingMoreToExplore,
    List<Site>? moreToExplore,



  }) =>
      HomeState(
        loading: loading ?? this.loading,
        stackLoading: stackLoading ?? this.stackLoading,
        loadingPopularGateways:
            loadingPopularGateways ?? this.loadingPopularGateways,
        cities: cities ?? this.cities,
        loadingTopActivities: loadingTopActivities??this.loadingTopActivities,
        topActivities: topActivities??this.topActivities,
        loadingSiteSeeingTours: loadingSiteSeeingTours??this.loadingSiteSeeingTours,
        siteSeeingTours: siteSeeingTours??this.siteSeeingTours,
        loadingAttractionWorldWide: loadingAttractionWorldWide??this.loadingAttractionWorldWide,
        attractionsWorldWide: attractionsWorldWide??this.attractionsWorldWide,
        loadingWaterAdventures: loadingWaterAdventures??this.loadingWaterAdventures,
        waterAdventures: waterAdventures??this.waterAdventures,
        loadingMoreToExplore: loadingMoreToExplore??this.loadingMoreToExplore,
        moreToExplore: moreToExplore??this.moreToExplore,
      );
}
