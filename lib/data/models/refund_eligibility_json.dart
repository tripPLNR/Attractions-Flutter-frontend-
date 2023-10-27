import 'package:triplaner/domain/entities/refund_eligibility.dart';

class RefundEligibilityJson {
  int? dayRangeMin;
  int? percentageRefundable;
  int? dayRangeMax;

  RefundEligibilityJson(
      {this.dayRangeMin, this.percentageRefundable, this.dayRangeMax});

  RefundEligibilityJson.fromJson(Map<String, dynamic> json) {
    dayRangeMin = json['dayRangeMin'];
    percentageRefundable = json['percentageRefundable'];
    dayRangeMax = json['dayRangeMax'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dayRangeMin'] = this.dayRangeMin;
    data['percentageRefundable'] = this.percentageRefundable;
    data['dayRangeMax'] = this.dayRangeMax;
    return data;
  }

  RefundEligibility toDomain(){
    return RefundEligibility(
      dayRangeMax: dayRangeMax??0,
      dayRangeMin: dayRangeMin??0,
      percentageRefundable: percentageRefundable??0
    );
  }
}