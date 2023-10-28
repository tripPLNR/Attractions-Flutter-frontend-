import 'package:triplaner/domain/entities/city.dart';

class CityJson {
  String? id;
  String? name;
  String? country;
  String? thumbnail;
  String? cityId;
  String? createdAt;
  String? updatedAt;

  CityJson(
      {this.id,
        this.name,
        this.thumbnail,
        this.country,
        this.cityId,
        this.createdAt,
        this.updatedAt});

  CityJson.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    country = json['country'];
    thumbnail = json['thumbnail'];
    cityId = json['cityId'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['country'] = this.country;
    data['thumbnail'] = this.thumbnail;
    data['cityId'] = this.cityId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
  City toDomain(){
    return City(
      id: id,
      name: name??"N/A",
      thumbnail: thumbnail,
      cityId: cityId,
      createdAt: createdAt,
      updatedAt: updatedAt,
      country: country??"N/A"
    );
  }
}
