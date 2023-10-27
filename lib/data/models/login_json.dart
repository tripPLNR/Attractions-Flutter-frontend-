import 'package:triplaner/data/models/user_json.dart';
import 'package:triplaner/domain/entities/login.dart';

class LoginJson {
  String? userId;
  String? accessToken;
  String? refreshToken;
  UserJson? user;

  LoginJson({this.userId, this.accessToken, this.refreshToken, this.user});

  LoginJson.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
    user = json['user'] != null ? new UserJson.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['accessToken'] = this.accessToken;
    data['refreshToken'] = this.refreshToken;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }

  Login toDomain(){
    return Login(
      userId: userId,
      user: user?.toDomain(),
      accessToken: accessToken,
      refreshToken: refreshToken
    );
  }
}

