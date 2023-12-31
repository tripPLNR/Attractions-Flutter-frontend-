import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:triplaner/domain/repositories/local_storage_repository.dart';

import 'dart:developer' as logger;

import 'api_status.dart';

class NetworkRepository {
  /// localhost
  /// String baseUrl="http://localhost:5000";

  /// live server url
  String baseUrl = "35.154.229.4:9460";

  LocalStorageRepository localStorageRepository;
  NetworkRepository({required this.localStorageRepository});

  Future get(String url, {Map<String, dynamic>? parameters,bool useToken=false}) async {
    try {
      var headers = useToken?{
        'accept': 'application/json',
        'Authorization':"Bearer ${await localStorageRepository.getAccessToken()}"
      }:
      {
        'accept': 'application/json',
      };
      final uri = Uri.http(baseUrl, url, parameters);
      debugPrint("REQUEST   ========> $uri");
      http.Response response = await http.get(uri, headers: headers);
      dynamic responseJson = await returnResponse(response);
      return responseJson;
    } on SocketException {
      throw ApiStatuses.INTERNET_CONNECTION_PROBLEM;
    } catch(e){
      rethrow ;
    }
  }



  Future<dynamic> post(String url, dynamic body, {Map<String, dynamic>? parameters,bool useToken=false}) async {
    try {
      var headers = useToken?{
        'accept': 'application/json',
        'Authorization':"Bearer ${await localStorageRepository.getAccessToken()}"
      }:
      {
        'Content-Type': 'application/json'
      };
      final uri = Uri.http(baseUrl, url,parameters);
      debugPrint("REQUEST URL POST========> ${uri.toString()}");
      final requestBody =json.encode(body);
      http.Response response = await http.post(uri, headers: headers,body: requestBody);
      dynamic responseJson = await returnResponse(response);
      return responseJson;
    } on SocketException {
      throw ApiStatuses.INTERNET_CONNECTION_PROBLEM;
    }catch (e) {
      rethrow ;
    }
  }


  Future<dynamic> patch(String url, dynamic body, {Map<String, dynamic>? parameters,bool useToken=false}) async {
    try {
      var headers = useToken?{
        'Content-Type': 'application/json',
        'Authorization':"Bearer ${await localStorageRepository.getAccessToken()}"
      }:
      {
        'Content-Type': 'application/json'
      };
      final uri = Uri.http(baseUrl, url,parameters);
      debugPrint("REQUEST URL PATCH========> ${uri.toString()}");
      debugPrint("BODY OF PATCH========> ${body}");

      final requestBody =json.encode(body);
      http.Response response = await http.patch(uri, headers: headers,body: requestBody);
      dynamic responseJson = await returnResponse(response);
      return responseJson;
    } on SocketException {
      throw ApiStatuses.INTERNET_CONNECTION_PROBLEM;
    }catch (e) {
      rethrow ;
    }
  }
  Future put(String url, data) async {
    try {
      var headers = {
        'Content-Type': 'application/json',
      };
      final uri = Uri.http(baseUrl, url);
      final requestBody = jsonEncode(data);
      http.Response response = await http.put(uri, headers: headers,body: requestBody);
      dynamic responseJson = await returnResponse(response);
      return responseJson;
    } on SocketException {
      throw ApiStatuses.INTERNET_CONNECTION_PROBLEM;
    } catch (e) {
      throw e.toString();
    }
  }

  Future delete(String url, data) async {
    try {
      var headers = {
        'Content-Type': 'application/json',
      };
      final uri = Uri.http(baseUrl, url);
      final requestBody = jsonEncode(data);

      http.Response response = await http.delete(uri, headers: headers,body: requestBody);
      dynamic responseJson = await returnResponse(response);
      return responseJson;
    } on SocketException {
      throw ApiStatuses.INTERNET_CONNECTION_PROBLEM;
    } catch (e) {
      throw e.toString();
    }
  }

  Future returnResponse(http.Response  response) async {
    try {
    //  String stringResponse = response.body;
      // logger.log("**************** RESPONSE ********************");
      // logger.log(stringResponse);
      dynamic responseJson = await (await jsonDecode(utf8.decode(response.bodyBytes)));
      debugPrint("**************** API RESPONSE *********************");
      print(responseJson.toString());
      debugPrint("**************************************************");
      switch (response.statusCode) {
        case 200:
          return responseJson;
        case 202:
          return responseJson;
        case 201:
          return responseJson;
        default:
          throw responseJson['message'];
      }
    } on FormatException {
      throw ApiStatuses.INVALID_RESPONSE;
    } catch (e) {
      rethrow;
    }
  }


  String _encodeAuthorizationHeader(
      {required String username, required String password}) {
    debugPrint("USERNAME ======> $username");
    debugPrint("PASSWORD ======> $password");

    String authString = '$username:$password';
    String base64String = base64Encode(utf8.encode(authString));
    debugPrint("ENCODED AUTHORIZATION TOKEN ======> $base64String");
    return base64String;
  }
}
