import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:triplaner/domain/entities/site.dart';
import 'package:triplaner/presentation/pages/main/site_detail/site_detail_initial_params.dart';
import 'package:triplaner/util/app_assets.dart';
import '../../../../domain/repositories/database_repository.dart';
import '../../../../util/alert/app_snackbar.dart';
import 'activities_initial_params.dart';
import 'activities_state.dart';
import 'activities_navigator.dart';

class ActivitiesCubit extends Cubit<ActivitiesState> {
  ActivitiesNavigator navigator;
  ActivitiesInitialParams initialParams;
  AppSnackBar snackBar;
  DatabaseRepository databaseRepository;
  ActivitiesCubit(
      {required this.navigator,
      required this.initialParams,
      required this.snackBar,
      required this.databaseRepository})
      : super(ActivitiesState.initial(initialParams: initialParams));

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


  onInit(){
    _getSitesFromEndpoint();
  }

  _getSitesFromEndpoint() async {
    try{
      emit(state.copyWith(loading: true));
      List<Site> sites=await databaseRepository.getSitesFromEndpoint(endpoint: state.endpointUrl);
      emit(state.copyWith(loading: false,sites: sites));
    }catch(e){
      emit(state.copyWith(loading: false));
      snackBar.show(context: context, info: e.toString());
    }
  }

  getMoreSitesFromEndpoint() async {
    try{
      emit(state.copyWith(loadingMore: true));
      List<Site> sites=await databaseRepository.getSitesFromEndpoint(endpoint: state.endpointUrl,skip: state.sites.length,take: 10);
      state.sites.addAll(sites);
      emit(state.copyWith(loadingMore: false,sites: state.sites));
    }catch(e){
      emit(state.copyWith(loadingMore: false));
      snackBar.show(context: context, info: e.toString());
    }
  }
  onTapAction(Site site){
    navigator.openSiteDetail(SiteDetailInitialParams(
      site: site
    ));
  }

}
