import 'filter_initial_params.dart';

class FilterState {
  final bool loading;
  String selectedActivity;
  String selectedDuration;
  String selectedCustomerReviewSorting;

  double priceMin;
  double priceMax;

  FilterState(
      {required this.loading,
      required this.selectedActivity,
      required this.priceMax,
      required this.priceMin,
      required this.selectedDuration,
      required this.selectedCustomerReviewSorting,

      });

  factory FilterState.initial({required FilterInitialParams initialParams}) =>
      FilterState(
          loading: false,
        selectedActivity:"",
          priceMin: 0,
          priceMax: 6400,
          selectedDuration: "",
          selectedCustomerReviewSorting:"",
      );

  FilterState copyWith(
          {bool? loading,
          String? selectedActivity,
          double? priceMin,
          double? priceMax,
          String? selectedDuration,
          String? selectedCustomerReviewSorting,

          }) =>
      FilterState(
        loading: loading ?? this.loading,
        selectedActivity: selectedActivity ?? this.selectedActivity,
        priceMin: priceMin ?? this.priceMin,
        priceMax: priceMax ?? this.priceMax,
        selectedDuration: selectedDuration ?? this.selectedDuration,
        selectedCustomerReviewSorting: selectedCustomerReviewSorting ?? this.selectedCustomerReviewSorting,
      );
}
