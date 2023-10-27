import 'bottom_navigation_initial_params.dart';

class BottomNavigationState {
  final bool loading;
  final bool isSearchModeON;
  final int selectedIndex;
  const BottomNavigationState({required this.loading,required this.selectedIndex,required this.isSearchModeON});

  factory BottomNavigationState.initial(
          {required BottomNavigationInitialParams initialParams}) =>
      const BottomNavigationState(loading: false,selectedIndex: 0,isSearchModeON: false);

  BottomNavigationState copyWith({bool? loading,int? selectedIndex,bool? isSearchModeON}) =>
      BottomNavigationState(loading: loading ?? this.loading,selectedIndex: selectedIndex??this.selectedIndex,
          isSearchModeON:isSearchModeON??this.isSearchModeON,
      );
}
