import 'dart:ffi';

import 'package:flutter/cupertino.dart';

class CalendarInitialParams {
final Function(DateTime) onSelectDate;
final VoidCallback onClear;
final DateTime? dateTime;
const CalendarInitialParams({required this.onSelectDate,required this.onClear,this.dateTime});
}