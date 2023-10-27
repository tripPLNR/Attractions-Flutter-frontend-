import 'package:triplaner/domain/entities/rating.dart';

class RatingJson {
  double? ratings;
  int? reviewersCount;

  RatingJson({this.ratings, this.reviewersCount});

  RatingJson.fromJson(Map<String, dynamic> json) {
    ratings = json['ratings'];
    reviewersCount = json['ReviewersCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ratings'] = this.ratings;
    data['ReviewersCount'] = this.reviewersCount;
    return data;
  }

  Rating toDomain(){
    return Rating(
      ratings: ratings??0.0,
      reviewersCount: reviewersCount??0
    );
  }
}
