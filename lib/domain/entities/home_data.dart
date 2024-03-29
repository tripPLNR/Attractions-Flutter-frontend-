import 'package:triplaner/domain/entities/city.dart';
import 'package:triplaner/domain/entities/site.dart';
import 'package:triplaner/domain/entities/top_activity.dart';

class HomeData {
  List<City> popularDestinations;
  List<Site> sightSeeingTours;
  List<TopActivity> topActivities;
  List<Site> worldWideAttractions;
  List<Site> waterAdventures;
  List<Site> exploreMore;


  HomeData({
    required this.popularDestinations,
    required this.sightSeeingTours,
    required this.topActivities,
    required this.worldWideAttractions,
    required this.waterAdventures,
    required this.exploreMore
  });
}
