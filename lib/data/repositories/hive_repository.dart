import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:triplaner/domain/entities/app_currency.dart';
import 'package:triplaner/domain/entities/user.dart';

import '../../domain/repositories/local_storage_repository.dart';

class HiveRepository implements LocalStorageRepository{

  static initialize() async {
    await Hive.initFlutter();
  }

  final authBox="authenticationBox";
  final cardBox="cardBox";
  final recentSearchBox="recentSearchBox";
  final settingBox="settingBox";






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

  @override
  Future<List<String>> getRecentSearches() async {
    var box = await Hive.openBox<String>(recentSearchBox);
    List<String> savedRecentSearched=box.values.toList();
    debugPrint("saved recent searches $savedRecentSearched");
    return savedRecentSearched.reversed.toSet().toList();
  }

  @override
  Future<bool> saveRecentSearch({required String search}) async {
    var box = await Hive.openBox<String>(recentSearchBox);
    await box.add(search);
    debugPrint("added into recent search");
    return true;
  }

  @override
  Future<bool> clearRecentSearch() async {
    var box = await Hive.openBox<String>(recentSearchBox);
    box.clear();
    return true;
  }

  @override
  Future<AppCurrency> getCurrency() async {
    var box = await Hive.openBox(settingBox);
    String response=await box.get('currency')??"";
    if(response.isEmpty) return  AppCurrency.defaultCurrency();
    return AppCurrency.fromJson(await json.decode(response));
  }

  @override
  Future<bool> saveCurrency(AppCurrency currency) async {
    var box = await Hive.openBox(settingBox);
    await box.put('currency',json.encode(currency.toJson()));
    return true;
  }



}