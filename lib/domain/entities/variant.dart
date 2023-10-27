
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
    url = "0000";
    width = 0000;
    height =0000;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['width'] = this.width;
    data['height'] = this.height;
    return data;
  }
}
