import 'package:triplaner/domain/entities/product_review.dart';
import 'package:triplaner/util/app_extentions.dart';

class ProductReviewJson {
  double? rating;
  String? comment;
  String? provider;
  String? userName;
  String? publishedDate;

  ProductReviewJson(
      {this.rating,
        this.comment,
        this.provider,
        this.userName,
        this.publishedDate});

  ProductReviewJson.fromJson(Map<String, dynamic> json) {
    rating = _parseDouble(json['rating']);
    comment = json['comment'];
    provider = json['provider'];
    userName = json['userName'];
    publishedDate = json['publishedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rating'] = this.rating;
    data['comment'] = this.comment;
    data['provider'] = this.provider;
    data['userName'] = this.userName;
    data['publishedDate'] = this.publishedDate;
    return data;
  }

  ProductReview toDomain(){
    return ProductReview(
      rating: rating??0,
      comment: comment??"N/A",
      provider: provider??"",
      userName: userName??"",
      publishedDate: publishedDate.toString().formatToDate()
    );
  }

  double _parseDouble(dynamic value) {
    if (value is int) {
      return value.toDouble();
    } else if (value is double) {
      return value;
    } else if (value is String) {
      return double.tryParse(value) ?? 0.0;
    } else {
      // If the value is null or of an unsupported type, return 0.0
      return 0.0;
    }
  }
}
