import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'search_cubit.dart';
import 'search_initial_params.dart';
import 'search_state.dart';

class SearchPage extends StatefulWidget {
  final SearchCubit cubit;

  const SearchPage({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchState();
}

class _SearchState extends State<SearchPage> {
  SearchCubit get cubit => widget.cubit;

  @override
  void initState() {
    super.initState();
    cubit.navigator.context = context;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: Text("Search"),
      )
    );
  }
}
