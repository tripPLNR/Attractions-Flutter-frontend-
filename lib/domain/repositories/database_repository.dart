import 'package:triplaner/domain/entities/app_currency.dart';
import 'package:triplaner/domain/entities/booking_response.dart';
import 'package:triplaner/domain/entities/home_data.dart';
import 'package:triplaner/domain/entities/popular_gateway_detail.dart';
import 'package:triplaner/domain/entities/product_review.dart';
import 'package:triplaner/domain/entities/search_suggestion.dart';
import 'package:triplaner/domain/entities/site.dart';
import 'package:triplaner/domain/entities/top_activity.dart';
import 'package:triplaner/domain/http_request_body/filter_request_body.dart';

import '../entities/activity_result.dart';
import '../entities/city.dart';
import '../entities/search_location.dart';

abstract class DatabaseRepository {
  Future<List<City>> getPopularDestinations();

  Future<HomeData> getHomeData();

  Future<ActivityResult> getUncoverMore(
      {required City city, int take = 10, int skip = 0});

  Future<PopularGatewayDetail> getPopularDestinationDetail(
      {required City city});

  Future<List<TopActivity>> getTopActivities();

  Future<List<Site>> getSiteSeeingTours({int take = 10, int skip = 0});

  Future<List<Site>> getAttractionsWorldWide({int take = 10, int skip = 0});

  Future<List<Site>> getWaterAdventures({int take = 10, int skip = 0});

  Future<List<Site>> getMoreToExplore({int take = 10, int skip = 0});

  Future<Site> getSiteById({required String id});

  Future<ActivityResult> getSitesFromEndpoint(
      {required String endpoint,
      int take = 10,
      int skip = 0,
      Map<String, dynamic>? params});

  Future<List<Site>> getSimilarExperiences(
      {int take = 10, int skip = 0, required String siteId});

  Future<List<Site>> getMyWishListSites();

  Future<bool> addOrRemoveFromWishList({required String siteId});

  Future<SearchSuggestion> getSearchSuggestions({required String name});

  Future<List<Site>> filterActivities(
      {required FilterRequestBody filterRequestBody});

  Future<List<Site>> filterByDate(
      {int take = 10, int skip = 0, required DateTime dateTime});

  Future<BookingResponse> checkAvailability(
      {required Site site, required DateTime date});

  Future<List<ProductReview>> getReviewsOfSite(
      {required Site site, int take = 10, int skip = 0});

  /// profile
  Future<void> deleteAccount();

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  });

  Future<void> changeCurrency({required AppCurrency currency});
}
