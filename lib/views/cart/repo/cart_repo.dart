import 'package:either_dart/either.dart';
import 'package:laundry/services/api_reponse.dart';
import 'package:laundry/services/get_it.dart';
import 'package:laundry/services/http_req.dart';
import 'package:laundry/utils/enums.dart';
import 'package:laundry/views/cart/model/cart_model.dart';

class CartRepo {
  HttpReq httpReq = sl.get<HttpReq>();

  Future<Either<ApiResponse, dynamic>> getNormalSerive() async {
    return httpReq
        .postRequest('/api/customer/cart?service_type=normal')
        .thenRight((right) {
          final normalServices = CartModel.fromJson(right);
          return Right(normalServices);
        })
        .thenLeft((left) => Left(left))
        .onError((error, stackTrace) {
          return Left(ApiResponse(exceptions: ApiExceptions.networkError));
        });
  }

  Future<Either<ApiResponse, dynamic>> getExpressSerive() async {
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
}
