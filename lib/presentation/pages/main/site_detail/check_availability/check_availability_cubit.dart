import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'check_availability_initial_params.dart';
import 'check_availability_state.dart';
import 'check_availability_navigator.dart';

class CheckAvailabilityCubit extends Cubit<CheckAvailabilityState> {
  CheckAvailabilityNavigator navigator;
  CheckAvailabilityInitialParams initialParams;

  CheckAvailabilityCubit({required this.navigator, required this.initialParams})
      : super(CheckAvailabilityState.initial(initialParams: initialParams));

  BuildContext get context => navigator.context;

  onAdultIncrement(){
    int newValue=state.adultCount+1;
    emit(state.copyWith(adultCount: newValue));
  }
  onChildrenIncrement(){
    int newValue=state.childrenCount+1;
    emit(state.copyWith(childrenCount: newValue));
  }
  onAdultDecrement(){
    int newValue=state.adultCount-1;
    if(newValue<0)return;
    emit(state.copyWith(adultCount: newValue));
  }
  onChildrenDecrement(){
    int newValue=state.childrenCount-1;
    if(newValue<0)return;
    emit(state.copyWith(childrenCount: newValue));
  }


}
