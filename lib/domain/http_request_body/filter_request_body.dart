class FilterRequestBody {
  String? take;
  String? skip;
  String? tag;
  String? minPrice;
  String? maxPrice;
  String? ratingSort;
  String? duration;
  String? locationId;
  String? latitude;
  String? longitude;

  FilterRequestBody(
      {this.take,
        this.skip,
        this.tag,
        this.minPrice,
        this.maxPrice,
        this.ratingSort,
        this.duration,
        this.locationId,
        this.latitude,
        this.longitude});

  FilterRequestBody.fromJson(Map<String, dynamic> json) {
    take = json['take'];
    skip = json['skip'];
    tag = json['tag'];
    minPrice = json['minPrice'];
    maxPrice = json['maxPrice'];
    ratingSort = json['rating_sort'];
    duration = json['duration'];
    locationId = json['location_id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['take'] = this.take;
    data['skip'] = this.skip;
    data['tag'] = this.tag;
    data['minPrice'] = this.minPrice;
    data['maxPrice'] = this.maxPrice;
    data['rating_sort'] = this.ratingSort;
    data['duration'] = this.duration;
    data['location_id'] = this.locationId;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}
