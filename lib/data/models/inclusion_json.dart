import '../../domain/entities/inclusion.dart';

class InclusionJson {
  String? category;
  String? categoryDescription;
  String? type;
  String? typeDescription;
  String? description;

  InclusionJson(
      {this.category,
        this.categoryDescription,
        this.type,
        this.typeDescription,
        this.description});

  InclusionJson.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    categoryDescription = json['categoryDescription'];
    type = json['type'];
    typeDescription = json['typeDescription'];
    description = json['description']??json['otherDescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['categoryDescription'] = this.categoryDescription;
    data['type'] = this.type;
    data['typeDescription'] = this.typeDescription;
    data['description'] = this.description;
    return data;
  }

  Inclusion toDomain(){
    return Inclusion(
      category: category??"N/A",
      categoryDescription: categoryDescription??"N/A",
      type: type??"N/A",
      typeDescription: typeDescription??"N/A",
        description: description??"N/A"
    );
  }
}
