import 'package:either_dart/either.dart';
import 'package:laundry/services/api_reponse.dart';
import 'package:laundry/services/get_it.dart';
import 'package:laundry/services/http_req.dart';
import 'package:laundry/utils/enums.dart';
import 'package:laundry/views/manage_address/model/manage_address_response_model.dart';

class ManageAddressRepo {
  HttpReq httpReq = sl.get<HttpReq>();

  Future<Either<ApiResponse, dynamic>> getAddress() async {
    return httpReq
        .getRequest('/api/customer/addresses')
        .thenRight((right) {
          final manageAddress = ManageAddressResponse.fromJson(right);
          return Right(manageAddress);
        })
        .thenLeft((left) => Left(left))
        .onError((error, stackTrace) {
          return Left(ApiResponse(exceptions: ApiExceptions.networkError));
        });
  }
}
