import '../../entities/site.dart';

class FilterStoreState {
  final bool loading;
  final bool noMoreRecord;

  final bool isFilterApplied;

  String selectedActivity;
  String selectedDuration;
  String selectedCustomerReviewSorting;

  double priceMin;
  double priceMax;

  List<Site> filteredSites;

  FilterStoreState({
    required this.loading,
    required this.noMoreRecord,

    required this.isFilterApplied,
    required this.selectedActivity,
    required this.priceMax,
    required this.priceMin,
    required this.selectedDuration,
    required this.selectedCustomerReviewSorting,
    required this.filteredSites,
  });

  factory FilterStoreState.initial() => FilterStoreState(
      loading: false,
      noMoreRecord: false,

      isFilterApplied: false,
      selectedActivity: "",
      priceMin: 0,
      priceMax: 6400,
      selectedDuration: "",
      selectedCustomerReviewSorting: "",
      filteredSites: []);

  FilterStoreState copyWith({
    bool? loading,
    bool? noMoreRecord,

    bool? isFilterApplied,
    String? selectedActivity,
    double? priceMin,
    double? priceMax,
    String? selectedDuration,
    String? selectedCustomerReviewSorting,
    List<Site>? filteredSites,
  }) =>
      FilterStoreState(
        loading: loading ?? this.loading,
        noMoreRecord: noMoreRecord ?? this.noMoreRecord,
        isFilterApplied: isFilterApplied ?? this.isFilterApplied,
        selectedActivity: selectedActivity ?? this.selectedActivity,
        priceMin: priceMin ?? this.priceMin,
        priceMax: priceMax ?? this.priceMax,
        selectedDuration: selectedDuration ?? this.selectedDuration,
        selectedCustomerReviewSorting:
            selectedCustomerReviewSorting ?? this.selectedCustomerReviewSorting,
        filteredSites: filteredSites ?? this.filteredSites,
      );
}
