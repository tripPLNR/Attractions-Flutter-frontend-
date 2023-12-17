import 'package:triplaner/data/models/review_rating_json.dart';
import 'package:triplaner/domain/entities/site.dart';

import '../../../../domain/entities/review_rating.dart';
import 'site_detail_initial_params.dart';

class SiteDetailState {
  final bool loading;
  final bool loadingReviews;
  final bool showAppbar;
  final bool isTextCollapsed;

  final bool loadingSimilarExperiences;
  final List<Site> similarExperiences;
  final List<Site> wishListSites;
  final List<ReviewRating> reviewsRatings;
  final List<String> menus;

  final int selectedMenuIndex;
  final Site site;

  final DateTime checkAvailabilityDate;

  const SiteDetailState({
    required this.loading,
    required this.loadingReviews,
    required this.isTextCollapsed,
    required this.selectedMenuIndex,
    required this.similarExperiences,
    required this.site,
    required this.showAppbar,
    required this.loadingSimilarExperiences,
    required this.wishListSites,
    required this.reviewsRatings,
    required this.menus,
    required this.checkAvailabilityDate,
  });

  factory SiteDetailState.initial(
          {required SiteDetailInitialParams initialParams}) =>
      SiteDetailState(
        loading: false,
        loadingReviews: false,
        isTextCollapsed: true,
        selectedMenuIndex: 0,
        site: initialParams.site,
        loadingSimilarExperiences: false,
        showAppbar: false,
        similarExperiences: [],
        wishListSites: [],
        reviewsRatings: [],
        menus: ["Overview", "Includes", "Excludes", "Review"],
        checkAvailabilityDate: DateTime.now(),
      );

  SiteDetailState copyWith({
    bool? loading,
    bool? loadingReviews,
    bool? isTextCollapsed,
    int? selectedMenuIndex,
    Site? site,
    bool? loadingSimilarExperiences,
    bool? showAppbar,
    List<Site>? similarExperiences,
    List<Site>? wishListSites,
    List<ReviewRating>? reviewsRatings,
    List<String>? menus,
    DateTime? checkAvailabilityDate,
  }) =>
      SiteDetailState(
        loading: loading ?? this.loading,
        isTextCollapsed: isTextCollapsed ?? this.isTextCollapsed,
        loadingReviews: loadingReviews ?? this.loadingReviews,
        selectedMenuIndex: selectedMenuIndex ?? this.selectedMenuIndex,
        loadingSimilarExperiences:
            loadingSimilarExperiences ?? this.loadingSimilarExperiences,
        similarExperiences: similarExperiences ?? this.similarExperiences,
        showAppbar: showAppbar ?? this.showAppbar,
        site: site ?? this.site,
        wishListSites: wishListSites ?? this.wishListSites,
        reviewsRatings: reviewsRatings ?? this.reviewsRatings,
        menus: menus ?? this.menus,
        checkAvailabilityDate:checkAvailabilityDate??this.checkAvailabilityDate,
      );
}
