
import 'package:triplaner/domain/entities/popular_gateway_detail.dart';
import 'package:triplaner/domain/entities/search_suggestion.dart';
import 'package:triplaner/domain/entities/site.dart';
import 'package:triplaner/domain/entities/top_activity.dart';

import '../entities/city.dart';
import '../entities/review_rating.dart';

abstract class DatabaseRepository {
  Future<List<City>> getPopularGateways();

  Future<List<Site>> getUncoverMore(
      {required City city, int take = 10, int skip = 0});

  Future<PopularGatewayDetail> getPopularGatewayDetail({required City city});

  Future<List<TopActivity>> getTopActivities();

  Future<List<Site>> getSiteSeeingTours({int take = 10, int skip = 0});

  Future<List<Site>> getAttractionsWorldWide({int take = 10, int skip = 0});

  Future<List<Site>> getWaterAdventures({int take = 10, int skip = 0});

  Future<List<Site>> getMoreToExplore({int take = 10, int skip = 0});

  Future<List<Site>> getSitesFromEndpoint(
      {required String endpoint,
      int take = 10,
      int skip = 0,
      Map<String, dynamic>? params});

  Future<List<Site>> getSimilarExperiences(
      {int take = 10, int skip = 0, required String siteId});

  Future<List<Site>> getMyWishListSites();
  Future<bool> addOrRemoveFromWishList({required String siteId});

  Future<SearchSuggestion> getSearchSuggestions({required String name});
  Future<List<Site>> filterActivities({int take = 10, int skip = 0,String? tag,String? minPrice, String? maxPrice, String? rating,String? ratingSort,String? duration});
  Future<List<Site>> filterByDate({int take = 10, int skip = 0,required DateTime dateTime});

  Future<List<ReviewRating>> getReviewsOfSite({required Site site,int take = 10, int skip = 0});


  /// profile
  Future<bool> deleteAccount();
  Future<bool> changePassword({required String currentPassword,required String newPassword});




}
