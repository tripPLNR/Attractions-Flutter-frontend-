import 'calendar_initial_params.dart';

class CalendarState {
final bool loading;
const CalendarState({required this.loading});

factory CalendarState.initial({required CalendarInitialParams initialParams}) => CalendarState(loading: false);

CalendarState copyWith({bool? loading}) => CalendarState(loading: loading??this.loading);
}
