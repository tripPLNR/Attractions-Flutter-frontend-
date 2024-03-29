import 'package:equatable/equatable.dart';

class User extends Equatable{
  String? firstName;
  String? lastName;
  String? email;
  String? id;
  String? authType;


  User({this.firstName, this.lastName, this.email, this.id,this.authType,});

  User.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    id = json['id'];
    authType = json['authType'];
  }

  User.empty() {
    firstName = "";
    lastName = "";
    email = "";
    id = "";
    authType="apple";
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['id'] = this.id;
    data['authType'] = this.authType;
    return data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    firstName,
    lastName,
    email,
    id,
    authType,
  ];


}