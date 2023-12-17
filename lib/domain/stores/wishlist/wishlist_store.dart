import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:triplaner/domain/entities/site.dart';
import 'package:triplaner/domain/repositories/database_repository.dart';
import 'package:triplaner/domain/stores/user_store.dart';
import 'package:triplaner/util/alert/app_snackbar.dart';

import '../../entities/user.dart';
import 'wishlist_store_state.dart';

class WishListStore extends Cubit<WishListStoreState>{
  DatabaseRepository databaseRepository;
  AppSnackBar snackBar;
  WishListStore({required this.databaseRepository,required this.snackBar,}):super(WishListStoreState.initial());



  getWishList() {
    emit(state.copyWith(loading: true));
    databaseRepository.getMyWishListSites().then((value){
      emit(state.copyWith(sites: value,loading: false));
    }).onError((error, stackTrace){
      emit(state.copyWith(loading: false));
    });
  }


  setWishList(List<Site> sites){
    emit(state.copyWith(sites: sites));
  }

  addIntoWishList(Site site,BuildContext context){
    List<Site> sites=state.sites;
    sites.insert(0, site);
    emit(state.copyWith(sites: sites));
    snackBar.show(context: context, info: "Added to wishlist",snackBarType: SnackBarType.SUCCESS);
  }
  removeFromWishList(Site site,BuildContext context){
    List<Site> sites=state.sites;
    sites.remove(site);
    emit(state.copyWith(sites: sites));
    snackBar.show(context: context, info: "Removed from wishlist",snackBarType: SnackBarType.INFO);
  }

}