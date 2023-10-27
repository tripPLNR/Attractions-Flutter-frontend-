
import 'package:triplaner/domain/entities/user.dart';

class Login{
  String? userId;
  String? accessToken;
  String? refreshToken;
  User? user;

  Login({this.userId, this.accessToken, this.refreshToken, this.user});

  Login.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
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
}

