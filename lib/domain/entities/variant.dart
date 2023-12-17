
class Variant {
  String? url;
  int? width;
  int? height;

  Variant({this.url, this.width, this.height});

  Variant.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    width = json['width'];
    height = json['height'];
  }


  Variant.empty() {
    url = "";
    width = 674;
    height =446;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['width'] = this.width;
    data['height'] = this.height;
    return data;
  }
}
