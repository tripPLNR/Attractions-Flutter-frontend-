import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'calendar_initial_params.dart';
import 'calendar_state.dart';
import 'calendar_navigator.dart';

class CalendarCubit extends Cubit<CalendarState> {
  CalendarNavigator navigator;
  CalendarInitialParams initialParams;

  CalendarCubit({required this.navigator, required this.initialParams})
      : super(CalendarState.initial(initialParams: initialParams));

  BuildContext get context => navigator.context;

  DateTime currentDate=DateTime.now();

  DateRangePickerController controller=DateRangePickerController();


  onInit(){
    if(initialParams.dateTime!=null){
      controller.selectedDate=initialParams.dateTime;
    }
  }

  void onDateChange(DateTime dateTime){
    currentDate=dateTime;
  }

  applyAction(){
    Navigator.pop(context);
    initialParams.onSelectDate(currentDate);
  }
  cancelAction(){
    Navigator.pop(context);
    initialParams.onClear();
  }
}
