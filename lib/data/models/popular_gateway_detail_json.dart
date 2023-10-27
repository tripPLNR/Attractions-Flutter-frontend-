import 'package:triplaner/data/models/top_activity_json.dart';
import 'package:triplaner/domain/entities/popular_gateway_detail.dart';

import 'attraction_json.dart';

class PopularGatewayDetailJson {
  List<TopActivityJson>? activities;
  List<AttractionJson>? attractions;

  PopularGatewayDetailJson({this.activities, this.attractions});

  PopularGatewayDetailJson.fromJson(Map<String, dynamic> json) {
    if (json['activities'] != null) {
      activities = <TopActivityJson>[];
      json['activities'].forEach((v) {
        activities!.add(TopActivityJson.fromJson(v));
      });
    }
    if (json['attractions'] != null) {
      attractions = <AttractionJson>[];
      json['attractions'].forEach((v) {
        attractions!.add(AttractionJson.fromJson(v));
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

  PopularGatewayDetail toDomain(){
    return PopularGatewayDetail(
      activities: activities?.map((e) => e.toDomain()).toList()??[],
      attractions: attractions?.map((e) => e.toDomain()).toList()??[]
    );
  }
}

