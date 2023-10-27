import 'review_count.dart';

class Source {
  String? provider;
  int? totalCount;
  List<ReviewCount>? reviewCounts;
  double? averageRating;

  Source(
      {this.provider, this.totalCount, this.reviewCounts, this.averageRating});

  Source.fromJson(Map<String, dynamic> json) {
    provider = json['provider'];
    totalCount = json['totalCount'];
    if (json['reviewCounts'] != null) {
      reviewCounts = <ReviewCount>[];
      json['reviewCounts'].forEach((v) {
        reviewCounts!.add(new ReviewCount.fromJson(v));
      });
    }
    averageRating = json['averageRating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['provider'] = this.provider;
    data['totalCount'] = this.totalCount;
    if (this.reviewCounts != null) {
      data['reviewCounts'] = this.reviewCounts!.map((v) => v.toJson()).toList();
    }
    data['averageRating'] = this.averageRating;
    return data;
  }
}

