class Inclusion {
  String? category;
  String? categoryDescription;
  String? type;
  String? typeDescription;
  String? description;

  Inclusion(
      {this.category,
        this.categoryDescription,
        this.type,
        this.typeDescription,
        this.description});

  Inclusion.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    categoryDescription = json['categoryDescription'];
    type = json['type'];
    typeDescription = json['typeDescription'];
    description = json['description'];
  }

  Inclusion.empty() {
    category = "0000";
    categoryDescription ="0000";
    type ="000";
    typeDescription = "0000";
    description = "0000";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['categoryDescription'] = this.categoryDescription;
    data['type'] = this.type;
    data['typeDescription'] = this.typeDescription;
    data['otherDescription'] = this.description;
    return data;
  }
}