import 'package:either_dart/either.dart';
import 'package:laundry/services/api_reponse.dart';
import 'package:laundry/services/get_it.dart';
import 'package:laundry/services/http_req.dart';
import 'package:laundry/utils/enums.dart';
import 'package:laundry/views/cart/model/cart_model.dart';

class CartRepo {
  HttpReq httpReq = sl.get<HttpReq>();

  Future<Either<ApiResponse, dynamic>> getNormalService() async {
    return httpReq
        .postRequest('/api/customer/cart?service_type=normal')
        .thenRight((right) {
          final normalServices = CartModel.fromJson(right);
          return Right(normalServices);
        })
        .thenLeft((left) {
          return Left(left);
    } )
        .onError((error, stackTrace) {
          return Left(ApiResponse(exceptions: ApiExceptions.networkError));
        });
  }

  Future<Either<ApiResponse, dynamic>> getExpressService() async {
    return httpReq
        .postRequest('/api/customer/cart?service_type=express')
        .thenRight((right) {
          final normalServices = CartModel.fromJson(right);
          return Right(normalServices);
        })
        .thenLeft((left) => Left(left))
        .onError((error, stackTrace) {
          return Left(ApiResponse(exceptions: ApiExceptions.networkError));
        });
  }

  Future<Either<ApiResponse, dynamic>> updateCart(
      {required int cartId, required int quantity}) async {
    return httpReq
        .postRequest('/api/customer/cart/update',
            param: {'cart_id': cartId, 'quantity': quantity})
        .thenRight((right) => Right(right))
        .thenLeft((left) => Left(left))
        .onError((error, stackTrace) {
          return Left(ApiResponse(exceptions: ApiExceptions.networkError));
        });
  }

  Future<Either<ApiResponse, dynamic>> removeCart(int cartId) async {
    return httpReq
        .postRequest('/api/customer/cart/remove', param: {'cart_id': cartId})
        .thenRight((right) => Right(right))
        .thenLeft((left) => Left(left))
        .onError((error, stackTrace) {
          return Left(ApiResponse(exceptions: ApiExceptions.networkError));
        });
  }
}
