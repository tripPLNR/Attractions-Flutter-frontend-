import 'package:triplaner/data/models/city_json.dart';
import 'package:triplaner/data/models/popular_gateway_detail_json.dart';
import 'package:triplaner/data/models/site_json.dart';
import 'package:triplaner/data/models/top_activity_json.dart';
import 'package:triplaner/domain/entities/city.dart';
import 'package:triplaner/domain/entities/popular_gateway_detail.dart';
import 'package:triplaner/domain/entities/site.dart';
import 'package:triplaner/domain/entities/top_activity.dart';
import 'package:triplaner/domain/repositories/database_repository.dart';
import 'package:triplaner/network/api_endpoint.dart';
import 'package:triplaner/network/network_repository.dart';

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
  Future<List<Site>> getUncoverMore({required City city,int take=10,int skip=0}) async {
    var response = await networkRepository.get(APIEndpoint.getUncoverMore,parameters: {
      "gatewayId":city.id,
      "take":take.toString(),
      "skip":skip.toString()
    });
    return (response as List)
        .map((e) => SiteJson.fromJson(e).toDomain())
        .toList();
  }


  @override
  Future<List<Site>> getSitesFromEndpoint({required String endpoint,int take=10,int skip=0}) async {
    var response = await networkRepository.get(endpoint,parameters: {
      "take":take.toString(),
      "skip":skip.toString()
    });
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
  Future<List<Site>> getAttractionsWorldWide({int take=10,int skip=0}) async {
    var response = await networkRepository.get(APIEndpoint.getAttractionWorldWide,parameters: {
      'take':take.toString(),
      'skip':skip.toString(),
    });
    return (response as List)
        .map((e) => SiteJson.fromJson(e).toDomain())
        .toList();
  }

  @override
  Future<List<Site>> getMoreToExplore({int take=10,int skip=0}) async {
    var response = await networkRepository.get(APIEndpoint.getExploreMore,parameters:{
      'take':take.toString(),
      'skip':skip.toString(),
    });
    return (response as List)
        .map((e) => SiteJson.fromJson(e).toDomain())
        .toList();
  }

  @override
  Future<List<Site>> getSiteSeeingTours({int take=10,int skip=0}) async {
    var response = await networkRepository.get(APIEndpoint.getSiteSeeingTours,parameters: {
      'take':take.toString(),
      'skip':skip.toString(),
    });
    return (response as List)
        .map((e) => SiteJson.fromJson(e).toDomain())
        .toList();
  }

  @override
  Future<List<Site>> getWaterAdventures({int take=10,int skip=0}) async {
    var response = await networkRepository.get(APIEndpoint.getWaterAdventures,parameters: {
      'take':take.toString(),
      'skip':skip.toString(),
    });
    return (response as List)
        .map((e) => SiteJson.fromJson(e).toDomain())
        .toList();
  }

  @override
  Future<List<Site>> getSimilarExperiences({int take = 10, int skip = 0, required String siteId}) async {
    var response = await networkRepository.get(APIEndpoint.getSimilarProducts,parameters: {
      'skip':skip.toString(),
      'take':take.toString(),
      'productId':siteId
    });
    return (response as List)
        .map((e) => SiteJson.fromJson(e).toDomain())
        .toList();
  }

  @override
  Future<PopularGatewayDetail> getPopularGatewayDetail({required City city}) async {
    var response = await networkRepository.get("${APIEndpoint.getPopularGatewaysDetail}/${city.id}");
    return PopularGatewayDetailJson.fromJson(response).toDomain();
  }



}
