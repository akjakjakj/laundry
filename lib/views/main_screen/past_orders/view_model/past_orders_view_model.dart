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

  String? adminCommentStatus;
  String? message;

  bool? btnLoader = false;

  Future<void> getPastOrders() async {
    updateLoadState(LoaderState.loading);
    final network = await helpers.isInternetAvailable();
    Future<Either<ApiResponse, dynamic>>? resp;
    if (network) {
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
    if (network) {
      updateLoadState(LoaderState.loading);
      try {
        pastOrdersRepo.getOrderDetails(orderId).thenRight((right) {
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

  Future<void> updateAdminCommentStatus(
      {required String orderId,
      required String status,
      Function()? onSuccess,
      Function()? onFailure}) async {
    final network = await helpers.isInternetAvailable();
    updateBtnLoader(true);
    try {
      pastOrdersRepo.updateAdminComments(orderId: orderId, status: status).fold(
          (left) {
        updateBtnLoader(false);
        updateMessage(left.message ?? 'Oops... Something went wrong');
        if (onFailure != null) onFailure();
      }, (right) {
        updateBtnLoader(false);
        updateMessage(right.message ?? 'Successfully updated');
        if (onSuccess != null) onSuccess();
      });
    } catch (e) {
      updateBtnLoaderState(false);
      updateLoadState(LoaderState.error);
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

  void updateBtnLoader(bool value) {
    btnLoader = value;
    notifyListeners();
  }

  void updateMessage(String msg) {
    message = msg;
    notifyListeners();
  }

  @override
  void updateLoadState(LoaderState state) {
    loaderState = state;
    notifyListeners();
  }
}
