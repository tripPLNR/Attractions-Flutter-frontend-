import 'package:triplaner/domain/entities/rating.dart';

class RatingJson {
  double? averageRatings;
  int? totalReviews;

  RatingJson({this.averageRatings, this.totalReviews});

  RatingJson.fromJson(Map<String, dynamic> json) {
    averageRatings = (json['averageRatings']??0).toDouble();
    totalReviews = json['totalReviews'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['averageRatings'] = averageRatings;
    data['totalReviews'] = totalReviews;
    return data;
  }

  Rating toDomain(){
    return Rating(
      ratings: double.parse((averageRatings??0.0).toStringAsFixed(1)),
      reviewersCount: totalReviews??0
    );
  }
}
