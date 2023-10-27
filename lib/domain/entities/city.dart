import 'package:equatable/equatable.dart';

class City extends Equatable{
  String? id;
  String? name;
  String? thumbnail;
  String? cityId;
  String? createdAt;
  String? updatedAt;

  City(
      {this.id,
        this.name,
        this.thumbnail,
        this.cityId,
        this.createdAt,
        this.updatedAt});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    thumbnail = json['thumbnail'];
    cityId = json['cityId'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['thumbnail'] = this.thumbnail;
    data['cityId'] = this.cityId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }

  City.empty() {
    id = "0000";
    name = "This city";
    thumbnail ="https://t3.ftcdn.net/jpg/02/48/42/64/360_F_248426448_NVKLywWqArG2ADUxDq6QprtIzsF82dMF.jpg";
    cityId ="00000";
    createdAt = "000000";
    updatedAt = "0000000";
  }


  @override
  List<Object?> get props => [
    id,
    name,
    thumbnail,
    cityId,
    createdAt,
    updatedAt
  ];
}
