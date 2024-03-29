class ProductReview {
  double? rating;
  String? comment;
  String? provider;
  String? userName;
  String? publishedDate;

  ProductReview(
      {this.rating,
        this.comment,
        this.provider,
        this.userName,
        this.publishedDate});

  ProductReview.fromJson(Map<String, dynamic> json) {
    rating = json['rating'];
    comment = json['comment'];
    provider = json['provider'];
    userName = json['userName'];
    publishedDate = json['publishedDate'];
  }

  ProductReview.empty() {
    rating = 5.0;
    comment = "This is empty comment. This is empty comment. This is empty comment.";
    provider = "empty";
    userName = "Empty user";
    publishedDate = "28-10-1099";
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
}
