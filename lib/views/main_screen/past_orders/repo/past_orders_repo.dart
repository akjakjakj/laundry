import 'package:either_dart/either.dart';
import 'package:laundry/services/api_reponse.dart';
import 'package:laundry/services/get_it.dart';
import 'package:laundry/services/http_req.dart';
import 'package:laundry/utils/enums.dart';
import 'package:laundry/views/main_screen/past_orders/model/past_orders_response_model.dart';

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
}
