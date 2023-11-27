import 'package:either_dart/either.dart';
import 'package:flutter/foundation.dart';
import 'package:laundry/services/api_reponse.dart';
import 'package:laundry/services/get_it.dart';
import 'package:laundry/services/http_req.dart';
import 'package:laundry/services/shared_preference_helper.dart';
import 'package:laundry/utils/enums.dart';
import 'package:laundry/views/main_screen/home_screen/model/categories_model.dart';
import 'package:laundry/views/main_screen/home_screen/model/services_model.dart';

class HomeRepo {
  HttpReq httpReq = sl.get<HttpReq>();
  SharedPreferencesHelper sharedPreferencesHelper =
      sl.get<SharedPreferencesHelper>();

  Future<Either<ApiResponse, dynamic>> getServices() async {
    return httpReq
        .getRequest(
      '/api/customer/services',
    )
        .thenRight((right) {
      final servicesResponse = ServicesResponseModel.fromJson(right);
      return Right(servicesResponse);
    }).thenLeft((left) {
      debugPrint(left.toString());
      return Left(left);
    }).onError((error, stackTrace) {
      return Left(ApiResponse(exceptions: ApiExceptions.networkError));
    });
  }

  Future<Either<ApiResponse, dynamic>> getCategories() async {
    return httpReq
        .getRequest(
      '/api/customer/categories',
    )
        .thenRight((right) {
      final categoriesResponse = CategoriesResponseModel.fromJson(right);
      return Right(categoriesResponse);
    }).thenLeft((left) {
      debugPrint(left.toString());
      return Left(left);
    }).onError((error, stackTrace) {
      return Left(ApiResponse(exceptions: ApiExceptions.networkError));
    });
  }
}
