import 'package:either_dart/either.dart';
import 'package:laundry/services/api_reponse.dart';
import 'package:laundry/services/get_it.dart';
import 'package:laundry/services/http_req.dart';
import 'package:laundry/utils/enums.dart';
import 'package:laundry/views/authentication/model/registration_request_model.dart';
import 'package:laundry/views/authentication/model/user_model.dart';

class RegistrationRepo {
  HttpReq httpReq = sl.get<HttpReq>();

  Future<Either<ApiResponse, dynamic>> register(
      RegistrationRequestModel registrationRequestModel) async {
    return httpReq.postRequest('/api/customer/signup', param: {
      'name': registrationRequestModel.name,
      'email': registrationRequestModel.email,
      'password': registrationRequestModel.password,
      'device_token': registrationRequestModel.deviceToken,
      'password_confirmation': registrationRequestModel.confirmPassword,
      'mobile_number': registrationRequestModel.mobileNumber
    }).thenRight((right) {
      final userModel = UserData.fromJson(right);
      return Right(userModel);
    }).thenLeft((left) {
      return Left(left);
    }).onError((error, stackTrace) {
      return Left(ApiResponse(exceptions: ApiExceptions.networkError));
    });
  }
}
