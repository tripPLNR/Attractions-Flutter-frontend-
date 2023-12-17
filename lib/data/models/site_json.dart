import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:triplaner/data/models/inclusion_json.dart';
import 'package:triplaner/data/models/location_json.dart';
import 'package:triplaner/data/models/varient_json.dart';
import 'package:triplaner/domain/entities/site.dart';

import 'cancellation_policy_json.dart';
import 'duration_json.dart';
import 'image_json.dart';
import 'rating_json.dart';

class SiteJson extends Equatable {
  String? id;
  String? productCode;
  String? provider;
  String? title;
  String? description;
  String? basePrice;
  String? currency;
  DurationJson? duration;
  LocationJson? location;
  List<ImageJson>? images;
  List<InclusionJson>? inclusions;
  List<InclusionJson>? exclusions;
  String? productUrl;
  RatingJson? ratings;
  CancellationPolicyJson? cancellationPolicy;
  String? createdAt;
  String? updatedAt;

  SiteJson(
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

  SiteJson.fromJson(Map<String, dynamic> json) {
      id = json['id'];
      productCode = json['productCode'];
      provider = json['provider'];
      title = json['title'];
      description = json['description'];
      basePrice = json['basePrice'];
      currency = json['currency'];
      duration = json['duration'] != null
          ? DurationJson.fromJson(json['duration'])
          : null;
      if (json['images'] != null) {
        images = <ImageJson>[];
        json['images'].forEach((v) {
          images!.add(new ImageJson.fromJson(v));
        });
      }
      try {
      if (json['inclusions'] != null) {
        inclusions = <InclusionJson>[];
        json['inclusions'].forEach((v) {
          inclusions!.add(new InclusionJson.fromJson(v));
        });
      }
      if (json['exclusions'] != null) {
        exclusions = <InclusionJson>[];
        json['exclusions'].forEach((v) {
          exclusions!.add(new InclusionJson.fromJson(v));
        });
      }
      }
      catch(e){
        debugPrint("something wrong in inclsion exclusion..... ${e.toString()}");
      }
      productUrl = json['productUrl'];
      try {
      ratings = json['ratings'] != null
          ? RatingJson.fromJson(json['ratings'])
          : null;
      }catch(e){
        debugPrint("something wrong in ratings..... ${e.toString()}");
      }
      location = json['location'] != null
          ? LocationJson.fromJson(json['location'])
          : null;

      cancellationPolicy = json['cancellationPolicy'] != null
          ? CancellationPolicyJson.fromJson(json['cancellationPolicy'])
          : null;
      createdAt = json['created_at'];
      updatedAt = json['updated_at'];

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

  Site toDomain() {
    try {
      return Site(
          id: id ?? "",
          productCode: productCode ?? "N/A",
          provider: provider ?? "N/A",
          title: title ?? "N/A",
          description: description ?? "N/A",
          basePrice: double.parse(basePrice ?? "0").toInt(),
          currency: currency ?? "N/A",
          duration: duration?.toDomain(),
          location: location?.toDomain(),
          images: images?.map((e) => e.toDomain()).toList() ?? [],
          inclusions: inclusions?.map((e) => e.toDomain()).toList() ?? [],
          exclusions: exclusions?.map((e) => e.toDomain()).toList() ?? [],
          productUrl: productUrl ?? "N/A",
          ratings: ratings?.toDomain(),
          cancellationPolicy: cancellationPolicy?.toDomain(),
          createdAt: createdAt ?? "2023-10-20T23:23:37.687Z",
          updatedAt: updatedAt ?? "2023-10-20T23:23:37.687Z");
    }catch(e){
      return Site.empty();
    }
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
        duration,
        location,
        images,
        inclusions,
        exclusions,
        productUrl,
        ratings,
        cancellationPolicy,
        createdAt,
        updatedAt,
      ];
}
