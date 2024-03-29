import 'package:triplaner/domain/entities/city.dart';

class CityJson {
  int? id;
  int? cityId;
  String? cityName;
  String? countryName;
  String? thumbnail;

  CityJson(
      {this.id,
       this.cityId,

        this.cityName,
        this.countryName,
        this.thumbnail,
      });

  CityJson.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cityId = json['cityId'];
    cityName = json['cityName'];
    countryName = json['countryName'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cityId'] = this.cityId;
    data['cityName'] = this.cityName;
    data['countryName'] = this.countryName;
    data['thumbnail'] = this.thumbnail;
    return data;
  }
  City toDomain(){
    return City(
      id: id.toString(),
      cityId: cityId.toString(),
      cityName: cityName??"N/A",
      thumbnail: thumbnail,
      countryName: countryName??"N/A",
    );
  }
}
