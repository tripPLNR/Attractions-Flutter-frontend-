import 'package:triplaner/domain/entities/search_location.dart';
import 'package:triplaner/domain/entities/site.dart';

import '../../../../domain/entities/search_suggestion.dart';
import 'search_initial_params.dart';

class SearchState {
  final bool loading;
  final bool showClearIcon;

  final String searchText;
  final List<Site> suggestedSites;
  final List<SearchLocation> suggestedLocations;
  final List<Site> wishListSites;
  final List<String> recentSearches;

  const SearchState({
    required this.loading,
    required this.showClearIcon,
    required this.searchText,
    required this.suggestedSites,
    required this.suggestedLocations,
    required this.wishListSites,
    required this.recentSearches,
  });

  factory SearchState.initial({required SearchInitialParams initialParams}) =>
      const SearchState(
        loading: false,
        showClearIcon: false,
        searchText: "",
        suggestedLocations: [],
        suggestedSites: [],
        wishListSites: [],
        recentSearches: [],
      );

  SearchState copyWith(
          {bool? loading,
          bool? showClearIcon,
          String? searchText,
          List<Site>? suggestedSites,
          List<Site>? wishListSites,
          List<SearchLocation>? suggestedLocations,
          List<String>? recentSearches,

          }) =>
      SearchState(
        loading: loading ?? this.loading,
        showClearIcon: showClearIcon ?? this.showClearIcon,
        searchText: searchText ?? this.searchText,
        suggestedSites: suggestedSites ?? this.suggestedSites,
        suggestedLocations: suggestedLocations ?? this.suggestedLocations,
        wishListSites: wishListSites ?? this.wishListSites,
        recentSearches: recentSearches ?? this.recentSearches,

      );
}
