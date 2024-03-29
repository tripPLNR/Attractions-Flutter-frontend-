import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:triplaner/data/models/activity_result_json.dart';
import 'package:triplaner/data/models/booking_response_json.dart';
import 'package:triplaner/data/models/city_json.dart';
import 'package:triplaner/data/models/popular_gateway_detail_json.dart';
import 'package:triplaner/data/models/product_review_json.dart';
import 'package:triplaner/data/models/search_suggestion_json.dart';
import 'package:triplaner/data/models/site_json.dart';
import 'package:triplaner/data/models/top_activity_json.dart';
import 'package:triplaner/domain/entities/app_currency.dart';
import 'package:triplaner/domain/entities/booking_response.dart';
import 'package:triplaner/domain/entities/city.dart';
import 'package:triplaner/domain/entities/home_data.dart';
import 'package:triplaner/domain/entities/popular_gateway_detail.dart';
import 'package:triplaner/domain/entities/product_review.dart';
import 'package:triplaner/domain/entities/search_location.dart';
import 'package:triplaner/domain/entities/search_suggestion.dart';
import 'package:triplaner/domain/entities/site.dart';
import 'package:triplaner/domain/entities/top_activity.dart';
import 'package:triplaner/domain/http_request_body/filter_request_body.dart';
import 'package:triplaner/domain/repositories/database_repository.dart';
import 'package:triplaner/network/api_endpoint.dart';
import 'package:triplaner/network/network_repository.dart';
import 'package:triplaner/util/services/device_info/device_info_service.dart';

import '../../domain/entities/activity_result.dart';

class RestAPIRepository implements DatabaseRepository {
  NetworkRepository networkRepository;
  DeviceInfoService deviceInfoService;

  RestAPIRepository(
      {required this.networkRepository, required this.deviceInfoService});

  @override
  Future<List<City>> getPopularDestinations() async {
    var response =
        await networkRepository.get(APIEndpoint.getPopularDestinations);
    return (response as List)
        .map((e) => CityJson.fromJson(e).toDomain())
        .toList();
  }

  @override
  Future<ActivityResult> getUncoverMore(
      {required City city, int take = 10, int skip = 0}) async {
    var response = await networkRepository.get(
        "${APIEndpoint.getUncoverMore}/${city.cityId}",
        parameters: {"take": take.toString(), "skip": skip.toString()},
        getAllResponse: true);
    ActivityResultJson resultJson = ActivityResultJson(
        count: response['count'],
        sites: (response['data'] as List)
            .map((e) => SiteJson.fromJson(e))
            .toList());
    return resultJson.toDomain();
  }

  @override
  Future<ActivityResult> getSitesFromEndpoint(
      {required String endpoint,
      int take = 10,
      int skip = 0,
      Map<String, dynamic>? params}) async {
    Map<String, dynamic> parameters = {
      "take": take.toString(),
      "skip": skip.toString(),
    };
    parameters.addAll(params ?? {});
    var response = await networkRepository.get(endpoint,
        parameters: parameters, getAllResponse: true);
    ActivityResultJson resultJson = ActivityResultJson(
        count: response['count'],
        sites: (response['data'] as List)
            .map((e) => SiteJson.fromJson(e))
            .toList());
    return resultJson.toDomain();
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
    var response = await networkRepository
        .get("${APIEndpoint.getSimilarProducts}/$siteId", parameters: {
      'skip': skip.toString(),
      'take': take.toString(),
    });
    return (response as List)
        .map((e) => SiteJson.fromJson(e).toDomain())
        .toList();
  }

  @override
  Future<PopularGatewayDetail> getPopularDestinationDetail(
      {required City city}) async {
    var response = await networkRepository
        .get("${APIEndpoint.getPopularGatewaysDetail}/${city.id}");
    return PopularGatewayDetailJson.fromJson(response).toDomain();
  }

  @override
  Future<List<Site>> getMyWishListSites() async {
    var response = await networkRepository.get(
      APIEndpoint.getWishList,
    );
    return (response as List)
        .map((e) => SiteJson.fromJson(e).toDomain())
        .toList();
  }

  @override
  Future<bool> addOrRemoveFromWishList({required String siteId}) async {
    var response = await networkRepository.post(
      "${APIEndpoint.addToWishList}/$siteId",
      {},
    );
    return response['added'];
  }

  @override
  Future<SearchSuggestion> getSearchSuggestions({required String name}) async {
    var response = await networkRepository
        .get(APIEndpoint.searchByCityCountry, parameters: {"name": name});
    return SearchSuggestionJson.fromJson(response).toDomain();
  }

  @override
  Future<List<Site>> filterActivities(
      {required FilterRequestBody filterRequestBody}) async {
    var response = await networkRepository.get(APIEndpoint.filterActivities,
        parameters: _removeNullAndEmptyValues(filterRequestBody.toJson()));
    return (response as List)
        .map((e) => SiteJson.fromJson(e).toDomain())
        .toList();
  }

  @override
  Future<List<Site>> filterByDate({
    int take = 10,
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
  Future<List<ProductReview>> getReviewsOfSite(
      {required Site site, int take = 10, int skip = 0}) async {
    var response =
        await networkRepository.get(APIEndpoint.getReviews, parameters: {
      'type': site.provider,
      'code': site.productCode,
      'take': take.toString(),
      'skip': skip.toString()
    });
    return (response as List)
        .map((e) => ProductReviewJson.fromJson(e).toDomain())
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
  Future<void> deleteAccount() async {
    await networkRepository.delete(APIEndpoint.deleteAccount,{});
  }

  @override
  Future<void> changePassword(
      {required String currentPassword, required String newPassword}) async {
   await networkRepository.put(APIEndpoint.changePassword, {
      "oldPassword": currentPassword,
      "newPassword": newPassword,
      "confirmPassword": newPassword,
    });
  }

  @override
  Future<Site> getSiteById({required String id}) async {
    var response = await networkRepository.get(
      "${APIEndpoint.getSiteById}/$id",
    );
    return SiteJson.fromJson(response).toDomain();
  }

  @override
  Future<BookingResponse> checkAvailability(
      {required Site site, required DateTime date}) async {
    var response = await networkRepository
        .get("${APIEndpoint.checkAvailability}/${site.id}", parameters: {
      "provider": site.provider,
      "startDate": DateFormat('yyyy-MM-dd').format(date),
    },getAllResponse: true);
    return BookingResponseJson.fromJson(response).toDomain();
  }

  @override
  Future<void> changeCurrency({required AppCurrency currency}) async {
    await networkRepository.post(
      APIEndpoint.changeCurrency,
      {
        "currencyType": currency.value,
        "clientId": await deviceInfoService.getDeviceId(),
      },
    );
  }

  @override
  Future<HomeData> getHomeData() async {
    var response = await networkRepository.get(APIEndpoint.getHomeData);
    return HomeData(
      popularDestinations: (response['popularDestination']['data'] as List)
          .map((e) => CityJson.fromJson(e).toDomain())
          .toList(),
      sightSeeingTours: (response['getSightSeeingTours']['data'] as List)
          .map((e) => SiteJson.fromJson(e).toDomain())
          .toList(),
      topActivities: (response['topActivities']['data'] as List)
          .map((e) => TopActivityJson.fromJson(e).toDomain())
          .toList(),
      worldWideAttractions: (response['worldWideAttractions']['data'] as List)
          .map((e) => SiteJson.fromJson(e).toDomain())
          .toList(),
      waterAdventures: (response['waterAdventures']['data'] as List)
          .map((e) => SiteJson.fromJson(e).toDomain())
          .toList(),
      exploreMore: (response['exploreMore']['data'] as List)
          .map((e) => SiteJson.fromJson(e).toDomain())
          .toList(),
    );
  }
}
