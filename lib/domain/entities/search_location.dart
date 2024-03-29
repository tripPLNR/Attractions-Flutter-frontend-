class SearchLocation {
  String? id;
  String? name;

  SearchLocation(
      {this.name, this.id,});

  SearchLocation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }

  SearchLocation.empty() {
    id = "00000000";
    name = "Empty name";
  }
}
