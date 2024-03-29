import 'package:triplaner/domain/entities/search_location.dart';

class ActivitiesInitialParams {
  final String endpoint;
  final String title;
  final Map<String, dynamic>? parameters;
  final SearchLocation? searchLocation;
  final double? latitude;
  final double? longitude;
  final bool showFilterButton;
 final bool showNearbyButton;


  const ActivitiesInitialParams({
    required this.endpoint,
    required this.title,
    this.parameters,
    this.searchLocation,
    this.longitude,
    this.latitude,
    this.showFilterButton=false,
    this.showNearbyButton=false,
  });
}
