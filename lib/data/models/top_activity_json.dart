import 'package:triplaner/domain/entities/top_activity.dart';

class TopActivityJson {
  String? name;
  String? thumbnail;

  TopActivityJson({this.name, this.thumbnail});

  TopActivityJson.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['thumbnail'] = this.thumbnail;
    return data;
  }

  TopActivity toDomain(){
    return TopActivity(
      name: name,
      thumbnail: thumbnail
    );
  }
}
