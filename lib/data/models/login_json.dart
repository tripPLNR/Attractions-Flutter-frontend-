import 'package:triplaner/data/models/user_json.dart';
import 'package:triplaner/domain/entities/login.dart';

class LoginJson {
  String? token;
  UserJson? user;

  LoginJson({this.token, this.user});

  LoginJson.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? new UserJson.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }

  Login toDomain(){
    return Login(
      user: user?.toDomain(),
        token: token,
    );
  }
}

