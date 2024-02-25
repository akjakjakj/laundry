import 'package:either_dart/either.dart';
import 'package:laundry/services/api_reponse.dart';
import 'package:laundry/services/get_it.dart';
import 'package:laundry/services/http_req.dart';
import 'package:laundry/services/shared_preference_helper.dart';
import 'package:laundry/utils/enums.dart';
import 'package:laundry/views/eco_dry_clean/model/add_to_cart_model.dart';
import 'package:laundry/views/eco_dry_clean/model/products_response_model.dart';
import 'package:laundry/views/main_screen/home_screen/model/categories_model.dart';

class EcoDryCleanRepo {
  HttpReq httpReq = sl.get<HttpReq>();
  SharedPreferencesHelper sharedPreferencesHelper =
      sl.get<SharedPreferencesHelper>();

  Future<Either<ApiResponse, dynamic>> getProducts(int categoryId) async {
    return httpReq.postRequest('/api/customer/products',
        param: {'category_id': categoryId}).thenRight((right) {
      final productsResponseModel = ProductsResponseModel.fromJson(right);
      return Right(productsResponseModel);
    }).thenLeft((left) {
      return Left(left);
    }).onError((error, stackTrace) {
      return Left(ApiResponse(exceptions: ApiExceptions.networkError));
    });
  }

  Future<Either<ApiResponse, dynamic>> getProductsWithSearch(
      int categoryId, String keyword) async {
    return httpReq.postRequest('/api/customer/products', param: {
      'category_id': categoryId,
      'keyword': keyword
    }).thenRight((right) {
      final productsResponseModel = ProductsResponseModel.fromJson(right);
      return Right(productsResponseModel);
    }).thenLeft((left) {
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
      return Left(left);
    }).onError((error, stackTrace) {
      return Left(ApiResponse(exceptions: ApiExceptions.networkError));
    });
  }

  Future<Either<ApiResponse, dynamic>> addToCart(
      AddToCartModel addToCartModel) async {
    return httpReq
        .postRequest('/api/customer/cart/add', param: {
          'service_id': addToCartModel.serviceId,
          'category_id': addToCartModel.categoryId,
          'product_id': addToCartModel.productId,
          'quantity': addToCartModel.quantity,
          'rate': addToCartModel.rate
        })
        .thenRight((right) => Right(right))
        .thenLeft((left) => Left(left))
        .onError((error, stackTrace) {
          return Left(ApiResponse(exceptions: ApiExceptions.networkError));
        });
  }

  Future<Either<ApiResponse, dynamic>> getPriceList(int serviceId) async {
    return httpReq
        .postRequest('/api/customer/price_list',
            param: {'service_id': serviceId})
        .thenRight((right) => Right(right))
        .thenLeft((left) => Left(left))
        .onError((error, stackTrace) {
          return Left(ApiResponse(exceptions: ApiExceptions.networkError));
        });
  }
}
