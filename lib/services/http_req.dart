import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:laundry/services/api_reponse.dart';
import 'package:laundry/services/get_it.dart';
import 'package:laundry/services/helpers.dart';
import 'package:laundry/services/shared_preference_helper.dart';
import 'package:laundry/utils/enums.dart';

class HttpReq {
  Helpers helpers = sl.get<Helpers>();
  SharedPreferencesHelper sharedPreferencesHelper =
      sl.get<SharedPreferencesHelper>();
  final String _appJson = 'application/json';

  Future<Either<ApiResponse, dynamic>> getRequest(String endPoint) async {
    String token = await sharedPreferencesHelper.getAuthToken();
    try {
      bool networkStat = await helpers.isInternetAvailable();
      if (!networkStat) {
        return Left(ApiResponse(exceptions: ApiExceptions.networkError));
      }
      //String storeCode = await sharedPreferencesHelper.toreCode();
      //ESCredentialModel credentialModel = AppData.getESCredentials(storeCode);
      var response = await http.get(
        Uri.parse('https://ledegraissage.tortillon.in$endPoint'),
        headers: <String, String>{
          HttpHeaders.acceptHeader: _appJson,
          HttpHeaders.contentTypeHeader: _appJson,
          'Authorization': 'Bearer $token',
        },
      ).timeout(const Duration(seconds: 60));
      return _returnResponse(response, endPoint);
    } catch (_) {
      return Left(ApiResponse(exceptions: ApiExceptions.error));
    }
  }

  Future<Either<ApiResponse, dynamic>> postRequest(String endPoint,
      {param}) async {
    try {
      bool networkStat = await helpers.isInternetAvailable();
      String token = await sharedPreferencesHelper.getAuthToken();
      if (!networkStat) {
        return Left(ApiResponse(exceptions: ApiExceptions.networkError));
      }
      // String storeCode = await SharedPreferencesHelper.getStoreCode();
      // ESCredentialModel credentialModel = AppData.getESCredentials(storeCode);
      // print(
      //     "elastic search clientID ${credentialModel.clientId}  secreteKey ${credentialModel.secretKey}");
      // print("es search  = $param");
      var response = await http.post(
        Uri.parse('https://ledegraissage.tortillon.in$endPoint'),
        body: jsonEncode(param),
        headers: <String, String>{
          HttpHeaders.acceptHeader: _appJson,
          HttpHeaders.contentTypeHeader: _appJson,
          'Authorization': 'Bearer $token',
        },
      ).timeout(const Duration(seconds: 60));
      return _returnResponse(response, endPoint);
    } catch (e) {
      return Left(ApiResponse(exceptions: ApiExceptions.error));
    }
  }

  Future postRequestWithFiles(String endPoint,
      {param, Map<String, List<dynamic>>? files}) async {
    try {
      String token = await sharedPreferencesHelper.getAuthToken();
      bool networkStat = await helpers.isInternetAvailable();
      if (!networkStat) {
        return Left(ApiResponse(exceptions: ApiExceptions.networkError));
      }
      var request = http.MultipartRequest(
          'POST', Uri.parse('https://ledegraissage.tortillon.in$endPoint'));

      files?.forEach((key, value) async {
        for (int i = 0; i < value.length; i++) {
          request.files.add(http.MultipartFile(
              key, value[i].readAsBytes().asStream(), value[i].lengthSync(),
              filename: value[i].path.split('/').last));
        }
      });

      param.forEach((key, value) {
        if (value is List) {
          for (int i = 0; i < value.length; i++) {
            request.fields.addAll({'$key[$i]': value[i]});
          }
        } else {
          request.fields[key] = value;
        }
      });
      // Add headers to the request
      request.headers.addAll({
        HttpHeaders.acceptHeader: _appJson,
        HttpHeaders.contentTypeHeader: _appJson,
        'Authorization': 'Bearer $token',
      });
      var response = await request.send();
      if (response.statusCode == 200) {
        final List<int> bytes =
            await response.stream.expand((chunk) => chunk).toList();
        final responseBody = utf8.decode(bytes);
        final jsonData = jsonDecode(responseBody);
        debugPrint('Response Body: $responseBody');
        return jsonData;
      } else {
        final List<int> bytes =
            await response.stream.expand((chunk) => chunk).toList();
        final responseBody = utf8.decode(bytes);
        final jsonData = jsonDecode(responseBody);
        debugPrint('Response Body: $responseBody');
        return jsonData;
      }
    } catch (e) {
      return Left(ApiResponse(exceptions: ApiExceptions.error));
    }
  }

  Either<ApiResponse, dynamic> _returnResponse(
      http.Response response, String endpoint) {
    switch (response.statusCode) {
      case 200:
        log(jsonDecode(response.body).toString(),
            name: 'Status: 200 - $endpoint');
        return Right(jsonDecode(response.body));
      case 401:
        log(jsonDecode(response.body).toString(),
            name: 'Status: 401 - $endpoint');
        return Left(ApiResponse(
            exceptions: ApiExceptions.authErr,
            message: jsonDecode(response.body)['message']));
      case 422:
        log(jsonDecode(response.body).toString(),
            name: 'Status: 401 - $endpoint');
        return Left(ApiResponse(
            exceptions: ApiExceptions.authErr,
            message: jsonDecode(response.body)['message']));
      case 403:
        log(jsonDecode(response.body).toString(),
            name: 'Status: 403 - $endpoint');
        return Left(ApiResponse(
            exceptions: ApiExceptions.authErr,
            message: 'Not authorised please login'));
      case 500:
        log(jsonDecode(response.body).toString(),
            name: 'Status: 500 - $endpoint');
        return Left(ApiResponse(
            exceptions: ApiExceptions.error,
            message: 'Oops something went wrong, Try again'));
      default:
        log(jsonDecode(response.body).toString(),
            name: 'Error: ${response.statusCode}');
        return Left(ApiResponse(
            exceptions: ApiExceptions.error,
            message: 'Something went wrong, Try again'));
    }
  }
}
