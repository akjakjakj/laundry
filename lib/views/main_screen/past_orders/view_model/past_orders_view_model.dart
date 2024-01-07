import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';
import 'package:laundry/services/api_reponse.dart';
import 'package:laundry/services/get_it.dart';
import 'package:laundry/services/helpers.dart';
import 'package:laundry/services/provider_helper_class.dart';
import 'package:laundry/utils/enums.dart';
import 'package:laundry/views/main_screen/past_orders/model/order_details_model.dart';
import 'package:laundry/views/main_screen/past_orders/model/past_orders_response_model.dart';
import 'package:laundry/views/main_screen/past_orders/repo/past_orders_repo.dart';

class PastOrdersProvider extends ChangeNotifier with ProviderHelperClass {
  Helpers helpers = sl.get<Helpers>();
  PastOrdersRepo pastOrdersRepo = PastOrdersRepo();

  PastOrdersResponse? pastOrdersResponse;
  OrderDetailsModel? orderDetailsModel;

  List<Orders> ordersList = [];

  Future<void> getPastOrders() async {
    final network = await helpers.isInternetAvailable();
    Future<Either<ApiResponse, dynamic>>? resp;
    if (network) {
      updateLoadState(LoaderState.loading);
      try {
        resp = pastOrdersRepo.getPastOrders().thenRight((right) {
          pastOrdersResponse = right;
          updateOrdersList(pastOrdersResponse);
          return Right(right);
        }).thenLeft((left) {
          updateLoadState(LoaderState.error);
          return Left(ApiResponse(exceptions: ApiExceptions.error));
        }).onError((error, stackTrace) {
          updateLoadState(LoaderState.error);
          return Left(ApiResponse(exceptions: ApiExceptions.error));
        });
      } catch (e) {
        updateBtnLoaderState(false);
        updateLoadState(LoaderState.error);
      }
    } else {
      helpers
          .errorToast('Network Error... Please check your internet connection');
    }
  }

  Future<void> getOrderDetails(int orderId) async {
    final network = await helpers.isInternetAvailable();
    Future<Either<ApiResponse, dynamic>>? resp;
    if (network) {
      updateLoadState(LoaderState.loading);
      try {
        resp = pastOrdersRepo.getOrderDetails(orderId).thenRight((right) {
          orderDetailsModel = right;
          if (orderDetailsModel?.status ?? false) {
            updateLoadState(LoaderState.loaded);
          } else {
            updateLoadState(LoaderState.error);
          }
          return Right(right);
        }).thenLeft((left) {
          updateLoadState(LoaderState.error);
          return Left(ApiResponse(exceptions: ApiExceptions.error));
        }).onError((error, stackTrace) {
          updateLoadState(LoaderState.error);
          return Left(ApiResponse(exceptions: ApiExceptions.error));
        });
      } catch (e) {
        updateBtnLoaderState(false);
        updateLoadState(LoaderState.error);
      }
    } else {
      helpers
          .errorToast('Network Error... Please check your internet connection');
    }
  }

  updateOrdersList(PastOrdersResponse? pastOrdersResponse) {
    ordersList = pastOrdersResponse?.orders ?? [];
    if (ordersList.isNotEmpty) {
      updateLoadState(LoaderState.loaded);
    } else {
      updateLoadState(LoaderState.noData);
    }

    notifyListeners();
  }

  @override
  void updateLoadState(LoaderState state) {
    loaderState = state;
    notifyListeners();
  }
}
