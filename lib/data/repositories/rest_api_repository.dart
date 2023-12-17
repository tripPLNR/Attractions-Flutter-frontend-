import 'package:intl/intl.dart';
import 'package:triplaner/data/models/city_json.dart';
import 'package:triplaner/data/models/popular_gateway_detail_json.dart';
import 'package:triplaner/data/models/search_suggestion_json.dart';
import 'package:triplaner/data/models/site_json.dart';
import 'package:triplaner/data/models/top_activity_json.dart';
import 'package:triplaner/domain/entities/city.dart';
import 'package:triplaner/domain/entities/popular_gateway_detail.dart';
import 'package:triplaner/domain/entities/review_rating.dart';
import 'package:triplaner/domain/entities/search_suggestion.dart';
import 'package:triplaner/domain/entities/site.dart';
import 'package:triplaner/domain/entities/top_activity.dart';
import 'package:triplaner/domain/repositories/database_repository.dart';
import 'package:triplaner/network/api_endpoint.dart';
import 'package:triplaner/network/network_repository.dart';

import '../models/review_rating_json.dart';

class RestAPIRepository implements DatabaseRepository {
  NetworkRepository networkRepository;

  RestAPIRepository({required this.networkRepository});

  @override
  Future<List<City>> getPopularGateways() async {
    var response = await networkRepository.get(APIEndpoint.getPopularGateways);
    return (response as List)
        .map((e) => CityJson.fromJson(e).toDomain())
        .toList();
  }

  @override
  Future<List<Site>> getUncoverMore(
      {required City city, int take = 10, int skip = 0}) async {
    var response = await networkRepository.get(APIEndpoint.getUncoverMore,
        parameters: {
          "gatewayId": city.id,
          "take": take.toString(),
          "skip": skip.toString()
        });
    return (response as List)
        .map((e) => SiteJson.fromJson(e).toDomain())
        .toList();
  }

  @override
  Future<List<Site>> getSitesFromEndpoint(
      {required String endpoint,
      int take = 10,
      int skip = 0,
      Map<String, dynamic>? params}) async {
    Map<String, dynamic> parameters = {
      "take": take.toString(),
      "skip": skip.toString(),
    };
    parameters.addAll(params ?? {});
    var response =
        await networkRepository.get(endpoint, parameters: parameters);
    return (response as List)
        .map((e) => SiteJson.fromJson(e).toDomain())
        .toList();
  }

  @override
  Future<List<TopActivity>> getTopActivities() async {
    var response = await networkRepository.get(APIEndpoint.getTopActivities);
    return (response as List)
        .map((e) => TopActivityJson.fromJson(e).toDomain())
        .toList();
  }

  @override
  Future<List<Site>> getAttractionsWorldWide(
      {int take = 10, int skip = 0}) async {
    var response = await networkRepository
        .get(APIEndpoint.getAttractionWorldWide, parameters: {
      'take': take.toString(),
      'skip': skip.toString(),
    });
    return (response as List)
        .map((e) => SiteJson.fromJson(e).toDomain())
        .toList();
  }

  @override
  Future<List<Site>> getMoreToExplore({int take = 10, int skip = 0}) async {
    var response =
        await networkRepository.get(APIEndpoint.getExploreMore, parameters: {
      'take': take.toString(),
      'skip': skip.toString(),
    });
    return (response as List)
        .map((e) => SiteJson.fromJson(e).toDomain())
        .toList();
  }

  @override
  Future<List<Site>> getSiteSeeingTours({int take = 10, int skip = 0}) async {
    var response = await networkRepository
        .get(APIEndpoint.getSiteSeeingTours, parameters: {
      'take': take.toString(),
      'skip': skip.toString(),
    });
    return (response as List)
        .map((e) => SiteJson.fromJson(e).toDomain())
        .toList();
  }

  @override
  Future<List<Site>> getWaterAdventures({int take = 10, int skip = 0}) async {
    var response = await networkRepository
        .get(APIEndpoint.getWaterAdventures, parameters: {
      'take': take.toString(),
      'skip': skip.toString(),
    });
    return (response as List)
        .map((e) => SiteJson.fromJson(e).toDomain())
        .toList();
  }

  @override
  Future<List<Site>> getSimilarExperiences(
      {int take = 10, int skip = 0, required String siteId}) async {
    var response = await networkRepository.get(APIEndpoint.getSimilarProducts,
        parameters: {
          'skip': skip.toString(),
          'take': take.toString(),
          'productId': siteId
        });
    return (response as List)
        .map((e) => SiteJson.fromJson(e).toDomain())
        .toList();
  }

  @override
  Future<PopularGatewayDetail> getPopularGatewayDetail(
      {required City city}) async {
    var response = await networkRepository
        .get("${APIEndpoint.getPopularGatewaysDetail}/${city.id}");
    return PopularGatewayDetailJson.fromJson(response).toDomain();
  }

  @override
  Future<List<Site>> getMyWishListSites() async {
    var response =
        await networkRepository.get(APIEndpoint.getWishList, useToken: true);
    return (response as List)
        .map((e) => SiteJson.fromJson(e).toDomain())
        .toList();
  }

  @override
  Future<bool> addOrRemoveFromWishList({required String siteId}) async {
    var response = await networkRepository
        .post("${APIEndpoint.addToWishList}/$siteId", {}, useToken: true);
    return response['added'];
  }

  @override
  Future<SearchSuggestion> getSearchSuggestions(
      {required String name}) async {
    var response = await networkRepository
        .get(APIEndpoint.getSearchSuggestions, parameters: {"name": name});
    return SearchSuggestionJson.fromJson(response).toDomain();
  }

  @override
  Future<List<Site>> filterActivities(
      {int take = 10,
      int skip = 0,
      String? tag,
      String? minPrice,
      String? maxPrice,
      String? rating,
      String? ratingSort,
      String? duration}) async {
    var response = await networkRepository.get(APIEndpoint.filterActivities,
        parameters: _removeNullAndEmptyValues({
          'take': take.toString(),
          'skip': skip.toString(),
          'tag': tag,
          'minPrice': minPrice,
          'maxPrice': maxPrice,
          'rating_sort': ratingSort,
          'duration': duration
        }));
    return (response as List)
        .map((e) => SiteJson.fromJson(e).toDomain())
        .toList();
  }


  @override
  Future<List<Site>> filterByDate(
      {int take = 10,
        int skip = 0,
       required DateTime dateTime,
        }) async {
    var response = await networkRepository.get(APIEndpoint.filterActivities,
        parameters: _removeNullAndEmptyValues({
          'take': take.toString(),
          'skip': skip.toString(),
          'date': DateFormat('yyyy-MM-dd').format(dateTime),
        }));
    return (response as List)
        .map((e) => SiteJson.fromJson(e).toDomain())
        .toList();
  }

  @override
  Future<List<ReviewRating>> getReviewsOfSite({required Site site,int take = 10, int skip = 0}) async {
    var response =
        await networkRepository.get(APIEndpoint.getReviews, parameters: {
      'type': site.provider,
      'code': site.productCode,
      'take':take.toString(),
      'skip':skip.toString()
    });
    return (response as List)
        .map((e) => ReviewRatingJson.fromJson(e).toDomain())
        .toList();
  }

  Map<String, dynamic> _removeNullAndEmptyValues(
      Map<String, dynamic> inputMap) {
    // Use Map.from to create a new map with the same entries as the input map
    // and then use removeWhere to remove entries where the value is null or empty.
    return Map.from(inputMap)
      ..removeWhere(
          (key, value) => value == null || (value is String && value.isEmpty));
  }

  @override
  Future<bool> deleteAccount() {
    // TODO: implement deleteAccount
    throw UnimplementedError();
  }

  @override
  Future<bool> changePassword(
      {required String currentPassword, required String newPassword}) async {

    var response = await networkRepository.patch(APIEndpoint.changePassword,
        {"password": newPassword, "currentPassword": currentPassword},useToken: true);
    return response['success'];
  }
}
