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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.location != null) {
      data['location'] = this.location!.map((v) => v.toJson()).toList();
    }
    if (this.attractions != null) {
      data['attractions'] = this.attractions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

