import 'package:triplaner/domain/entities/user.dart';

class UserJson {
  String? firstName;
  String? lastName;
  String? email;
  String? id;

  UserJson({this.firstName, this.lastName, this.email, this.id});

  UserJson.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['id'] = this.id;
    return data;
  }

  User toDomain(){
    return User(
      firstName: firstName??"N/A",
      lastName: lastName??"N/A",
      email: email??"N/A",
      id: id??""
    );
  }
}
