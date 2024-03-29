import 'package:equatable/equatable.dart';
import 'package:triplaner/domain/entities/location.dart';
import 'package:triplaner/util/app_constant.dart';

import 'cancellation_policy.dart';
import 'inclusion.dart';
import 'image.dart';
import 'product_review.dart';
import 'rating.dart';
import 'duration.dart';
import 'variant.dart';

class Site extends Equatable {
  String? id;
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
  String? coverImage;
  List<String>? images;
  List<String>? inclusions;
  List<String>? exclusions;
  String? productUrl;
  double? totalRating;
  int? totalReviews;
  String? cancellationPolicy;
  String? ageBand;
  String? destinationsId;
  List<ProductReview>? productReviews;
  String? price;
  String? currentCurrencyType;
  String? currentCurrencySymbol;
  String? createdAt;
  String? updatedAt;

  Site({
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
    this.images,
    this.coverImage,
    this.inclusions,
    this.exclusions,
    this.productUrl,
    this.totalRating,
    this.totalReviews,
    this.cancellationPolicy,
    this.ageBand,
    this.destinationsId,
    this.price,
    this.currentCurrencyType,
    this.currentCurrencySymbol,
    this.productReviews,
    this.createdAt,
    this.updatedAt,
  });

  Site.fromJson(Map<String, dynamic> json) {
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
    productAddress = json['productAddress'];
    images = json['image'] == null ? [] : json['image'].cast<String>();
    inclusions =
        json['inclusions'] == null ? [] : json['inclusions'].cast<String>();
    exclusions =
        json['exclusions'] == null ? [] : json['exclusions'].cast<String>();
    productUrl = json['productUrl'];
    totalRating = _parseDouble(json['totalRating']);
    totalReviews = json['totalReviews'] ?? 0;
    cancellationPolicy = json['cancellationPolicy'];
    ageBand = json['ageBand'];
    cancellationPolicy = json['cancellationPolicy'];
    destinationsId = json['destinationsId'];
    if (json['productReviews'] != null) {
      productReviews = <ProductReview>[];
      json['productReviews'].forEach((v) {
        productReviews!.add(ProductReview.fromJson(v));
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
      return value;
    } else if (value is String) {
      return double.tryParse(value) ?? 0.0;
    } else {
      // If the value is null or of an unsupported type, return 0.0
      return 0.0;
    }
  }

  Site.empty() {
    id = "00000";
    productCode = "00000";
    provider = "00000";
    title = "00000";
    description = "00000 00000 00000 00000";
    durationMinutes = 0;
    durationHours = 0;
    durationDays = 0;
    latitude = 0;
    longitude = 0;
    productAddress = "This is dummy address";
    images = [
      AppConstant.placeHolderImage,
      AppConstant.placeHolderImage,
    ];
    inclusions = ["This is empty", "This is empty", "This is empty"];
    exclusions = ["This is empty", "This is empty", "This is empty"];
    productUrl = "";
    totalRating = 5.0;
    totalReviews = 100;
    cancellationPolicy = "";
    productReviews = List.generate(5, (index) => ProductReview.empty());
    price = "100";
    currentCurrencyType = 'USD';
    currentCurrencySymbol = "\$";
    createdAt = "2023-10-19T11:11:22.298";
    updatedAt = "2023-10-19T11:11:22.298";
    coverImage = AppConstant.placeHolderImage;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        productCode,
        provider,
        title,
        startDate,
        endDate,
        description,
        durationDays,
        durationHours,
        durationMinutes,
        latitude,
        longitude,
        productAddress,
        images,
        inclusions,
        exclusions,
        productUrl,
        totalRating,
        totalReviews,
        cancellationPolicy,
        ageBand,
        destinationsId,
        productReviews,
        price,
        currentCurrencyType,
        currentCurrencySymbol,
        createdAt,
        updatedAt,
      ];

  bool isRefundAvailable() {
    return cancellationPolicy?.contains("full refund") ?? false;
  }
}
