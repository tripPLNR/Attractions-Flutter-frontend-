
import 'package:triplaner/domain/entities/site.dart';
class Attraction {
  String? name;
  List<Site>? sites;

  Attraction({this.name, this.sites});

  Attraction.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['data'] != null) {
      sites = <Site>[];
      json['data'].forEach((v) {
        sites!.add(new Site.fromJson(v));
      });
    }
  }

  Attraction.empty() {
    name = "This is empty";
    sites=[];
  }

}