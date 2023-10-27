import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:triplaner/domain/entities/user.dart';

import '../../domain/repositories/local_storage_repository.dart';

class HiveRepository implements LocalStorageRepository{

  static initialize() async {
    await Hive.initFlutter();
  }

  final authBox="authenticationBox";

  final cardBox="cardBox";




  @override
  Future<bool> saveAccessToken(String token) async {
    try {
      var box = await Hive.openBox(authBox);
      await box.put('access_token',token);
      return true;
    }catch(e){
      throw e.toString();
    }
  }

  @override
  Future<String> getAccessToken() async {
    try {
      var box = await Hive.openBox(authBox);
      return await box.get('access_token')??"";
    }catch(e){
      throw e.toString();
    }
  }



  @override
  Future<bool> clearAll() async {
    try {
      _clearAuthBox();
      return true;
    }catch(e){
      throw e.toString();
    }
  }

  _clearAuthBox() async {
    var box = await Hive.openBox(authBox);
    await box.clear();
  }


  @override
  Future<User?> getUser() async {
    var box = await Hive.openBox(authBox);
    String response=await box.get('user')??"";
    if(response.isEmpty) return  null;
    return User.fromJson(await json.decode(response));
  }

  @override
  Future<bool> saveUser(User user) async {
    var box = await Hive.openBox(authBox);
    await box.put('user',json.encode(user.toJson()));
    return true;
  }



}