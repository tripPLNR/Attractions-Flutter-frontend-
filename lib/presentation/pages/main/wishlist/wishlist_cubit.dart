import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:triplaner/domain/entities/site.dart';
import 'package:triplaner/domain/entities/user.dart';
import 'package:triplaner/domain/repositories/database_repository.dart';
import 'package:triplaner/domain/stores/currency_store.dart';
import 'package:triplaner/domain/stores/user_store.dart';
import 'package:triplaner/domain/stores/wishlist/wishlist_store.dart';
import 'package:triplaner/presentation/pages/authentication/login/login_initial_params.dart';
import 'package:triplaner/presentation/pages/confirmation/confirmation_initial_params.dart';
import 'package:triplaner/presentation/pages/main/site_detail/site_detail_initial_params.dart';
import 'package:triplaner/util/alert/app_snackbar.dart';
import 'package:triplaner/util/app_funtions.dart';
import 'wishlist_initial_params.dart';
import 'wishlist_state.dart';
import 'wishlist_navigator.dart';

class WishlistCubit extends Cubit<WishlistState> {
  WishlistNavigator navigator;
  WishlistInitialParams initialParams;
  AppSnackBar snackBar;
  UserStore userStore;
  WishListStore wishListStore;
  DatabaseRepository databaseRepository;
  CurrencyStore currencyStore;
  WishlistCubit(
      {required this.navigator,
      required this.initialParams,
      required this.snackBar,
      required this.userStore,
      required this.wishListStore,
      required this.databaseRepository,
      required this.currencyStore,

      })
      : super(WishlistState.initial(initialParams: initialParams));

  BuildContext get context => navigator.context;

  onInit(){
    _listenToWishList();
    _listenToCurrencyChange();
  }

  _listenToCurrencyChange() {
    currencyStore.stream.listen((event) {
      debugPrint("GETTING WHISH LIST...");
      wishListStore.getWishList();
    });
  }

  _listenToWishList(){
    emit(state.copyWith(sites: wishListStore.state.sites,loading: wishListStore.state.loading));
    wishListStore.stream.listen((event) {
      debugPrint("WE got wishlist : ${event.sites.length}");
      emit(state.copyWith(sites: event.sites,loading: false));
    });
  }

  bool isUserLoggedIn(){
    return userStore.state!=User.empty();
  }

  onSiteAction(Site site){
    navigator.openSiteDetail(SiteDetailInitialParams(site: site));
  }
  removeFromWishList(Site site){
    wishListStore.removeFromWishList(site,context);
    databaseRepository.addOrRemoveFromWishList(siteId: site.id!);
  }
  shareSiteAction(Site site){
    AppFunctions.shareSite(site);
  }


  loginAction(){
    navigator.openLogin(LoginInitialParams());
  }

}
