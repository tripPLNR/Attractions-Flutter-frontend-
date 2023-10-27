import 'package:triplaner/domain/entities/source.dart';

import 'review_count_json.dart';

class SourceJson {
  String? provider;
  int? totalCount;
  List<ReviewCountJson>? reviewCounts;
  double? averageRating;

  SourceJson(
      {this.provider, this.totalCount, this.reviewCounts, this.averageRating});

  SourceJson.fromJson(Map<String, dynamic> json) {
    provider = json['provider'];
    totalCount = json['totalCount'];
    if (json['reviewCounts'] != null) {
      reviewCounts = <ReviewCountJson>[];
      json['reviewCounts'].forEach((v) {
        reviewCounts!.add(new ReviewCountJson.fromJson(v));
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

  Source toDomain(){
    return Source(
      provider: provider??"N/A",
      totalCount: totalCount??0,
      reviewCounts:reviewCounts?.map((e) => e.toDomain()).toList()??[],
      averageRating:averageRating??0,
    );
  }
}
