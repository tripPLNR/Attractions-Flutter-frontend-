
import 'package:triplaner/domain/entities/duration.dart';

class DurationJson {
  int? days;
  int? hours;
  int? minutes;

  DurationJson({this.days, this.hours, this.minutes});

  DurationJson.fromJson(Map<String, dynamic> json) {
    days = json['days'];
    hours = json['hours'];
    minutes = json['minutes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['days'] = this.days;
    data['hours'] = this.hours;
    data['minutes'] = this.minutes;
    return data;
  }

  Duration toDomain(){
    return Duration(
      days: days??0,
      hours: hours??0,
      minutes: minutes??0
    );
  }
}