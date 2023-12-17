import 'package:intl/intl.dart';
import 'package:triplaner/util/app_extentions.dart';

import '../../domain/entities/review_rating.dart';

class ReviewRatingJson {
  String? userName;
  String? review;
  int? rating;
  String? date;

  ReviewRatingJson({this.userName, this.review, this.rating});

  ReviewRatingJson.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    review = json['review'];
    rating = json['rating'];
    date = json['date'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['review'] = this.review;
    data['rating'] = this.rating;
    data['date'] = this.date;

    return data;
  }

  ReviewRating toDomain(){
    return ReviewRating(
      userName: userName??"N/A",
      review: review??"N/A",
      rating: (rating??0).toDouble(),
      date:DateTime.parse(date??"").toDayMonthNameAndYear(),
    );
  }
}
