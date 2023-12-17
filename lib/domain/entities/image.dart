import 'variant.dart';

class Image {
  String? caption;
  bool? isCover;
  List<Variant>? variants;
  String? imageSource;

  Image({this.caption, this.isCover, this.variants, this.imageSource});

  Image.fromJson(Map<String, dynamic> json) {
    caption = json['caption'];
    isCover = json['isCover'];
    if (json['variants'] != null) {
      variants = <Variant>[];
      json['variants'].forEach((v) {
        variants!.add(new Variant.fromJson(v));
      });
    }
    imageSource = json['imageSource'];
  }

  Image.empty() {
    caption = "0000";
    isCover = false;
    variants = <Variant>[Variant.empty(),Variant.empty()];
    imageSource = "0000";
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
}

