import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class CustomHorizontalDatePicker extends StatefulWidget {
  final Function(DateTime) onDateSelect;
  DateTime selectedDate;

  CustomHorizontalDatePicker({Key? key,required this.onDateSelect,required this.selectedDate}) : super(key: key);

  @override
  State<CustomHorizontalDatePicker> createState() =>
      _CustomHorizontalDatePickerState();
}

class _CustomHorizontalDatePickerState
    extends State<CustomHorizontalDatePicker> {
  List<DateTime> dates = [];
  ScrollController _scrollController = ScrollController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // Calculate the initial scroll offset based on the selected date's index
    int selectedIndex = dates.indexOf(widget.selectedDate);
    double initialScrollOffset = selectedIndex * (40.0 + 5.0); // Adjust as needed

    _scrollController = ScrollController(initialScrollOffset: initialScrollOffset);

  }

  _addDatesOfYear() {
    widget.selectedDate=DateTime(widget.selectedDate.year, widget.selectedDate.month, widget.selectedDate.day);
    if(dates.contains(widget.selectedDate))return;
    debugPrint("Adding dates to calendar...");
    dates=[];
    DateTime now = widget.selectedDate;
    for (int index = 0; index < 5; index++) {
      DateTime dateToAdd = now.add(Duration(days: index));
      DateTime onlyDate = DateTime(dateToAdd.year, dateToAdd.month, dateToAdd.day);
      dates.add(onlyDate);
    }
  }

  @override
  void didUpdateWidget(covariant CustomHorizontalDatePicker oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    _addDatesOfYear();
    _scrollToSelectedDate();
  }


  _scrollToSelectedDate() async {
    // debugPrint("scrolll now");
    // await Future.delayed(const Duration(milliseconds: 500));
    for (int index = 0; index < dates.length; index++){
      if(widget.selectedDate == dates[index]){
        _scrollController.animateTo(
          index * (40.0 + 5.0), // Adjust as needed
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    widget.selectedDate=DateTime(widget.selectedDate.year, widget.selectedDate.month, widget.selectedDate.day);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      controller: _scrollController,
      physics: const ClampingScrollPhysics(),
      child: Row(
        children: [
          for (int index = 0; index < dates.length; index++)
            GestureDetector(
              onTap: () {
                setState(() {
                  widget.selectedDate = dates[index];
                  widget.onDateSelect(dates[index]);
                });
              },
              child: Container(
                 height: 55.h,
                width: 55.h,
                margin: EdgeInsets.symmetric(horizontal: 5.w),
                padding: EdgeInsets.symmetric(vertical: 5.h),
                decoration: BoxDecoration(
                    color: widget.selectedDate== dates[index]
                        ? Theme.of(context).colorScheme.tertiary
                        : Theme.of(context)
                            .colorScheme
                            .tertiaryContainer
                            .withOpacity(0.05),
                    border: Border.all(
                      color: widget.selectedDate == dates[index]
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context)
                              .colorScheme
                              .tertiaryContainer
                              .withOpacity(0.1),
                    ),
                    borderRadius: BorderRadius.circular(6.r)),
                child: Column(
                  children: [
                    Text(
                      DateFormat('dd').format(dates[index]),
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18.sp,
                          color: widget.selectedDate == dates[index]
                              ? Theme.of(context).colorScheme.primary
                              : null),
                    ),
                    Text(
                      DateFormat('MMM').format(dates[index]),
                      style: TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 12.sp),
                    ),
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }
}
