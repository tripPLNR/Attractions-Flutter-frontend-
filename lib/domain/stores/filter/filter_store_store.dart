import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:triplaner/domain/repositories/database_repository.dart';
import 'package:triplaner/domain/stores/filter/filter_state.dart';

import '../../entities/site.dart';

class FilterStore extends Cubit<FilterStoreState> {
  DatabaseRepository databaseRepository;

  FilterStore({required this.databaseRepository})
      : super(FilterStoreState.initial());

  applyFilter({
    String? selectedActivity,
    double? priceMin,
    double? priceMax,
    String? selectedDuration,
    String? selectedCustomerReviewSorting,

  }) async {
    try {
      emit(state.copyWith(
        selectedActivity: selectedActivity,
        priceMin: priceMin,
        priceMax: priceMax,
        selectedDuration: selectedDuration,
        selectedCustomerReviewSorting: selectedCustomerReviewSorting,
        loading: true,
        noMoreRecord: false
      ));
      List<Site> filterResult = await databaseRepository.filterActivities(
        tag: selectedActivity,
        minPrice: priceMin.toString(),
        maxPrice: priceMax.toString(),
        ratingSort: selectedCustomerReviewSorting=="Highest to Lowest"?"DESC":"ASC",
        duration: selectedDuration,

      );
      emit(state.copyWith(
          loading: false,
          filteredSites: filterResult,
           isFilterApplied: true,
      ));
    }catch(e){
      emit(state.copyWith(
          loading: false,
      ));
      throw e.toString();
    }
  }


  resetFilter(){
    emit(FilterStoreState.initial());
  }

  getMoreFilterSites({required int skip, required int take}) async {
    try {
      List<Site> filterResult = await databaseRepository.filterActivities(
        tag: state.selectedActivity,
        minPrice: state.priceMin.toString(),
        maxPrice: state.priceMax.toString(),
        ratingSort: state.selectedCustomerReviewSorting=="Highest to Lowest"?"DESC":"ASC",
        duration: state.selectedDuration,
        take: take,
        skip: skip
      );
      state.filteredSites.addAll(filterResult);

      emit(state.copyWith(
          loading: false,
          filteredSites: state.filteredSites,
          noMoreRecord: filterResult.isEmpty
      ));
    }catch(e){
      emit(state.copyWith(
        loading: false,
      ));
      throw e.toString();
    }
  }
}
