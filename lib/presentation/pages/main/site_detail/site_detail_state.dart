import 'package:equatable/equatable.dart';

import 'package:triplaner/domain/entities/booking_response.dart';
import 'package:triplaner/domain/entities/product_review.dart';
import 'package:triplaner/domain/entities/site.dart';

import 'site_detail_initial_params.dart';

class SiteDetailState extends Equatable {
  final bool loading;
  final bool loadingReviews;
  final bool showAppbar;
  final bool isTextCollapsed;
  final bool checkingAvailability;

  final bool loadingSimilarExperiences;
  final List<Site> similarExperiences;
  final List<Site> wishListSites;
  final List<ProductReview> reviewsRatings;
  final List<String> menus;

  final int selectedMenuIndex;
  final Site site;
  final BookingResponse bookingResponse;

  final DateTime checkAvailabilityDate;

  const SiteDetailState({
    required this.loading,
    required this.loadingReviews,
    required this.checkingAvailability,
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
    required this.bookingResponse,
  });

  factory SiteDetailState.initial(
          {required SiteDetailInitialParams initialParams}) =>
      SiteDetailState(
        loading: false,
        loadingReviews: false,
        isTextCollapsed: true,
        checkingAvailability: false,
        selectedMenuIndex: 0,
        site: Site.empty(),
        loadingSimilarExperiences: false,
        showAppbar: false,
        similarExperiences: const [],
        wishListSites: const [],
        reviewsRatings: const [],
        menus: const ["Overview", "Includes", "Excludes","Location", "Reviews","Cancellation Policy"],
        checkAvailabilityDate: DateTime.now(),
        bookingResponse: BookingResponse.empty(),
      );

  SiteDetailState copyWith({
    bool? loading,
    bool? loadingReviews,
    bool? checkingAvailability,
    bool? isTextCollapsed,
    int? selectedMenuIndex,
    Site? site,
    bool? loadingSimilarExperiences,
    bool? showAppbar,
    List<Site>? similarExperiences,
    List<Site>? wishListSites,
    List<ProductReview>? reviewsRatings,
    List<String>? menus,
    DateTime? checkAvailabilityDate,
    BookingResponse? bookingResponse,
  }) =>
      SiteDetailState(
        loading: loading ?? this.loading,
        checkingAvailability: checkingAvailability ?? this.checkingAvailability,
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
        checkAvailabilityDate:
            checkAvailabilityDate ?? this.checkAvailabilityDate,
        bookingResponse: bookingResponse ?? this.bookingResponse,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [
        loading,
        checkingAvailability,
        isTextCollapsed,
        loadingReviews,
        selectedMenuIndex,
        loadingSimilarExperiences,
        similarExperiences,
        showAppbar,
        site,
        wishListSites,
        reviewsRatings,
        menus,
        checkAvailabilityDate,
        bookingResponse,
      ];
}
