import 'refund_eligibility.dart';

class CancellationPolicy {
  String? type;
  String? description;
  List<RefundEligibility>? refundEligibility;
  bool? cancelIfBadWeather;
  bool? cancelIfInsufficientTravelers;

  CancellationPolicy(
      {this.type,
        this.description,
        this.refundEligibility,
        this.cancelIfBadWeather,
        this.cancelIfInsufficientTravelers});

  CancellationPolicy.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    description = json['description'];
    if (json['refundEligibility'] != null) {
      refundEligibility = <RefundEligibility>[];
      json['refundEligibility'].forEach((v) {
        refundEligibility!.add(new RefundEligibility.fromJson(v));
      });
    }
    cancelIfBadWeather = json['cancelIfBadWeather'];
    cancelIfInsufficientTravelers = json['cancelIfInsufficientTravelers'];
  }

  CancellationPolicy.empty() {
    type = "000";
    description = "0000";
    refundEligibility=[RefundEligibility.empty()];
    cancelIfBadWeather = true;
    cancelIfInsufficientTravelers = true;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['description'] = this.description;
    if (this.refundEligibility != null) {
      data['refundEligibility'] =
          this.refundEligibility!.map((v) => v.toJson()).toList();
    }
    data['cancelIfBadWeather'] = this.cancelIfBadWeather;
    data['cancelIfInsufficientTravelers'] = this.cancelIfInsufficientTravelers;
    return data;
  }
}