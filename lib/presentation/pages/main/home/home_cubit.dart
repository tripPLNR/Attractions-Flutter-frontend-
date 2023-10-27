import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:triplaner/domain/entities/city.dart';
import 'package:triplaner/domain/entities/site.dart';
import 'package:triplaner/domain/entities/top_activity.dart';
import 'package:triplaner/domain/repositories/database_repository.dart';
import 'package:triplaner/network/api_endpoint.dart';
import 'package:triplaner/presentation/pages/main/activites/activities_initial_params.dart';
import 'package:triplaner/presentation/pages/main/destination_detail/destination_detail_initial_params.dart';
import 'package:triplaner/presentation/pages/main/site_detail/site_detail_initial_params.dart';
import 'package:triplaner/util/alert/app_snackbar.dart';
import 'package:triplaner/util/services/location/location_service.dart';
import 'home_initial_params.dart';
import 'home_state.dart';
import 'home_navigator.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeNavigator navigator;
  HomeInitialParams initialParams;
  AppSnackBar snackBar;
  DatabaseRepository databaseRepository;
  LocationService locationService;
  HomeCubit({
    required this.navigator,
    required this.initialParams,
    required this.snackBar,
    required this.databaseRepository,
    required this.locationService,

  }) : super(HomeState.initial(initialParams: initialParams));

  BuildContext get context => navigator.context;

  onInit(){
    _getAll();
  }

  _getAll(){
    _getPopularGateways();
    _getSighSeeingTours();
    _getTopActivities();
    _getAttractionWorldWide();
    _getWaterAdventures();
    _getMoreToExplore();
  }

  _getPopularGateways() async {
    try{
      if(state.cities.isNotEmpty) return;
      emit(state.copyWith(loadingPopularGateways:true));
      List<City> cities=await databaseRepository.getPopularGateways();
      emit(state.copyWith(loadingPopularGateways:false,cities: cities));
    }catch(e){
      emit(state.copyWith(loadingPopularGateways:false));
      snackBar.show(context: context, info: e.toString());
      debugPrint(e.toString());
    }
  }


  _getTopActivities() async {
    try{
      if(state.topActivities.isNotEmpty) return;
      emit(state.copyWith(loadingTopActivities:true));
      List<TopActivity> topActivities=await databaseRepository.getTopActivities();
      emit(state.copyWith(loadingTopActivities:false,topActivities:topActivities));
    }catch(e){
      emit(state.copyWith(loadingTopActivities:false));
      snackBar.show(context: context, info: e.toString());
      debugPrint(e.toString());
    }
  }

  _getSighSeeingTours() async {
    try{
      if(state.siteSeeingTours.isNotEmpty) return;
      emit(state.copyWith(loadingSiteSeeingTours:true));
      List<Site> sites=await databaseRepository.getSiteSeeingTours();
      emit(state.copyWith(loadingSiteSeeingTours:false,siteSeeingTours:sites));
    }catch(e){
      emit(state.copyWith(loadingSiteSeeingTours:false));
      snackBar.show(context: context, info: e.toString());
    }
  }

  _getAttractionWorldWide() async {
    try{
      if(state.attractionsWorldWide.isNotEmpty) return;
      emit(state.copyWith(loadingAttractionWorldWide:true));
      List<Site> sites=await databaseRepository.getAttractionsWorldWide();
      emit(state.copyWith(loadingAttractionWorldWide:false,attractionsWorldWide:sites));
    }catch(e){
      emit(state.copyWith(loadingAttractionWorldWide:false));
      snackBar.show(context: context, info: e.toString());
    }
  }
  _getWaterAdventures() async {
    try{
      if(state.waterAdventures.isNotEmpty) return;
      emit(state.copyWith(loadingWaterAdventures:true));
      List<Site> sites=await databaseRepository.getWaterAdventures();
      emit(state.copyWith(loadingWaterAdventures:false,waterAdventures:sites));
    }catch(e){
      emit(state.copyWith(loadingWaterAdventures:false));
      snackBar.show(context: context, info: e.toString());
    }
  }

  _getMoreToExplore() async {
    try{
      if(state.moreToExplore.isNotEmpty) return;
      emit(state.copyWith(loadingMoreToExplore:true));
      List<Site> sites=await databaseRepository.getMoreToExplore();
      emit(state.copyWith(loadingMoreToExplore:false,moreToExplore:sites));
    }catch(e){
      emit(state.copyWith(loadingMoreToExplore:false));
      snackBar.show(context: context, info: e.toString());
    }
  }

  destinationTapAction(City city){
    navigator.openDestinationDetail(DestinationDetailInitialParams(
      city: city
    ));
  }

  activityAction(TopActivity activity){
    navigator.openActivities(ActivitiesInitialParams(
      endpoint: "${APIEndpoint.getTopActivities}/${activity.name}",
      title: activity.name??"N/A"
    ));
  }

  onNearbyAttraction() async {
    try{
      emit(state.copyWith(stackLoading: true));
      String location=await locationService.getCityName();
      emit(state.copyWith(stackLoading: false));
      navigator.openActivities(ActivitiesInitialParams(
          endpoint: "${APIEndpoint.getNearbySites}/$location",
          title: location
      ));
    }catch(e){
      emit(state.copyWith(stackLoading: false));
      snackBar.show(context: context, info: e.toString());
    }
  }

  onGuidedTour(){
    navigator.openActivities(ActivitiesInitialParams(
        endpoint: APIEndpoint.getGuidedTours,
        title: "Guided & Private tours"
    ));
  }

  seeMoreAction(){
    navigator.openActivities(ActivitiesInitialParams(
        endpoint: APIEndpoint.getExploreMore,
        title: "More to explore"
    ));
  }
  onSiteTap(Site site){
    navigator.openSiteDetail(SiteDetailInitialParams(
      site: site
    ));
  }
}
