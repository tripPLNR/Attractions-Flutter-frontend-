import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:triplaner/domain/entities/site.dart';
import 'package:triplaner/util/alert/app_snackbar.dart';
import '../../../../domain/repositories/database_repository.dart';
import 'site_detail_initial_params.dart';
import 'site_detail_state.dart';
import 'site_detail_navigator.dart';

class SiteDetailCubit extends Cubit<SiteDetailState> {
  SiteDetailNavigator navigator;
  SiteDetailInitialParams initialParams;
  AppSnackBar snackBar;
  DatabaseRepository databaseRepository;

  SiteDetailCubit({
    required this.navigator,
    required this.initialParams,
    required this.databaseRepository,
    required this.snackBar,
  }) : super(SiteDetailState.initial(initialParams: initialParams));

  BuildContext get context => navigator.context;


  updateSelectedMenu(int index){
    emit(state.copyWith(selectedMenuIndex: index));
  }


  getSimilarExperiences() async {
    try{
      /// if we already got then no need to call
      if(state.similarExperiences.isNotEmpty || state.loadingSimilarExperiences) return;
      emit(state.copyWith(loadingSimilarExperiences: true));
      List<Site> sites=await databaseRepository.getSimilarExperiences(siteId: state.site.id!,take: 5);
      emit(state.copyWith(loadingSimilarExperiences: false,similarExperiences: sites));
    }catch(e){
      emit(state.copyWith(loadingSimilarExperiences: false));
      snackBar.show(context: context, info: e.toString());
    }
  }

  similarExperienceTap(Site site){
    navigator.openSiteDetail(SiteDetailInitialParams(site: site));
    //emit(state.copyWith(site: site,similarExperiences: []));
  }

  updateAppbarView(bool show){
    emit(state.copyWith(showAppbar: show));
  }
}
