import 'wishlist_initial_params.dart';

class WishlistState {
final bool loading;
const WishlistState({required this.loading});

factory WishlistState.initial({required WishlistInitialParams initialParams}) => WishlistState(loading: false);

WishlistState copyWith({bool? loading}) => WishlistState(loading: loading??this.loading);
}
