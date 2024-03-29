import 'package:equatable/equatable.dart';
import 'package:triplaner/domain/entities/site.dart';

import 'wishlist_initial_params.dart';

class WishlistState extends Equatable{
  final bool loading;
  final List<Site> sites;

  const WishlistState({required this.loading, required this.sites});

  factory WishlistState.initial(
          {required WishlistInitialParams initialParams}) =>
      WishlistState(loading: false, sites: []);

  WishlistState copyWith({bool? loading, List<Site>? sites}) => WishlistState(
        loading: loading ?? this.loading,
        sites: sites ?? this.sites,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [loading,sites];
}
