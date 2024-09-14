import 'package:either_dart/either.dart';
import 'package:laundry/services/api_reponse.dart';
import 'package:laundry/services/get_it.dart';
import 'package:laundry/services/http_req.dart';
import 'package:laundry/utils/enums.dart';
import 'package:laundry/views/main_screen/past_orders/model/order_details_model.dart';
import 'package:laundry/views/main_screen/past_orders/model/past_orders_response_model.dart';
import 'package:laundry/views/main_screen/past_orders/model/payment_response.dart';

class PastOrdersRepo {
  HttpReq httpReq = sl.get<HttpReq>();

  Future<Either<ApiResponse, dynamic>> getPastOrders() async {
    return httpReq
        .getRequest('/api/customer/orders')
        .thenRight((right) {
          final pastOrdersResponse = PastOrdersResponse.fromJson(right);
          return Right(pastOrdersResponse);
        })
        .thenLeft((left) => Left(left))
        .onError((error, stackTrace) {
          return Left(ApiResponse(exceptions: ApiExceptions.networkError));
        });
  }

  Future<Either<ApiResponse, dynamic>> getActiveOrders() async {
    return httpReq
        .getRequest('/api/customer/active-orders')
        .thenRight((right) {
          final pastOrdersResponse = PastOrdersResponse.fromJson(right);
          return Right(pastOrdersResponse);
        })
        .thenLeft((left) => Left(left))
        .onError((error, stackTrace) {
          return Left(ApiResponse(exceptions: ApiExceptions.networkError));
        });
  }

  Future<Either<ApiResponse, dynamic>> getOrderDetails(int orderId) async {
    return httpReq
        .postRequest('/api/customer/orders/details',
            param: {'order_id': orderId})
        .thenRight((right) {
          final orderDetailsResponse = OrderDetailsModel.fromJson(right);
          return Right(orderDetailsResponse);
        })
        .thenLeft((left) => Left(left))
        .onError((error, stackTrace) {
          return Left(ApiResponse(exceptions: ApiExceptions.networkError));
        });
  }

  Future<Either<ApiResponse, dynamic>> updateTransactionDetails(
      PaymentRequestModel paymentRequestModel) {
    return httpReq
        .postRequest('/api/pos/orders/payment',
            param: paymentRequestModel.toJson())
        .thenRight((right) => Right(right))
        .thenLeft((left) {
      return Left(left);
    }).onError((error, stackTrace) {
      return Left(ApiResponse(exceptions: ApiExceptions.networkError));
    });
  }
}
