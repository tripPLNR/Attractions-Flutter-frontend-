import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'dart:developer' as logger;

import '../domain/repositories/local_storage_repository.dart';
import 'api_status.dart';
import 'file_field.dart';
import 'package:path/path.dart';

class NetworkRepository {
  /// localhost
  /// String baseUrl="http://localhost:5000";

  /// live server url
  String baseUrl = "http://54.253.63.1:3000";

  LocalStorageRepository localStorageRepository;

  NetworkRepository({required this.localStorageRepository});

  var dio = Dio();

  initialize() {
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      request: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      maxWidth: 90,
    ));
  }

  Future get(String url, {Map<String, dynamic>? parameters,bool getAllResponse=false}) async {
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization':
        'Bearer ${await localStorageRepository.getAccessToken()}',
      };
      var response = await dio.request(
        '$baseUrl$url',
        queryParameters: _removeNullAndEmptyValues(parameters??{}),
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      dynamic responseJson = await response.data;
      return getAllResponse?responseJson:responseJson['data'];
    } on DioException catch (e) {
      _handleException(e);
    } catch (e) {
      throw FormatException(e.toString());
    }
  }

  Future<dynamic> post(String url, Map<String, dynamic> body,
      {Map<String, dynamic>? parameters,
        bool isFormData = false,
        bool getFullResponse = false,

        List<FileField>? fileFields}) async {
    try {
      var headers = isFormData
          ? {'Content-Type': 'multipart/form-data'}
          : {
        'Accept': 'application/json',
        'Content-Type': 'application/x-www-form-urlencoded'
      };
      headers.addAll({
        "Authorization":"Bearer ${await localStorageRepository.getAccessToken()}"
      });
      var data;
      if (fileFields != null && fileFields.isNotEmpty) {
        for (var fileFiled in fileFields) {
          List<MultipartFile> multipartFiles = [];
          for (var httpFile in fileFiled.files) {
            debugPrint("image path : ${httpFile.path}, FILE NAME : ${basename(httpFile.path)}");
            // Determine MIME type dynamically based on file extension
            String mimeType = lookupMimeType(httpFile.path) ?? 'application/octet-stream';

            MultipartFile multipartFile = await MultipartFile.fromFile(
              httpFile.path,
              filename: httpFile.path.split('/').last,
              contentType: MediaType.parse(mimeType),
            );
            multipartFiles.add(multipartFile);
          }
          body.addAll({fileFiled.fieldName: multipartFiles});
        }
        data = FormData.fromMap(body);
      } else {
        data = body;
      }
      debugPrint("body data: ${data.toString()}");
      Response response = await dio.request(
        '$baseUrl$url',
        queryParameters: parameters,
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );
      dynamic responseJson = await response.data;
      return getFullResponse?responseJson:responseJson['data'];
    } on DioException catch (e) {
      _handleException(e);
    } catch (e) {
      throw FormatException(e.toString());
    }
  }

  Future<dynamic> patch(String url, dynamic body,
      {Map<String, dynamic>? parameters, bool useToken = false}) async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        "Authorization":"Bearer ${await localStorageRepository.getAccessToken()}"
      };
      var data = body;
      Response response = await dio.request(
        '$baseUrl$url',
        options: Options(
          method: 'PATCH',
          headers: headers,
        ),
        data: data,
      );
      dynamic responseJson = await response.data;
      return responseJson['data'];
    } on DioException catch (e) {
      _handleException(e);
    } catch (e) {
      throw FormatException(e.toString());
    }
  }

  Future put(String url, data) async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        "Authorization":"Bearer ${await localStorageRepository.getAccessToken()}"
      };
      Response response = await dio.request(
        '$baseUrl$url',
        options: Options(
          method: 'PUT',
          headers: headers,
        ),
        data: data,
      );
      dynamic responseJson = await response.data;
      return responseJson['data'];
    } on DioException catch (e) {
      _handleException(e);
    } catch (e) {
      throw FormatException(e.toString());
    }
  }

  Future delete(String url, data) async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        "Authorization":"Bearer ${await localStorageRepository.getAccessToken()}"
      };
      Response response = await dio.request(
        '$baseUrl$url',
        options: Options(
          method: 'DELETE',
          headers: headers,
        ),
        data: data,
      );
      dynamic responseJson = await response.data;
      return responseJson['data'];
    } on DioException catch (e) {
      _handleException(e);
    } catch (e) {
      throw FormatException(e.toString());
    }
  }

  _handleException(DioException exception) {
    debugPrint("status code : ${exception.response?.statusCode}");
    if (exception.type == DioExceptionType.connectionError) {
      throw ApiStatuses.INTERNET_CONNECTION_PROBLEM;
    }
    throw exception.response?.data['message'];
  }

  Map<String, dynamic> _removeNullAndEmptyValues(
      Map<String, dynamic> inputMap) {
    return Map.from(inputMap)
      ..removeWhere(
              (key, value) => value == null || (value is String && value.isEmpty));
  }
}
