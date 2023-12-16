import 'package:either_dart/either.dart';
import 'package:laundry/services/api_reponse.dart';
import 'package:laundry/services/get_it.dart';
import 'package:laundry/services/http_req.dart';
import 'package:laundry/utils/enums.dart';
import 'package:laundry/views/manage_address/model/add_address_request_model.dart';
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

  Future<Either<ApiResponse, dynamic>> removeAddress(int addressId) async {
    return httpReq
        .postRequest('/api/customer/addresses/remove',
            param: {'address_id': addressId})
        .thenRight((right) => Right(right))
        .thenLeft((left) => Left(left))
        .onError((error, stackTrace) {
          return Left(ApiResponse(exceptions: ApiExceptions.networkError));
        });
  }

  Future<Either<ApiResponse, dynamic>> addAddress(
      AddAddressRequestModel addAddressRequestModel) async {
    return httpReq
        .postRequest('/api/customer/add-address?address', param: {
          'address': addAddressRequestModel.address,
          'city': addAddressRequestModel.city,
          'state': addAddressRequestModel.state,
          'country': addAddressRequestModel.country,
          'postal_code': addAddressRequestModel.postalCode,
          'latitude': addAddressRequestModel.latitude,
          'longitude': addAddressRequestModel.longitude
        })
        .thenRight((right) => Right(right))
        .thenLeft((left) => Left(left))
        .onError((error, stackTrace) {
          return Left(ApiResponse(exceptions: ApiExceptions.networkError));
        });
  }

  Future<Either<ApiResponse, dynamic>> setDefaultAddress(int addressId) async {
    return httpReq
        .postRequest('/api/customer/addresses/default/set',
            param: {'address_id': addressId})
        .thenRight((right) => Right(right))
        .thenLeft((left) => Left(left))
        .onError((error, stackTrace) {
          return Left(ApiResponse(exceptions: ApiExceptions.networkError));
        });
  }
}
