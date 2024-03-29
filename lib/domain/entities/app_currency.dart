import 'package:equatable/equatable.dart';

class AppCurrency extends Equatable{
  String? name;
  String? value;

  AppCurrency({this.name, this.value});

  AppCurrency.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
  }
  AppCurrency.defaultCurrency() {
    name = "US Dollar - \$";
    value = "USD";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['value'] = this.value;
    return data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [name,value];
}
