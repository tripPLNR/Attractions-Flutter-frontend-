class TopActivity {
  String? name;
  String? thumbnail;

  TopActivity({this.name, this.thumbnail});

  TopActivity.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    thumbnail = json['thumbnail'];
  }

  TopActivity.empty() {
    name = "Empty";
    thumbnail = "";
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['thumbnail'] = this.thumbnail;
    return data;
  }


}
