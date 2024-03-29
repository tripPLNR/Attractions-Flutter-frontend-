import 'package:equatable/equatable.dart';
import 'package:triplaner/util/app_constant.dart';

class City extends Equatable{
  String? id;
  String? cityId;

  String? cityName;
  String? countryName;
  String? thumbnail;

  City(
      {this.id,
       this.cityId,
        this.cityName,
        this.countryName,
        this.thumbnail,
      });

  City.fromJson(Map<String, dynamic> json) {
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

  City.empty() {
    id = "0000";
    cityId="";
    cityName = "This city";
    countryName="Country";
    thumbnail =AppConstant.placeHolderImage;
  }


  @override
  List<Object?> get props => [
    id,
    cityId,
    cityName,
    thumbnail,
    countryName,
  ];
}
