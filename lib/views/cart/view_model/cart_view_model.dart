import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laundry/common/extensions.dart';
import 'package:laundry/services/api_reponse.dart';
import 'package:laundry/services/get_it.dart';
import 'package:laundry/services/helpers.dart';
import 'package:laundry/services/provider_helper_class.dart';
import 'package:laundry/services/shared_preference_helper.dart';
import 'package:laundry/utils/enums.dart';
import 'package:laundry/views/cart/model/cart_model.dart';
import 'package:laundry/views/cart/repo/cart_repo.dart';

class CartViewProvider extends ChangeNotifier with ProviderHelperClass {
  Helpers helpers = sl.get<Helpers>();
  CartRepo cartRepo = sl.get<CartRepo>();
  SharedPreferencesHelper sharedPreferencesHelper =
      sl.get<SharedPreferencesHelper>();

  CartModel? cartNormalResponse;
  CartModel? cartExpressResponse;

  Map<String, dynamic>? defaultAddress;
  List<List<int>> imageFilesList = [];

  Future<void> getNormalService(
      {bool enableLoader = true, bool enableBtnLoader = false}) async {
    final network = await helpers.isInternetAvailable();
    Future<Either<ApiResponse, dynamic>>? resp;
    if (network) {
      if (enableLoader) updateLoadState(LoaderState.loading);
      if (enableBtnLoader) updateBtnLoaderState(true);
      resp = cartRepo.getNormalService().thenRight((right) {
        cartNormalResponse = right;
        updateNormalService(cartNormalResponse);
        return Right(right);
      }).thenLeft((left) {
        updateLoadState(LoaderState.error);
        updateBtnLoaderState(false);
        return Left(ApiResponse(exceptions: ApiExceptions.error));
      }).onError((error, stackTrace) {
        updateLoadState(LoaderState.error);
        updateBtnLoaderState(false);
        return Left(ApiResponse(exceptions: ApiExceptions.error));
      });
    } else {
      helpers
          .errorToast('Network Error... Please check your internet connection');
    }
  }

  void updateNormalService(CartModel? cartNormalServiceResponse) {
    if ((cartNormalServiceResponse?.cart ?? []).notEmpty) {
      updateLoadState(LoaderState.loaded);
      updateBtnLoaderState(false);
    } else {
      updateLoadState(LoaderState.noData);
      updateBtnLoaderState(false);
    }
  }

  Future<void> getExpressService(
      {bool enableLoader = true, bool enableBtnLoader = false}) async {
    final network = await helpers.isInternetAvailable();
    Future<Either<ApiResponse, dynamic>>? resp;
    if (network) {
      if (enableLoader) updateLoadState(LoaderState.loading);
      if (enableBtnLoader) updateBtnLoaderState(true);
      resp = cartRepo.getExpressService().thenRight((right) {
        cartNormalResponse = right;
        updateNormalService(cartNormalResponse);
        return Right(right);
      }).thenLeft((left) {
        updateLoadState(LoaderState.error);
        updateBtnLoaderState(false);
        return Left(ApiResponse(exceptions: ApiExceptions.error));
      }).onError((error, stackTrace) {
        updateLoadState(LoaderState.error);
        updateBtnLoaderState(false);
        return Left(ApiResponse(exceptions: ApiExceptions.error));
      });
    } else {
      helpers
          .errorToast('Network Error... Please check your internet connection');
    }
  }

  Future<void> updateCart(
      {required int cartId,
      required int quantity,
      Function()? onSuccess,
      Function()? onFailure}) async {
    final network = await helpers.isInternetAvailable();
    Future<Either<ApiResponse, dynamic>>? resp;
    updateBtnLoaderState(true);
    if (network) {
      try {
        resp = cartRepo
            .updateCart(cartId: cartId, quantity: quantity)
            .thenRight((right) {
          if (right['status']) {
            if (onSuccess != null) onSuccess();
          }
          return Right(right);
        }).thenLeft((left) {
          updateLoadState(LoaderState.error);
          updateBtnLoaderState(false);
          if (onFailure != null) onFailure();
          return Left(ApiResponse(exceptions: ApiExceptions.error));
        }).onError((error, stackTrace) {
          updateLoadState(LoaderState.error);
          updateBtnLoaderState(false);
          return Left(ApiResponse(exceptions: ApiExceptions.error));
        });
      } catch (e) {
        updateBtnLoaderState(false);
        //'Login $e'.log(name: 'LoginProvider');
        updateLoadState(LoaderState.error);
      }
    } else {
      helpers
          .errorToast('Network Error... Please check your internet connection');
    }
  }

  Future<void> removeFromCart(int cartId,
      {Function()? onSuccess, Function()? onFailure}) async {
    final network = await helpers.isInternetAvailable();
    Future<Either<ApiResponse, dynamic>>? resp;
    updateBtnLoaderState(true);
    if (network) {
      try {
        resp = cartRepo.removeCart(cartId).thenRight((right) {
          if (right['status']) {
            if (onSuccess != null) onSuccess();
          }
          return Right(right);
        }).thenLeft((left) {
          updateLoadState(LoaderState.error);
          if (onFailure != null) onFailure();
          return Left(ApiResponse(exceptions: ApiExceptions.error));
        }).onError((error, stackTrace) {
          updateLoadState(LoaderState.error);
          updateBtnLoaderState(false);
          return Left(ApiResponse(exceptions: ApiExceptions.error));
        });
      } catch (e) {
        updateBtnLoaderState(false);
        //'Login $e'.log(name: 'LoginProvider');
        updateLoadState(LoaderState.error);
        updateBtnLoaderState(false);
      }
    } else {
      helpers
          .errorToast('Network Error... Please check your internet connection');
    }
  }

  void updateExpressService(CartModel? cartExpressServiceResponse) {
    if (cartExpressResponse?.cart != null) {
      updateLoadState(LoaderState.loaded);
    } else {
      updateLoadState(LoaderState.noData);
    }
  }

  void getDefaultAddress() async {
    defaultAddress = await sharedPreferencesHelper.getDefaultAddress();
    notifyListeners();
  }

  Future getImageFromGallery() async {
    final pickedFile = await ImagePicker().pickMultiImage();
    if (pickedFile.notEmpty) {
      for (int i = 0; i < pickedFile.length; i++) {
        imageFilesList = [
          ...imageFilesList,
          File(pickedFile[i].path).readAsBytesSync()
        ];
      }
    }
    notifyListeners();
  }

  Future getImageFromCamera() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      imageFilesList = [
        ...imageFilesList,
        File(pickedFile.path).readAsBytesSync()
      ];
    }
    notifyListeners();
  }

  removeImageFromList(int index) {
    for (int i = 0; i < imageFilesList.length;) {
      List<List<int>> tempImageFiles = List.from(imageFilesList);
      tempImageFiles.removeAt(index);
      imageFilesList = tempImageFiles;
      break;
    }
    notifyListeners();
  }

  @override
  void updateLoadState(LoaderState state) {
    loaderState = state;
    notifyListeners();
  }

  @override
  void updateBtnLoaderState(bool val) {
    btnLoaderState = val;
    notifyListeners();
    super.updateBtnLoaderState(val);
  }
}
