import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';
import 'package:laundry/services/api_reponse.dart';
import 'package:laundry/services/get_it.dart';
import 'package:laundry/services/helpers.dart';
import 'package:laundry/services/provider_helper_class.dart';
import 'package:laundry/utils/enums.dart';
import 'package:laundry/views/cart/model/cart_model.dart';
import 'package:laundry/views/cart/repo/cart_repo.dart';

class CartViewProvider extends ChangeNotifier with ProviderHelperClass {
  Helpers helpers = sl.get<Helpers>();
  CartRepo cartReposi = sl.get<CartRepo>();

  CartModel? cartNomalResponse;
  CartModel? cartExpressResponse;

  Future<void> getNormalService() async {
    final network = await helpers.isInternetAvailable();
    Future<Either<ApiResponse, dynamic>>? resp;
    if (network) {
      updateLoadState(LoaderState.loading);
      resp = cartReposi.getNormalSerive().thenRight((right) {
        cartNomalResponse = right;
        updateNormalService(cartNomalResponse);
        return Right(right);
      }).thenLeft((left) {
        updateLoadState(LoaderState.error);
        return Left(ApiResponse(exceptions: ApiExceptions.error));
      }).onError((error, stackTrace) {
        updateLoadState(LoaderState.error);
        return Left(ApiResponse(exceptions: ApiExceptions.error));
      });
    }
  }

  void updateNormalService(CartModel? cartNormalServiceResponse) {
    if (cartNormalServiceResponse?.cart != null) {
      updateLoadState(LoaderState.loaded);
    } else {
      updateLoadState(LoaderState.noData);
    }
  }

  Future<void> getExpressService() async {
    final network = await helpers.isInternetAvailable();
    Future<Either<ApiResponse, dynamic>>? resp;
    if (network) {
      updateLoadState(LoaderState.loading);
      resp = cartReposi.getExpressSerive().thenRight((right) {
        cartExpressResponse = right;
        updateNormalService(cartExpressResponse);
        return Right(right);
      }).thenLeft((left) {
        updateLoadState(LoaderState.error);
        return Left(ApiResponse(exceptions: ApiExceptions.error));
      }).onError((error, stackTrace) {
        updateLoadState(LoaderState.error);
        return Left(ApiResponse(exceptions: ApiExceptions.error));
      });
    }
  }

  void updateExpressService(CartModel? cartExpressServiceResponse) {
    if (cartExpressResponse?.cart != null) {
      updateLoadState(LoaderState.loaded);
    } else {
      updateLoadState(LoaderState.noData);
    }
  }

  @override
  void updateLoadState(LoaderState state) {
    loaderState = state;
    notifyListeners();
  }
}
