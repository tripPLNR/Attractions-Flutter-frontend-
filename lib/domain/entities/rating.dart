class Rating {
  double? ratings;
  int? reviewersCount;

  Rating({this.ratings, this.reviewersCount});

  Rating.fromJson(Map<String, dynamic> json) {
    ratings = json['ratings'];
    reviewersCount = json['ReviewersCount'];
  }

  Rating.empty() {
    ratings = 5;
    reviewersCount = 1234;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ratings'] = this.ratings;
    data['ReviewersCount'] = this.reviewersCount;
    return data;
  }
}
