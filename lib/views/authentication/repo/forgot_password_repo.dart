import 'package:either_dart/either.dart';
import 'package:laundry/services/api_reponse.dart';
import 'package:laundry/services/get_it.dart';
import 'package:laundry/services/http_req.dart';
import 'package:laundry/utils/enums.dart';

class ForgotPasswordRepo {
  HttpReq httpReq = sl.get<HttpReq>();

  Future<Either<ApiResponse, dynamic>> requestForgotPasswordOtp(
      String email) async {
    return httpReq
        .postRequest('/api/customer/forgot-password', param: {'email': email})
        .thenRight((right) {
          return Right(right);
        })
        .thenLeft((left) => Left(left))
        .onError((error, stackTrace) {
          return Left(ApiResponse(exceptions: ApiExceptions.networkError));
        });
  }

  Future<Either<ApiResponse, dynamic>> verifyForgotPasswordOtp(
      String email, String otp) async {
    return httpReq
        .postRequest('/api/customer/verify-password-otp',
            param: {'email': email, 'otp': otp})
        .thenRight((right) {
          return Right(right);
        })
        .thenLeft((left) => Left(left))
        .onError((error, stackTrace) =>
            Left(ApiResponse(exceptions: ApiExceptions.networkError)));
  }

  Future<Either<ApiResponse, dynamic>> resetPassword(
      {required String email,
      required String password,
      required String confirmPassword}) async {
    return httpReq
        .postRequest('/api/customer/reset-password', param: {
          'email': email,
          'password': password,
          'password_confirmation': confirmPassword
        })
        .thenRight((right) {
          return Right(right);
        })
        .thenLeft((left) => Left(left))
        .onError((error, stackTrace) =>
            Left(ApiResponse(exceptions: ApiExceptions.networkError)));
  }
}
