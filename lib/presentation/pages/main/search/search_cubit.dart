import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:triplaner/domain/entities/search_location.dart';
import 'package:triplaner/domain/entities/search_suggestion.dart';
import 'package:triplaner/domain/entities/user.dart';
import 'package:triplaner/domain/repositories/database_repository.dart';
import 'package:triplaner/domain/repositories/local_storage_repository.dart';
import 'package:triplaner/domain/stores/user_store.dart';
import 'package:triplaner/domain/stores/wishlist/wishlist_store.dart';
import 'package:triplaner/network/api_endpoint.dart';
import 'package:triplaner/presentation/base_cubit/base_cubit.dart';
import 'package:triplaner/presentation/pages/main/activites/activities_initial_params.dart';
import 'package:triplaner/presentation/pages/main/site_detail/site_detail_initial_params.dart';
import 'package:triplaner/util/alert/app_snackbar.dart';
import '../../../../domain/entities/site.dart';
import 'search_initial_params.dart';
import 'search_state.dart';
import 'search_navigator.dart';

class SearchCubit extends BaseCubit<SearchState> {
  SearchNavigator navigator;
  SearchInitialParams initialParams;
  AppSnackBar snackBar;
  DatabaseRepository databaseRepository;
  LocalStorageRepository localStorageRepository;

  UserStore userStore;
  WishListStore wishListStore;

  SearchCubit({
    required this.navigator,
    required this.initialParams,
    required this.snackBar,
    required this.databaseRepository,
    required this.userStore,
    required this.wishListStore,
    required this.localStorageRepository,
  }) : super(SearchState.initial(initialParams: initialParams));

  BuildContext get context => navigator.context;

  final txtSearch = TextEditingController();

  onInit() {
    _getWishList();
    _getRecentSearches();
  }

  _getRecentSearches() async {
    List<String> recentSearches =
        await localStorageRepository.getRecentSearches();
    emit(state.copyWith(recentSearches: recentSearches));
  }

  _saveIntoRecentSearch(String search) async {
    await localStorageRepository.saveRecentSearch(search: search);
    _getRecentSearches();
  }

  onSearchAction(val) async {
    try {
      _onType(val);
      String search = val.trim();
      if (search.isEmpty) return;
      if (search.length < 3) return;
      emit(state.copyWith(loading: true,searchText: val));
      SearchSuggestion searchSuggestion =
          await databaseRepository.getSearchSuggestions(name: search);

      emit(state.copyWith(
          searchText: search,
          loading: false,
          suggestedSites: state.searchText.isEmpty
              ? []
              : searchSuggestion.attractions?.take(5).toList(),
          suggestedLocations:
              state.searchText.isEmpty ? [] : searchSuggestion.location));
    } catch (e) {
      emit(state.copyWith(loading: false));
      snackBar.show(context: context, info: e.toString());
    }
  }

  clearTextField() {
    txtSearch.text = "";
    emit(state.copyWith(
      showClearIcon: false,
      suggestedLocations: [],
      suggestedSites: [],
    ));
  }

  clearSearch() {
    txtSearch.text = "";
    state.suggestedLocations.isEmpty
        ? localStorageRepository.clearRecentSearch()
        : null;
    emit(state.copyWith(
        searchText: "",
        showClearIcon: false,
        suggestedLocations: [],
        suggestedSites: [],
        recentSearches:
            state.suggestedLocations.isEmpty ? [] : state.recentSearches));
  }

  _getWishList() {
    if (state.wishListSites.isEmpty && userStore.state != User.empty()) {
      databaseRepository.getMyWishListSites().then((value) {
        wishListStore.setWishList(value);
      }).onError((error, stackTrace) {
        handleException(error.toString(), context);
      });
    }
  }

  onSuggestionTap(SearchLocation searchLocation) {
    _saveIntoRecentSearch(txtSearch.text ?? "");
    navigator.openActivities(ActivitiesInitialParams(
      endpoint: "${APIEndpoint.getSitesOfCity}/${searchLocation.id}",
      title: "${searchLocation.name}",
      searchLocation: searchLocation,
      showFilterButton: true,
    ));
  }

  onSiteTap(Site site) {
    _saveIntoRecentSearch(txtSearch.text ?? "");
    navigator.openSiteDetail(SiteDetailInitialParams(site: site));
  }

  _onType(String txt) {
    emit(state.copyWith(
        showClearIcon: txt.isNotEmpty,
        suggestedSites: txt.isEmpty ? [] : state.suggestedSites,
        suggestedLocations: txt.isEmpty ? [] : state.suggestedLocations));
  }
}
