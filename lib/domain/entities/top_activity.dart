class TopActivity {
  String? id;
  String? name;
  String? thumbnail;
  String? destinationId;

  TopActivity({this.name, this.thumbnail,this.destinationId,this.id});

  TopActivity.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    thumbnail = json['thumbnail'];
    id = json['id'];
    destinationId = json['destinationId'];

  }

  TopActivity.empty() {
    name = "Empty";
    thumbnail = "";
    id=null;
    destinationId=null;
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['destinationId'] = this.destinationId;
    data['name'] = this.name;
    data['thumbnail'] = this.thumbnail;

    return data;
  }


}
