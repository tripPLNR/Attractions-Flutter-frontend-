import 'package:triplaner/domain/entities/site.dart';

import 'activities_initial_params.dart';

class ActivitiesState {
  final bool loading;
  final List<Site> sites;
  final bool loadingMore;
  final bool noMoreSites;
  final String endpointUrl;
  final String title;

  const ActivitiesState(
      {required this.loading,
      required this.sites,
      required this.loadingMore,
      required this.noMoreSites,
      required this.endpointUrl,
      required this.title});

  factory ActivitiesState.initial(
          {required ActivitiesInitialParams initialParams}) =>
      ActivitiesState(
          loading: false,
          sites: [],
          loadingMore: false,
          noMoreSites: false,
          endpointUrl: initialParams.endpoint,
          title: initialParams.title);

  ActivitiesState copyWith({
    bool? loading,
    List<Site>? sites,
    bool? loadingMore,
    bool? noMoreSites,
    String? endpointUrl,
    String? title,
  }) =>
      ActivitiesState(
        loading: loading ?? this.loading,
        sites: sites ?? this.sites,
        loadingMore: loadingMore ?? this.loadingMore,
        noMoreSites: noMoreSites ?? this.noMoreSites,
        endpointUrl: endpointUrl ?? this.endpointUrl,
        title: title ?? this.title,
      );
}
