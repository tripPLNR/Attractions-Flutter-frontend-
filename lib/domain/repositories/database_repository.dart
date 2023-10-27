import 'package:triplaner/domain/entities/popular_gateway_detail.dart';
import 'package:triplaner/domain/entities/site.dart';
import 'package:triplaner/domain/entities/top_activity.dart';

import '../entities/city.dart';

abstract class DatabaseRepository{
  Future<List<City>> getPopularGateways();
  Future<List<Site>> getUncoverMore({required City city,int take=10,int skip=0});
  Future<PopularGatewayDetail> getPopularGatewayDetail({required City city});
  Future<List<TopActivity>> getTopActivities();
  Future<List<Site>> getSiteSeeingTours();
  Future<List<Site>> getAttractionsWorldWide();
  Future<List<Site>> getWaterAdventures();
  Future<List<Site>> getMoreToExplore();
  Future<List<Site>> getSitesFromEndpoint({required String endpoint,int take=10,int skip=0});

  Future<List<Site>> getSimilarExperiences({int take=10,int skip=0,required String siteId});

}