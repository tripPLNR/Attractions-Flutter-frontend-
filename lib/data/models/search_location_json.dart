import 'package:triplaner/domain/entities/search_location.dart';
import 'package:triplaner/util/app_extentions.dart';

class SearchLocationJson {
  int? id;
  String? name;
  SearchLocationJson(
      {this.name, this.id,});

  SearchLocationJson.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }


  SearchLocation toDomain(){
    return SearchLocation(
      id: id.toString(),
      name: name.toString().capitalizeFirstLetters(),
    );
  }
}
