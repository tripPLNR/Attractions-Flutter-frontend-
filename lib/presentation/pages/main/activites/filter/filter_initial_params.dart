import 'package:flutter/cupertino.dart';
import 'package:triplaner/domain/entities/search_location.dart';

class FilterInitialParams {
final VoidCallback clearFilter;
final SearchLocation? searchLocation;
final double? latitude;
final double? longitude;

const FilterInitialParams({required this.clearFilter,this.searchLocation,this.longitude,this.latitude});
}