import 'package:equatable/equatable.dart';
import 'package:triplaner/domain/entities/location.dart';

import 'cancellation_policy.dart';
import 'inclusion.dart';
import 'image.dart';
import 'rating.dart';
import 'duration.dart';
import 'variant.dart';

class Site extends Equatable {
  String? id;
  String? productCode;
  String? provider;
  String? title;
  String? description;
  int? basePrice;
  String? currency;
  Duration? duration;
  Location? location;
  List<Image>? images;
  List<Inclusion>? inclusions;
  List<Inclusion>? exclusions;
  String? productUrl;
  Rating? ratings;
  CancellationPolicy? cancellationPolicy;
  String? createdAt;
  String? updatedAt;

  Site(
      {this.id,
      this.productCode,
      this.provider,
      this.title,
      this.description,
      this.basePrice,
      this.currency,
      this.duration,
      this.location,
      this.images,
      this.inclusions,
      this.exclusions,
      this.productUrl,
      this.ratings,
      this.cancellationPolicy,
      this.createdAt,
      this.updatedAt});

  Site.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productCode = json['productCode'];
    provider = json['provider'];
    title = json['title'];
    description = json['description'];
    basePrice = json['basePrice'];
    currency = json['currency'];
    duration = json['duration'] != null
        ? new Duration.fromJson(json['duration'])
        : null;
    location =
        json['location'] != null ? Location.fromJson(json['duration']) : null;

    if (json['images'] != null) {
      images = <Image>[];
      json['images'].forEach((v) {
        images!.add(new Image.fromJson(v));
      });
    }
    if (json['inclusions'] != null) {
      inclusions = <Inclusion>[];
      json['inclusions'].forEach((v) {
        inclusions!.add(new Inclusion.fromJson(v));
      });
    }
    if (json['exclusions'] != null) {
      exclusions = <Inclusion>[];
      json['exclusions'].forEach((v) {
        exclusions!.add(new Inclusion.fromJson(v));
      });
    }
    productUrl = json['productUrl'];
    ratings =
        json['ratings'] != null ? new Rating.fromJson(json['ratings']) : null;
    cancellationPolicy = json['cancellationPolicy'] != null
        ? new CancellationPolicy.fromJson(json['cancellationPolicy'])
        : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Site.empty() {
    id = "00000";
    productCode = "00000";
    provider = "00000";
    title = "00000";
    description = "00000";
    basePrice = 0;
    currency = "00000";
    duration = Duration.empty();
    location = Location.empty();
    images = <Image>[Image.empty()];
    inclusions = <Inclusion>[Inclusion.empty()];
    exclusions = <Inclusion>[Inclusion.empty()];
    productUrl = "000";
    ratings = Rating.empty();
    cancellationPolicy = CancellationPolicy.empty();
    createdAt = "2023-10-19T11:11:22.298";
    updatedAt = "2023-10-19T11:11:22.298";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['productCode'] = this.productCode;
    data['provider'] = this.provider;
    data['title'] = this.title;
    data['description'] = this.description;
    data['basePrice'] = this.basePrice;
    data['currency'] = this.currency;
    if (this.duration != null) {
      data['duration'] = this.duration!.toJson();
    }
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    if (this.inclusions != null) {
      data['inclusions'] = this.inclusions!.map((v) => v.toJson()).toList();
    }
    if (this.exclusions != null) {
      data['exclusions'] = this.exclusions!.map((v) => v.toJson()).toList();
    }
    data['productUrl'] = this.productUrl;
    if (this.ratings != null) {
      data['ratings'] = this.ratings!.toJson();
    }
    if (this.cancellationPolicy != null) {
      data['cancellationPolicy'] = this.cancellationPolicy!.toJson();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        productCode,
        provider,
        title,
        description,
        basePrice,
        currency,
        // duration,
        // location,
        // images,
        // inclusions,
        // exclusions,
        // ratings,
        // cancellationPolicy,
        // createdAt,
        // updatedAt,
      ];

  bool isRefundAvailable(){
    return cancellationPolicy?.description?.contains("full refund")??false;
  }
}
