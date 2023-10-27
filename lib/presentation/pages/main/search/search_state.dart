import 'search_initial_params.dart';

class SearchState {
final bool loading;
const SearchState({required this.loading});

factory SearchState.initial({required SearchInitialParams initialParams}) => SearchState(loading: false);

SearchState copyWith({bool? loading}) => SearchState(loading: loading??this.loading);
}
