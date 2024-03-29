import 'package:triplaner/data/models/site_json.dart';
import 'package:triplaner/domain/entities/attraction.dart';
import 'package:triplaner/domain/entities/site.dart';

class AttractionJson {
  String? name;
  List<SiteJson>? sites;

  AttractionJson({this.name, this.sites});

  AttractionJson.fromJson(Map<String, dynamic> json) {
    name = json['name']??json['attractionName'];
    if (json['data'] != null) {
      sites = <SiteJson>[];
      json['data'].forEach((v) {
        sites!.add(SiteJson.fromJson(v));
      });
    }
  }

  Attraction toDomain(){
    return Attraction(
      name: name,
      sites: sites?.map((e) => e.toDomain()).toList()??[]
    );
  }
}