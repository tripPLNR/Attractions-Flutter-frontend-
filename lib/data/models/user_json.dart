import 'package:triplaner/domain/entities/user.dart';

class UserJson {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? authType;


  UserJson({this.firstName, this.lastName, this.email, this.id,this.authType});

  UserJson.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    id = json['id'];
    authType = json['authType'];

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

  User toDomain(){
    return User(
      firstName: firstName??"N/A",
      lastName: lastName??"N/A",
      email: email??"N/A",
      id: id.toString()
    );
  }
}
