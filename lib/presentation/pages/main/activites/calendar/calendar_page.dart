import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:triplaner/presentation/widgets/custom_button.dart';
import 'package:triplaner/util/app_constant.dart';
import 'calendar_cubit.dart';
import 'calendar_initial_params.dart';
import 'calendar_state.dart';

class CalendarPage extends StatefulWidget {
  final CalendarCubit cubit;

  const CalendarPage({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarState();
}

class _CalendarState extends State<CalendarPage> {
  CalendarCubit get cubit => widget.cubit;

  @override
  void initState() {
    super.initState();
    cubit.navigator.context = context;
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    cubit.onInit();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: AppConstant.screenPadding.copyWith(top: 20.h, bottom: 50.h),
        child: Stack(
          children: [
            SfDateRangePicker(
              showActionButtons: true,
              showNavigationArrow: true,
              enablePastDates: false,
              controller: cubit.controller,
              viewSpacing: 0,
              headerHeight: 50.h,
              headerStyle: DateRangePickerHeaderStyle(
                textStyle: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0),
              ),
              cancelText: "",
              confirmText: "",
              selectionTextStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.primary),
              selectionColor:
                  Theme.of(context).colorScheme.primary.withOpacity(0.2),
              onSubmit: null,
              onCancel: null,
              onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                final dynamic value = args.value;
                cubit.onDateChange(value);
              },
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomButton(
                      text: "CLEAR",
                      action: cubit.cancelAction,
                      isSecondaryButton: true,
                      width: 167.h,
                      height: 50.h,
                    ),
                    CustomButton(
                      text: "APPLY",
                      action: cubit.applyAction,
                      width: 167.h,
                      height: 50.h,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
