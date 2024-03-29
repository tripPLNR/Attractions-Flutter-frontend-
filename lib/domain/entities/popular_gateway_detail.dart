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
        activities!.add(TopActivity.fromJson(v));
      });
    }
    if (json['attractions'] != null) {
      attractions = <Attraction>[];
      json['attractions'].forEach((v) {
        attractions!.add(Attraction.fromJson(v));
      });
    }
  }


  PopularGatewayDetail.empty() {
    activities = <TopActivity>[];
    attractions = <Attraction>[];
  }
}

