class Duration {
  int? days;
  int? hours;
  int? minutes;

  Duration({this.days, this.hours, this.minutes});

  Duration.fromJson(Map<String, dynamic> json) {
    days = json['days'];
    hours = json['hours'];
    minutes = json['minutes'];
  }
  Duration.empty() {
    days = 00;
    hours = 00;
    minutes = 00;
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['days'] = this.days;
    data['hours'] = this.hours;
    data['minutes'] = this.minutes;
    return data;
  }
}
