import 'package:either_dart/either.dart';
import 'package:laundry/services/api_reponse.dart';
import 'package:laundry/services/get_it.dart';
import 'package:laundry/services/http_req.dart';
import 'package:laundry/utils/enums.dart';
import 'package:laundry/views/profile/model/profile_model.dart';

class ProfileRepo {
  HttpReq httpReq = sl.get<HttpReq>();

  Future<Either<ApiResponse, dynamic>> getProfile() async {
    return httpReq
        .getRequest('/api/customer/profile')
        .thenRight((right) {
          final manageAddress = ProfileModel.fromJson(right);
          return Right(manageAddress);
        })
        .thenLeft((left) => Left(left))
        .onError((error, stackTrace) {
          return Left(ApiResponse(exceptions: ApiExceptions.networkError));
        });
  }

  Future<Either<ApiResponse, dynamic>> deleteProfile() async {
    return httpReq
        .postRequest('/api/customer/profile/delete')
        .thenRight(
          (right) => Right(right),
        )
        .thenLeft((left) => Left(left))
        .onError((error, stackTrace) {
      return Left(ApiResponse(exceptions: ApiExceptions.networkError));
    });
  }
}
