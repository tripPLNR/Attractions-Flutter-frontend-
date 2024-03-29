import 'package:triplaner/domain/entities/site.dart';

import 'search_location.dart';

class SearchSuggestion {
  List<SearchLocation>? location;
  List<Site>? attractions;

  SearchSuggestion({this.location, this.attractions});

  SearchSuggestion.fromJson(Map<String, dynamic> json) {
    if (json['location'] != null) {
      location = <SearchLocation>[];
      json['location'].forEach((v) {
        location!.add(new SearchLocation.fromJson(v));
      });
    }
    if (json['attractions'] != null) {
      attractions = <Site>[];
      json['attractions'].forEach((v) {
        attractions!.add(new Site.fromJson(v));
      });
    }
  }

}

