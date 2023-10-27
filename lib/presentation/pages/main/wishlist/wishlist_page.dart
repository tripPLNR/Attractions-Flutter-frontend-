import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'wishlist_cubit.dart';
import 'wishlist_initial_params.dart';
import 'wishlist_state.dart';

class WishlistPage extends StatefulWidget {
  final WishlistCubit cubit;

  const WishlistPage({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<WishlistPage> createState() => _WishlistState();
}

class _WishlistState extends State<WishlistPage> {
  WishlistCubit get cubit => widget.cubit;

  @override
  void initState() {
    super.initState();
    cubit.navigator.context = context;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Center(
          child: Text("Wishlist"),
        )
    );
  }
}
