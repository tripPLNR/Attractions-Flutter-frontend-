class RefundEligibility {
  int? dayRangeMin;
  int? percentageRefundable;
  int? dayRangeMax;

  RefundEligibility(
      {this.dayRangeMin, this.percentageRefundable, this.dayRangeMax});

  RefundEligibility.fromJson(Map<String, dynamic> json) {
    dayRangeMin = json['dayRangeMin'];
    percentageRefundable = json['percentageRefundable'];
    dayRangeMax = json['dayRangeMax'];
  }
 RefundEligibility.empty() {
    dayRangeMin = 0000;
    percentageRefundable = 0000;
    dayRangeMax = 0000;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dayRangeMin'] = this.dayRangeMin;
    data['percentageRefundable'] = this.percentageRefundable;
    data['dayRangeMax'] = this.dayRangeMax;
    return data;
  }
}
