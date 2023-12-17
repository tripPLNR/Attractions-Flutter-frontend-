import 'package:triplaner/data/models/site_json.dart';
import 'package:triplaner/domain/entities/search_suggestion.dart';
import 'search_location_json.dart';


class SearchSuggestionJson {
  List<SearchLocationJson>? location;
  List<SiteJson>? attractions;

  SearchSuggestionJson({this.location, this.attractions});

  SearchSuggestionJson.fromJson(Map<String, dynamic> json) {
    if (json['location'] != null) {
      location = <SearchLocationJson>[];
      json['location'].forEach((v) {
        location!.add(new SearchLocationJson.fromJson(v));
      });
    }
    if (json['attractions'] != null) {
      attractions = <SiteJson>[];
      json['attractions'].forEach((v) {
        attractions!.add(new SiteJson.fromJson(v));
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

  SearchSuggestion toDomain(){
    return SearchSuggestion(
      location: location?.map((e) => e.toDomain()).toList()??[],
      attractions:attractions?.map((e) => e.toDomain()).toList()??[],
    );
  }
}

