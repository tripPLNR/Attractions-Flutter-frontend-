import 'check_availability_initial_params.dart';

class CheckAvailabilityState {
  final bool loading;
  final int adultCount;
  final int childrenCount;

  const CheckAvailabilityState(
      {required this.loading,
      required this.adultCount,
      required this.childrenCount});

  factory CheckAvailabilityState.initial(
          {required CheckAvailabilityInitialParams initialParams}) =>
      const CheckAvailabilityState(loading: false, adultCount: 0, childrenCount: 0);

  CheckAvailabilityState copyWith(
          {bool? loading, int? adultCount, int? childrenCount}) =>
      CheckAvailabilityState(
        loading: loading ?? this.loading,
        adultCount: adultCount ?? this.adultCount,
        childrenCount: childrenCount ?? this.childrenCount,
      );
}
