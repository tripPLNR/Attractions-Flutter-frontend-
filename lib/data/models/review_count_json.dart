import 'package:triplaner/domain/entities/review_count.dart';

class ReviewCountJson {
  int? count;
  int? rating;

  ReviewCountJson({this.count, this.rating});

  ReviewCountJson.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['rating'] = this.rating;
    return data;
  }

  ReviewCount toDomain(){
    return ReviewCount(
      count: count??0,
      rating: rating??0
    );
  }
}