import 'package:triplaner/domain/entities/city.dart';
import 'package:triplaner/domain/entities/popular_gateway_detail.dart';
import 'package:triplaner/domain/entities/site.dart';

import 'destination_detail_initial_params.dart';

class DestinationDetailState {
  final bool loading;
  final City city;
  final List<Site> unCoverMore;
  final bool loadingUncover;
  final bool loadingMoreUncover;

  /// for pagination loader
  final bool noMoreUncover;

  final PopularGatewayDetail popularGatewayDetail;

  final List<Site> wishListSites;

  const DestinationDetailState({
    required this.loading,
    required this.city,
    required this.popularGatewayDetail,
    required this.unCoverMore,
    required this.loadingUncover,
    required this.loadingMoreUncover,
    required this.noMoreUncover,
    required this.wishListSites,
  });

  factory DestinationDetailState.initial(
          {required DestinationDetailInitialParams initialParams}) =>
      DestinationDetailState(
        loading: false,
        city: initialParams.city,
        popularGatewayDetail: PopularGatewayDetail.empty(),
        unCoverMore: [],
        loadingMoreUncover: false,
        loadingUncover: false,
        noMoreUncover: false,
        wishListSites: [],
      );

  DestinationDetailState copyWith(
          {bool? loading,
          City? city,
          PopularGatewayDetail? popularGatewayDetail,
          List<Site>? unCoverMore,
          List<Site>? wishListSites,
          bool? loadingMoreUncover,
          bool? loadingUncover,
          bool? noMoreUncover}) =>
      DestinationDetailState(
        loading: loading ?? this.loading,
        city: city ?? this.city,
        popularGatewayDetail: popularGatewayDetail ?? this.popularGatewayDetail,
        unCoverMore: unCoverMore ?? this.unCoverMore,
        loadingUncover: loadingUncover ?? this.loadingUncover,
        loadingMoreUncover: loadingMoreUncover ?? this.loadingMoreUncover,
        noMoreUncover: noMoreUncover ?? this.noMoreUncover,
        wishListSites: wishListSites ?? this.wishListSites,
      );
}
