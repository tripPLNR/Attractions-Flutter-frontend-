import 'package:triplaner/domain/entities/cancellation_policy.dart';

import 'refund_eligibility_json.dart';

class CancellationPolicyJson {
  String? type;
  String? description;
  List<RefundEligibilityJson>? refundEligibility;
  bool? cancelIfBadWeather;
  bool? cancelIfInsufficientTravelers;

  CancellationPolicyJson(
      {this.type,
        this.description,
        this.refundEligibility,
        this.cancelIfBadWeather,
        this.cancelIfInsufficientTravelers});

  CancellationPolicyJson.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    description = json['description'];
    if (json['refundEligibility'] != null) {
      refundEligibility = <RefundEligibilityJson>[];
      json['refundEligibility'].forEach((v) {
        refundEligibility!.add(new RefundEligibilityJson.fromJson(v));
      });
    }
    cancelIfBadWeather = json['cancelIfBadWeather'];
    cancelIfInsufficientTravelers = json['cancelIfInsufficientTravelers'];
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

  CancellationPolicy toDomain(){
    return CancellationPolicy(
      type: type??"N/A",
      description: description??"N/A",
      refundEligibility: refundEligibility?.map((e) => e.toDomain()).toList()??[],
      cancelIfBadWeather: cancelIfBadWeather,
      cancelIfInsufficientTravelers: cancelIfInsufficientTravelers
    );
  }
}