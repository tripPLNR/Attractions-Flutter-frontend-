import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:triplaner/domain/stores/filter/filter_store_store.dart';
import 'package:triplaner/util/alert/app_snackbar.dart';
import 'package:triplaner/util/app_assets.dart';
import 'filter_initial_params.dart';
import 'filter_state.dart';
import 'filter_navigator.dart';

class FilterCubit extends Cubit<FilterState> {
  FilterNavigator navigator;
  FilterInitialParams initialParams;
  FilterStore filterStore;
  AppSnackBar snackBar;
  FilterCubit({required this.navigator, required this.initialParams,required this.filterStore,required this.snackBar})
      : super(FilterState.initial(initialParams: initialParams));

  BuildContext get context => navigator.context;

  List<Map<String, dynamic>> activities = [
    {
      "title": "Museums & Attractions",
      "icon": AppAssets.museum,
    },
    {
      "title": "Food & Drink",
      "icon": AppAssets.foodAndDrink,
    },
    {
      "title": "Nature & Wildlife",
      "icon": AppAssets.natureAndWildLife,
    },
    {
      "title": "Cultural Experience",
      "icon": AppAssets.culturalExperiences,
    },
    {
      "title": "Sightseeing Tours",
      "icon": AppAssets.sightseeingTour,
    },
    {
      "title": "Skip the line",
      "icon": AppAssets.skipLine,
    },
    {
      "title": "Guided & Private Tours",
      "icon": AppAssets.guidedPrivateTourFilter,
    },
    {
      "title": "Aquatic adventures",
      "icon": AppAssets.aquaticAdventure,
    },
    {
      "title": "Cruises & Navigating",
      "icon": AppAssets.cruisesAndNavigator,
    },

    {
      "title": "Spa & Massage",
      "icon": AppAssets.spaMassage,
    },
    {
      "title": "Hot springs",
      "icon": AppAssets.hotSprings,
    },

    {
      "title": "Airport & Hotel transfers",
      "icon": AppAssets.airport,
    },
  ];

  List<String> durations = [
    "0 to 1 hour",
    "1 to 4 hour",
    "4 to 24 hour",
    "more than 1 day"
  ];
  List<String> customerReviewSorting = [
    "Highest to Lowest",
    "Lowest to Highest"
  ];


  onInit(){
    emit(state.copyWith(
      selectedActivity: filterStore.state.selectedActivity,
      priceMin: filterStore.state.priceMin,
      priceMax: filterStore.state.priceMax,
      selectedDuration: filterStore.state.selectedDuration,
      selectedCustomerReviewSorting: filterStore.state.selectedCustomerReviewSorting,
    ));
    filterStore.stream.listen((event) {
      emit(state.copyWith(
        selectedActivity: event.selectedActivity,
        priceMin: event.priceMin,
        priceMax: event.priceMax,
        selectedDuration: event.selectedDuration,
        selectedCustomerReviewSorting: event.selectedCustomerReviewSorting,
      ));
    });
  }
  void selectActivity(String activity) {
    if (state.selectedActivity==activity) {
      emit(state.copyWith(selectedActivity: ""));
    } else {
      emit(state.copyWith(selectedActivity: activity));
    }
  }

  updatePriceRange(double min, double max) {
    emit(state.copyWith(
      priceMax: max,
      priceMin: min,
    ));
  }

  selectDuration(String duration) {
    emit(state.copyWith(selectedDuration: duration));
  }

  selectReviewSorting(String reviewSorting) {
    emit(state.copyWith(selectedCustomerReviewSorting: reviewSorting));
  }

  filterAction(){
   try{
     filterStore.applyFilter(
       selectedActivity: state.selectedActivity,
       priceMin: state.priceMin,
       priceMax: state.priceMax,
       selectedDuration: state.selectedDuration,
       selectedCustomerReviewSorting: state.selectedCustomerReviewSorting
     );
     Navigator.pop(context);
   }catch(e){
     snackBar.show(context: context, info: e.toString());
   }
  }

  clearFilter() async {
    try{
      filterStore.resetFilter();
      await Future.delayed(const Duration(milliseconds: 100));
      initialParams.clearFilter();
      Navigator.pop(context);
    }catch(e){
      snackBar.show(context: context, info: e.toString());
    }
  }
}
