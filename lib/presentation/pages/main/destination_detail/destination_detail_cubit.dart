import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:triplaner/domain/entities/city.dart';
import 'package:triplaner/domain/entities/popular_gateway_detail.dart';
import 'package:triplaner/domain/entities/top_activity.dart';
import 'package:triplaner/domain/stores/user_store.dart';
import 'package:triplaner/domain/stores/wishlist/wishlist_store.dart';
import 'package:triplaner/network/api_endpoint.dart';
import 'package:triplaner/presentation/pages/main/activites/activities_initial_params.dart';
import 'package:triplaner/presentation/pages/main/activites/calendar/calendar_initial_params.dart';
import 'package:triplaner/presentation/pages/main/site_detail/site_detail_initial_params.dart';
import 'package:triplaner/util/alert/app_snackbar.dart';
import '../../../../domain/entities/site.dart';
import '../../../../domain/entities/user.dart';
import '../../../../domain/repositories/database_repository.dart';
import '../../authentication/login/login_initial_params.dart';
import '../../confirmation/confirmation_initial_params.dart';
import 'destination_detail_initial_params.dart';
import 'destination_detail_state.dart';
import 'destination_detail_navigator.dart';

class DestinationDetailCubit extends Cubit<DestinationDetailState> {
  DestinationDetailNavigator navigator;
  DestinationDetailInitialParams initialParams;
  AppSnackBar snackBar;
  DatabaseRepository databaseRepository;
  UserStore userStore;
  WishListStore wishListStore;

  DestinationDetailCubit({
    required this.navigator,
    required this.initialParams,
    required this.databaseRepository,
    required this.snackBar,
    required this.userStore,
    required this.wishListStore,
  }) : super(DestinationDetailState.initial(initialParams: initialParams));

  BuildContext get context => navigator.context;

  onInit() {
    _getPopularGatewayDetails();
    _getUncoverMore();
    _listenToWishList();
  }

  _getPopularGatewayDetails() async {
    try {
      emit(state.copyWith(loading: true));
      PopularGatewayDetail popularGatewayDetail =
          await databaseRepository.getPopularGatewayDetail(city: state.city);
      emit(state.copyWith(
          loading: false, popularGatewayDetail: popularGatewayDetail));
    } catch (e) {
      emit(state.copyWith(loading: false));
      snackBar.show(context: context, info: e.toString());
    }
  }

  _getUncoverMore() async {
    try {
      emit(state.copyWith(loadingUncover: true));
      List<Site> uncoverMore =
          await databaseRepository.getUncoverMore(city: state.city);
      emit(state.copyWith(
          loadingUncover: false,
          unCoverMore: uncoverMore,
          noMoreUncover: uncoverMore.isEmpty));
    } catch (e) {
      emit(state.copyWith(loadingUncover: false));
      snackBar.show(context: context, info: e.toString());
    }
  }

  getMoreUncover() async {
    try {
      emit(state.copyWith(loadingMoreUncover: true));
      List<Site> uncoverMore = await databaseRepository.getUncoverMore(
          city: state.city, skip: state.unCoverMore.length, take: 10);
      state.unCoverMore.addAll(uncoverMore);
      emit(state.copyWith(
          loadingMoreUncover: false,
          unCoverMore: state.unCoverMore,
          noMoreUncover: uncoverMore.isEmpty));
    } catch (e) {
      emit(state.copyWith(loadingMoreUncover: false));
      snackBar.show(context: context, info: e.toString());
    }
  }

  siteAction(Site site) {
    navigator.openSiteDetail(SiteDetailInitialParams(site: site));
  }

  activityAction(TopActivity activity) {
    navigator.openActivities(ActivitiesInitialParams(
      endpoint: APIEndpoint.getTopActivityDetail,
      parameters: {
        "activity": activity.name,
        "gatewayId": state.city.id,
      },
      title: activity.name ?? "N/A",
    ));
  }

  _listenToWishList() {
    emit(state.copyWith(wishListSites: wishListStore.state.sites));
    wishListStore.stream.listen((event) {
      emit(state.copyWith(wishListSites: event.sites));
    });
  }

  bool isBookMarked(Site site) {
    return state.wishListSites.contains(site);
  }

  void onBookMarkTap(Site site) {
    if (userStore.state == User.empty()) {
      navigator.openConfirmation(ConfirmationInitialParams(
          title: "",
          subtitle: "Login or Create free account to add to the Wishlist.",
          btnText: "Login",
          btnAction: () {
            navigator.openLogin(const LoginInitialParams());
          }));
      return;
    }
    if (isBookMarked(site)) {
      wishListStore.removeFromWishList(site, context);
      databaseRepository.addOrRemoveFromWishList(siteId: site.id!);
    } else {
      wishListStore.addIntoWishList(site, context);
      databaseRepository.addOrRemoveFromWishList(siteId: site.id!);
    }
  }

  openCalendarAction() {
    navigator.openCalendar(CalendarInitialParams(
        dateTime: DateTime.now(), onSelectDate: (date) {}, onClear: () {}));
  }
}
