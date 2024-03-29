import 'package:equatable/equatable.dart';
import 'package:triplaner/domain/entities/site.dart';

class WishListStoreState extends Equatable {
  final bool loading;
  List<Site> sites;

  WishListStoreState({
    required this.loading,
    required this.sites,
  });

  factory WishListStoreState.initial() => WishListStoreState(
        loading: false,
        sites: [],
      );

  WishListStoreState copyWith({
    bool? loading,
    List<Site>? sites,
  }) =>
      WishListStoreState(
        loading: loading ?? this.loading,
        sites: sites ?? this.sites,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [
        loading,
        sites,
      ];
}
