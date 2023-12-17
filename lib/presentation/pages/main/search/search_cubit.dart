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
import '../../authentication/login/login_initial_params.dart';
import '../../confirmation/confirmation_initial_params.dart';
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

  onSearchAction() async {
    try {
      _onType(txtSearch.text);
      String search = txtSearch.text;
      if (search.isEmpty) return;
      if (search.length < 3) return;
      emit(state.copyWith(loading: true));
      SearchSuggestion searchSuggestion =
          await databaseRepository.getSearchSuggestions(name: search);

      emit(state.copyWith(
          searchText: search,
          loading: false,
          suggestedSites: searchSuggestion.attractions?.take(5).toList(),
          suggestedLocations: searchSuggestion.location));
    } catch (e) {
      emit(state.copyWith(loading: false));
      snackBar.show(context: context, info: e.toString());
    }
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
        endpoint: APIEndpoint.getNearbySites,
        title: "${searchLocation.cityName}",
        parameters: {
          "city": searchLocation.cityName?.split(",").first,
          "country": searchLocation.cityName?.split(",").last,
        }));
  }

  onSiteTap(Site site) {
    _saveIntoRecentSearch(txtSearch.text ?? "");
    navigator.openSiteDetail(SiteDetailInitialParams(site: site));
  }

  _onType(String txt) {
    emit(state.copyWith(showClearIcon: txt.isNotEmpty));
  }
}
