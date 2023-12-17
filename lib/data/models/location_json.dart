import 'package:triplaner/domain/entities/location.dart';

class LocationJson {
  double? longitude;
  double? latitude;

  LocationJson({this.longitude, this.latitude});

  LocationJson.fromJson(Map<String, dynamic> json) {
    longitude = json['longitude'];
    latitude = json['latitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    return data;
  }

  Location toDomain(){
    return Location(
      longitude: longitude??0,
      latitude: latitude??0,
    );
  }
}
