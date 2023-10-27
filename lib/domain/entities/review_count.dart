
class ReviewCount {
  int? count;
  int? rating;

  ReviewCount({this.count, this.rating});

  ReviewCount.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['rating'] = this.rating;
    return data;
  }
}
