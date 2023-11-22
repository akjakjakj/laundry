import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:http/http.dart' as http;
import 'package:laundry/services/api_reponse.dart';
import 'package:laundry/services/get_it.dart';
import 'package:laundry/services/helpers.dart';
import 'package:laundry/utils/enums.dart';

class HttpReq {
  Helpers helpers = sl.get<Helpers>();

  final String _appJson = 'application/json';

  Future<Either<ApiResponse, dynamic>> getRequest(String endPoint) async {
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
          'client-Id': '7608959366',
          'secret-key': 'c0r5W8Hi96q8EQlg3kOLZ8QTiIY2kI',
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
          'client-Id': '7608959366',
          'secret-key': 'c0r5W8Hi96q8EQlg3kOLZ8QTiIY2kI',
        },
      ).timeout(const Duration(seconds: 60));
      return _returnResponse(response, endPoint);
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
