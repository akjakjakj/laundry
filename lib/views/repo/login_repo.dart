import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:laundry/services/api_reponse.dart';
import 'package:laundry/services/get_it.dart';
import 'package:laundry/services/http_req.dart';
import 'package:laundry/utils/enums.dart';
import 'package:laundry/views/authentication/model/user_model.dart';

class LoginRepo {
  HttpReq httpReq = sl.get<HttpReq>();

  Future<Either<ApiResponse, dynamic>> login(
      {String? email, String? password, String? deviceToken}) async {
    return httpReq.postRequest('/api/customer/signin', param: {
      'email': email,
      'password': password,
      'device_token': deviceToken
    }).thenRight((right) {
      debugPrint(right.toString());
      final userModel = UserData.fromJson(right);
      return Right(userModel);
    }).thenLeft((left) {
      return Left(left);
    }).onError((error, stackTrace) {
      return Left(ApiResponse(exceptions: ApiExceptions.networkError));
    });
  }
}
