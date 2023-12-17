class SearchLocation {
  String? cityName;
  String? id;
  String? createdAt;
  String? updatedAt;
  String? region;

  SearchLocation(
      {this.cityName, this.id, this.createdAt, this.updatedAt, this.region});

  SearchLocation.fromJson(Map<String, dynamic> json) {
    cityName = json['cityName'];
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    region = json['region'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cityName'] = this.cityName;
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['region'] = this.region;
    return data;
  }

  SearchLocation.empty() {
    cityName = "This is empty name,";
    id = "00000000";
    createdAt = "2023-11-03T08:52:01.986Z";
    updatedAt ="2023-11-03T08:52:01.986Z";
    region ="California";
  }
}
