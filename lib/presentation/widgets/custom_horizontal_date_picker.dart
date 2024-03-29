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


// import 'package:easy_date_timeline/easy_date_timeline.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:hive/hive.dart';
// import 'package:intl/intl.dart';
//
// class CustomHorizontalDatePicker extends StatefulWidget {
//   final Function(DateTime) onDateSelect;
//   final EasyInfiniteDateTimelineController controller;
//   DateTime selectedDate;
//
//   CustomHorizontalDatePicker({
//     Key? key,
//     required this.onDateSelect,
//     required this.selectedDate,
//     required this.controller,
//   }) : super(key: key);
//
//   @override
//   State<CustomHorizontalDatePicker> createState() =>
//       _CustomHorizontalDatePickerState();
// }
//
// class _CustomHorizontalDatePickerState
//     extends State<CustomHorizontalDatePicker> {
//   late DateTime selectedDate;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     setState(() {
//       selectedDate = widget.selectedDate;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     debugPrint("selected date : ${selectedDate.toString()}");
//
//     return EasyInfiniteDateTimeLine(
//       controller: widget.controller,
//       showTimelineHeader: false,
//       firstDate: DateTime.now(),
//       focusDate: widget.selectedDate,
//       lastDate: DateTime.now().add(Duration(days: 365)),
//       onDateChange: widget.onDateSelect,
//       disabledDates: [DateTime.now().add(const Duration(days: 2))],
//       dayProps: EasyDayProps(
//           height: 55.h,
//           width: 55.w,
//           dayStructure: DayStructure.dayNumDayStr,
//           activeDayStyle: DayStyle(
//             borderRadius: 10.r,
//             dayNumStyle:
//                 TextStyle(color: Theme.of(context).colorScheme.onPrimary),
//             monthStrStyle: TextStyle(
//                 color: Theme.of(context).colorScheme.onPrimary, fontSize: 0),
//             dayStrStyle:
//                 TextStyle(color: Theme.of(context).colorScheme.onPrimary),
//           ),
//           inactiveDayStyle: DayStyle(
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10.r),
//                   border: Border.all(
//                       color: Theme.of(context).colorScheme.primary,
//                       width: 1)))),
//     );
//     // return SingleChildScrollView(
//     //   scrollDirection: Axis.horizontal,
//     //   controller: _scrollController,
//     //   physics: const ClampingScrollPhysics(),
//     //   child: Row(
//     //     children: [
//     //       for (int index = 0; index < dates.length; index++)
//     //         GestureDetector(
//     //           onTap: () {
//     //             setState(() {
//     //               widget.selectedDate = dates[index];
//     //               widget.onDateSelect(dates[index]);
//     //             });
//     //           },
//     //           child: Container(
//     //              height: 55.h,
//     //             width: 55.h,
//     //             margin: EdgeInsets.symmetric(horizontal: 5.w),
//     //             padding: EdgeInsets.symmetric(vertical: 5.h),
//     //             decoration: BoxDecoration(
//     //                 color: widget.selectedDate== dates[index]
//     //                     ? Theme.of(context).colorScheme.tertiary
//     //                     : Theme.of(context)
//     //                         .colorScheme
//     //                         .tertiaryContainer
//     //                         .withOpacity(0.05),
//     //                 border: Border.all(
//     //                   color: widget.selectedDate == dates[index]
//     //                       ? Theme.of(context).colorScheme.primary
//     //                       : Theme.of(context)
//     //                           .colorScheme
//     //                           .tertiaryContainer
//     //                           .withOpacity(0.1),
//     //                 ),
//     //                 borderRadius: BorderRadius.circular(6.r)),
//     //             child: Column(
//     //               children: [
//     //                 Text(
//     //                   DateFormat('dd').format(dates[index]),
//     //                   style: TextStyle(
//     //                       fontWeight: FontWeight.w600,
//     //                       fontSize: 18.sp,
//     //                       color: widget.selectedDate == dates[index]
//     //                           ? Theme.of(context).colorScheme.primary
//     //                           : null),
//     //                 ),
//     //                 Text(
//     //                   DateFormat('MMM').format(dates[index]),
//     //                   style: TextStyle(
//     //                       fontWeight: FontWeight.w400, fontSize: 12.sp),
//     //                 ),
//     //               ],
//     //             ),
//     //           ),
//     //         )
//     //     ],
//     //   ),
//     // );
//   }
// }
