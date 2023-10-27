import 'attraction.dart';
import 'top_activity.dart';


class PopularGatewayDetail {
  List<TopActivity>? activities;
  List<Attraction>? attractions;

  PopularGatewayDetail({this.activities, this.attractions});

  PopularGatewayDetail.fromJson(Map<String, dynamic> json) {
    if (json['activities'] != null) {
      activities = <TopActivity>[];
      json['activities'].forEach((v) {
        activities!.add(new TopActivity.fromJson(v));
      });
    }
    if (json['attractions'] != null) {
      attractions = <Attraction>[];
      json['attractions'].forEach((v) {
        attractions!.add(new Attraction.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.activities != null) {
      data['activities'] = this.activities!.map((v) => v.toJson()).toList();
    }
    if (this.attractions != null) {
      data['attractions'] = this.attractions!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  PopularGatewayDetail.empty() {
    activities = <TopActivity>[];
    attractions = <Attraction>[];
  }
}

