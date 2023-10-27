
import 'package:triplaner/domain/entities/variant.dart';

class VariantJson {
  String? url;
  int? width;
  int? height;

  VariantJson({this.url, this.width, this.height});

  VariantJson.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['width'] = this.width;
    data['height'] = this.height;
    return data;
  }

  Variant toDomain(){
    return Variant(
      url: url??"",
      width: width??50,
      height: height??50
    );
  }
}
