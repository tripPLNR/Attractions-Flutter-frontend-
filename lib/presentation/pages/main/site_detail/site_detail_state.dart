import 'package:triplaner/domain/entities/site.dart';

import 'site_detail_initial_params.dart';

class SiteDetailState {
  final bool loading;
  final bool showAppbar;

  final bool loadingSimilarExperiences;
  final List<Site> similarExperiences;
  final int selectedMenuIndex;
  final Site site;

  const SiteDetailState({
    required this.loading,
    required this.selectedMenuIndex,
    required this.similarExperiences,
    required this.site,
    required this.showAppbar,
    required this.loadingSimilarExperiences,
  });

  factory SiteDetailState.initial(
          {required SiteDetailInitialParams initialParams}) =>
      SiteDetailState(
          loading: false,
          selectedMenuIndex: 0,
          site: initialParams.site,
          loadingSimilarExperiences: false,
          showAppbar:false,
          similarExperiences: []);

  SiteDetailState copyWith(
          {bool? loading,
          int? selectedMenuIndex,
          Site? site,
          bool? loadingSimilarExperiences,
          bool? showAppbar,
          List<Site>? similarExperiences}) =>
      SiteDetailState(
        loading: loading ?? this.loading,
        selectedMenuIndex: selectedMenuIndex ?? this.selectedMenuIndex,
        loadingSimilarExperiences:
            loadingSimilarExperiences ?? this.loadingSimilarExperiences,
        similarExperiences: similarExperiences ?? this.similarExperiences,
        showAppbar:showAppbar??this.showAppbar,
        site: site ?? this.site,
      );
}
