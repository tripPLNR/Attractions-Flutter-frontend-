import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:triplaner/util/alert/app_snackbar.dart';
import 'search_initial_params.dart';
import 'search_state.dart';
import 'search_navigator.dart';


class SearchCubit extends Cubit<SearchState> {
SearchNavigator navigator;
SearchInitialParams initialParams;
AppSnackBar snackBar;
SearchCubit({required this.navigator,required this.initialParams,required this.snackBar}) : super(SearchState.initial(initialParams:initialParams));

BuildContext get context => navigator.context;
}
