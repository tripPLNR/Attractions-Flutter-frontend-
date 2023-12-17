import 'package:triplaner/domain/entities/search_location.dart';

class SearchLocationJson {
  String? cityName;
  String? id;
  String? createdAt;
  String? updatedAt;
  String? region;

  SearchLocationJson(
      {this.cityName, this.id, this.createdAt, this.updatedAt, this.region});

  SearchLocationJson.fromJson(Map<String, dynamic> json) {
    cityName = json['cityName'];
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    region = json['region'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cityName'] = this.cityName;
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['region'] = this.region;
    return data;
  }


  SearchLocation toDomain(){
    return SearchLocation(
      cityName: cityName??"N/A",
      id: id??"N/A",
      createdAt: createdAt??"N/A",
      updatedAt: updatedAt??"N/A",
      region: region??"N/A"
    );
  }
}
