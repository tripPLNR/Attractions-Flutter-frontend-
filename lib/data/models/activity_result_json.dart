import 'package:triplaner/data/models/site_json.dart';
import 'package:triplaner/domain/entities/activity_result.dart';

class ActivityResultJson{
  int? count;
  List<SiteJson>? sites;
  ActivityResultJson({this.count,this.sites});

  ActivityResult toDomain(){
    return ActivityResult(
      count: count??0,
      sites: sites?.map((e) => e.toDomain()).toList()??[],
    );
  }
}