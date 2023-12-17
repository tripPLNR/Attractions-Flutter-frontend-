class ReviewRating {
  String? userName;
  String? review;
  double? rating;
  String? date;
  ReviewRating({this.userName, this.review, this.rating,this.date});

  ReviewRating.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    review = json['review'];
    rating = json['rating'];
    date = json['date'];

  }

  ReviewRating.empty() {
    userName ="Dummy username";
    review = "osué went above and beyond to ensure that we had a great experience. He made sure we were all comfortable during the night walk, he had rain gear and we were able to see some amazing frogs. The highlight of this experience is the dinner, hands down. We were able to eat as a family in a beautiful home. The hospitality and love that was shown will make this experience special";
    rating = 5;
    date="2023-04-09";
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['review'] = this.review;
    data['rating'] = this.rating;
    data['date'] = this.date;

    return data;
  }
}
