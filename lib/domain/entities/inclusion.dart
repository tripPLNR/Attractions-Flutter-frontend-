class Inclusion {
  String? category;
  String? categoryDescription;
  String? type;
  String? typeDescription;
  String? otherDescription;

  Inclusion(
      {this.category,
        this.categoryDescription,
        this.type,
        this.typeDescription,
        this.otherDescription});

  Inclusion.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    categoryDescription = json['categoryDescription'];
    type = json['type'];
    typeDescription = json['typeDescription'];
    otherDescription = json['otherDescription'];
  }

  Inclusion.empty() {
    category = "0000";
    categoryDescription ="0000";
    type ="000";
    typeDescription = "0000";
    otherDescription = "0000";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['categoryDescription'] = this.categoryDescription;
    data['type'] = this.type;
    data['typeDescription'] = this.typeDescription;
    data['otherDescription'] = this.otherDescription;
    return data;
  }
}