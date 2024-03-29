import 'package:triplaner/domain/entities/top_activity.dart';

class TopActivityJson {
  int? id;
  String? name;
  String? thumbnail;
  int? destinationId;


  TopActivityJson({this.name, this.thumbnail,this.id,this.destinationId,});

  TopActivityJson.fromJson(Map<String, dynamic> json) {
    name = json['name']??json['activityName'];
    thumbnail = json['thumbnail'];
    id = json['id'];
    destinationId = json['destinationId'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['thumbnail'] = this.thumbnail;
    data['id'] = this.thumbnail;
    data['destinationId'] = this.destinationId;
    return data;
  }

  TopActivity toDomain(){
    return TopActivity(
      id:id.toString(),
      destinationId:destinationId.toString(),
      name: name,
      thumbnail: thumbnail,
    );
  }
}
