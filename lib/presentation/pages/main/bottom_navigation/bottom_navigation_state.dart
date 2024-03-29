import 'package:equatable/equatable.dart';

import 'bottom_navigation_initial_params.dart';

class BottomNavigationState extends Equatable{
  final bool loading;
  final bool stackLoading;

  final bool isSearchModeON;
  final int selectedIndex;

  const BottomNavigationState(
      {required this.loading,
      required this.selectedIndex,
      required this.isSearchModeON,
      required this.stackLoading});

  factory BottomNavigationState.initial(
          {required BottomNavigationInitialParams initialParams}) =>
      const BottomNavigationState(
          loading: false,
          selectedIndex: 0,
          isSearchModeON: false,
          stackLoading: false);

  BottomNavigationState copyWith(
          {bool? loading,
          int? selectedIndex,
          bool? isSearchModeON,
          bool? stackLoading}) =>
      BottomNavigationState(
        loading: loading ?? this.loading,
        selectedIndex: selectedIndex ?? this.selectedIndex,
        isSearchModeON: isSearchModeON ?? this.isSearchModeON,
        stackLoading: stackLoading ?? this.stackLoading,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [
    loading,
    selectedIndex,
    isSearchModeON,
    stackLoading
  ];
}
