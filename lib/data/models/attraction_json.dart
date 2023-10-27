import 'package:triplaner/data/models/site_json.dart';
import 'package:triplaner/domain/entities/attraction.dart';
import 'package:triplaner/domain/entities/site.dart';

class AttractionJson {
  String? name;
  List<SiteJson>? sites;

  AttractionJson({this.name, this.sites});

  AttractionJson.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['data'] != null) {
      sites = <SiteJson>[];
      json['data'].forEach((v) {
        sites!.add(SiteJson.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.sites != null) {
      data['data'] = this.sites!.map((v) => v.toJson()).toList();
    }
    return data;
  }
  Attraction toDomain(){
    return Attraction(
      name: name,
      sites: sites?.map((e) => e.toDomain()).toList()??[]
    );
  }
}