import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:triplaner/data/models/inclusion_json.dart';
import 'package:triplaner/data/models/location_json.dart';
import 'package:triplaner/data/models/product_review_json.dart';
import 'package:triplaner/data/models/varient_json.dart';
import 'package:triplaner/domain/entities/rating.dart';
import 'package:triplaner/domain/entities/site.dart';
import 'package:triplaner/domain/entities/duration.dart';
import 'package:triplaner/util/app_constant.dart';
import 'package:triplaner/util/app_extentions.dart';

import 'cancellation_policy_json.dart';
import 'duration_json.dart';
import 'image_json.dart';
import 'rating_json.dart';

class SiteJson  {
  int? id;
  String? productCode;
  String? provider;
  String? title;
  String? startDate;
  String? endDate;
  String? description;
  int? durationDays;
  int? durationHours;
  int? durationMinutes;
  double? latitude;
  double? longitude;
  String? productAddress;
  List<String>? image;
  List<String>? inclusion;
  List<String>? exclusion;
  String? productUrl;
  double? totalRating;
  int? totalReviews;
  String? cancellationPolicy;
  String? ageBand;
  String? destinationsId;
  String? price;
  String? currentCurrencyType;
  String? currentCurrencySymbol;

  List<ProductReviewJson>? productReviews;

  String? createdAt;
  String? updatedAt;

  SiteJson({
    this.id,
    this.productCode,
    this.provider,
    this.title,
    this.startDate,
    this.endDate,
    this.description,
    this.durationDays,
    this.durationHours,
    this.durationMinutes,
    this.latitude,
    this.longitude,
    this.productAddress,
    this.image,
    this.inclusion,
    this.exclusion,
    this.productUrl,
    this.totalRating,
    this.totalReviews,
    this.cancellationPolicy,
    this.ageBand,
    this.destinationsId,
    this.price,
    this.currentCurrencySymbol,
    this.currentCurrencyType,
    this.productReviews,
    this.createdAt,
    this.updatedAt,
  });

  SiteJson.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productCode = json['productCode'];
    provider = json['provider'];
    title = json['title'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    description = json['description'];
    durationDays = json['durationDays'];
    durationHours = json['durationHours'];
    durationMinutes = json['durationMinutes'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    productAddress = json['productAdress'];
    image = json['image']==null?[]:json['image'].cast<String>();
    inclusion = json['inclusion']==null?[]:json['inclusion'].cast<String>();
    exclusion = json['exclusion']==null?[]:json['exclusion'].cast<String>();
    productUrl = json['productUrl'];
    totalRating=_parseDouble(json['totalRating']);
    totalReviews = json['totalReviews'] ?? 0;
    cancellationPolicy = json['cancellationPolicy'];
    ageBand = json['ageBand'];
    cancellationPolicy = json['cancellationPolicy'];
    destinationsId = json['destinationsId'];
    productReviews = <ProductReviewJson>[];
    if (json['productReviews'] != null) {
      json['productReviews'].forEach((v) {
        productReviews!.add(ProductReviewJson.fromJson(v));
      });
    }
    price = json['price'];
    currentCurrencyType = json['currentCurrencyType'];
    currentCurrencySymbol = json['currentCurrencySymbol'];

    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  double _parseDouble(dynamic value) {
    if (value is int) {
      return value.toDouble();
    } else if (value is double) {
      return double.parse(value.toStringAsFixed(1));
    } else if (value is String) {
      return double.tryParse(value) ?? 0.0;
    } else {
      // If the value is null or of an unsupported type, return 0.0
      return 0.0;
    }
  }

  Site toDomain() {
    try {
      return Site(
          id: id.toString(),
          productCode: productCode ?? "N/A",
          provider: provider ?? "N/A",
          title: title ?? "N/A",
          startDate: startDate?.formatToDateTime()??"",
          endDate: endDate?.formatToDateTime()??"",
          description: description ?? "N/A",
          durationMinutes: durationMinutes??0,
          durationHours: durationHours??0,
          durationDays: durationDays??0,
          latitude: latitude,
          longitude: longitude,
          productAddress: productAddress??"N/A",
          images: image??[],
          coverImage: (image!.isNotEmpty)?(image?.first):AppConstant.placeHolderImage,
          inclusions: inclusion?? [],
          exclusions: exclusion?? [],
          productUrl: productUrl ?? "N/A",
          totalRating: totalRating??0.0,
          totalReviews: totalReviews??0,
          cancellationPolicy: cancellationPolicy??"",
          ageBand: ageBand ?? "\$",
          destinationsId: destinationsId ?? "",
          price: double.parse(price??"0").toStringAsFixed(0),
          currentCurrencySymbol: currentCurrencySymbol,
          currentCurrencyType: currentCurrencyType,
          productReviews: productReviews?.map((e) => e.toDomain()).toList()??[],
          createdAt: createdAt ?? "2023-10-20T23:23:37.687Z",
          updatedAt: updatedAt ?? "2023-10-20T23:23:37.687Z");
    } catch (e) {
      return Site.empty();
    }
  }

}
