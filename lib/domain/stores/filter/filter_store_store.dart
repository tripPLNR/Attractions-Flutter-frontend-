import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:triplaner/domain/entities/search_location.dart';
import 'package:triplaner/domain/http_request_body/filter_request_body.dart';
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
    SearchLocation? searchLocation,
    double? latitude,
    double? longitude,
  }) async {
    try {
      emit(state.copyWith(
          selectedActivity: selectedActivity,
          priceMin: priceMin,
          priceMax: priceMax,
          selectedDuration: selectedDuration,
          selectedCustomerReviewSorting: selectedCustomerReviewSorting,
          loading: true,
          noMoreRecord: false));
      FilterRequestBody body = FilterRequestBody(
        take: "10",
        skip: "0",
        tag: selectedActivity,
        minPrice: priceMin.toString(),
        maxPrice: priceMax.toString(),
        ratingSort: selectedCustomerReviewSorting == ""
            ? null
            : selectedCustomerReviewSorting == "Highest to Lowest"
                ? "DESC"
                : "ASC",
        duration: selectedDuration,
        locationId: searchLocation?.id,
        latitude: latitude?.toString(),
        longitude: longitude?.toString(),
      );
      List<Site> filterResult =
          await databaseRepository.filterActivities(filterRequestBody: body);
      emit(state.copyWith(
        loading: false,
        filteredSites: filterResult,
        isFilterApplied: true,
      ));
    } catch (e) {
      emit(state.copyWith(
        loading: false,
      ));
      throw e.toString();
    }
  }

  resetFilter() {
    emit(FilterStoreState.initial());
  }

  getMoreFilterSites({
    required int skip,
    required int take,
    SearchLocation? searchLocation,
    double? latitude,
    double? longitude,
  }) async {
    try {
      FilterRequestBody body = FilterRequestBody(
        tag: state.selectedActivity,
        minPrice: state.priceMin.toString(),
        maxPrice: state.priceMax.toString(),
        ratingSort: state.selectedCustomerReviewSorting.isEmpty
            ? null
            : state.selectedCustomerReviewSorting == "Highest to Lowest"
                ? "DESC"
                : "ASC",
        duration: state.selectedDuration,
        take: take.toString(),
        skip: skip.toString(),
        locationId: searchLocation?.id,
        latitude: latitude?.toString(),
        longitude: longitude?.toString(),
      );

      List<Site> filterResult =
          await databaseRepository.filterActivities(filterRequestBody: body);
      state.filteredSites.addAll(filterResult);

      emit(state.copyWith(
          loading: false,
          filteredSites: state.filteredSites,
          noMoreRecord: filterResult.isEmpty));
    } catch (e) {
      emit(state.copyWith(
        loading: false,
      ));
      throw e.toString();
    }
  }
}
