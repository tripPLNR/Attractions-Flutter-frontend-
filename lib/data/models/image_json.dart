import 'package:triplaner/domain/entities/image.dart';

import 'varient_json.dart';

class ImageJson {
  String? caption;
  bool? isCover;
  List<VariantJson>? variants;
  String? imageSource;

  ImageJson({this.caption, this.isCover, this.variants, this.imageSource});

  ImageJson.fromJson(Map<String, dynamic> json) {
    caption = json['caption'];
    isCover = json['isCover'];
    if (json['variants'] != null) {
      variants = <VariantJson>[];
      json['variants'].forEach((v) {
        variants!.add(new VariantJson.fromJson(v));
      });
    }
    imageSource = json['imageSource'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['caption'] = this.caption;
    data['isCover'] = this.isCover;
    if (this.variants != null) {
      data['variants'] = this.variants!.map((v) => v.toJson()).toList();
    }
    data['imageSource'] = this.imageSource;
    return data;
  }
  Image toDomain(){
    return Image(
      caption: caption??"N/A",
      isCover: false,
      variants: variants?.map((e) => e.toDomain()).toList()??[],
      imageSource: imageSource??"N/A"
    );
  }
}
