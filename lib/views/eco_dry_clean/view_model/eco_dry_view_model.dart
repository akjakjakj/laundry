import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';
import 'package:laundry/services/api_reponse.dart';
import 'package:laundry/services/get_it.dart';
import 'package:laundry/services/helpers.dart';
import 'package:laundry/services/provider_helper_class.dart';
import 'package:laundry/utils/enums.dart';
import 'package:laundry/views/eco_dry_clean/model/add_to_cart_model.dart';
import 'package:laundry/views/eco_dry_clean/model/products_response_model.dart';
import 'package:laundry/views/eco_dry_clean/repo/eco_dry_clean_repo.dart';
import 'package:laundry/views/main_screen/home_screen/model/categories_model.dart';

class EcoDryProvider extends ChangeNotifier with ProviderHelperClass {
  Helpers helpers = sl.get<Helpers>();
  EcoDryCleanRepo ecoDryCleanRepo = sl.get<EcoDryCleanRepo>();
  TextEditingController searchTexEditingController = TextEditingController();

  int? categoryId;
  int? serviceId;
  String? keyword;
  String? errorMessage;

  ProductsResponseModel? productsResponseModel;
  CategoriesResponseModel? categoriesResponseModel;

  List<Products> productsList = [];
  List<Categories> categoriesList = [];

  Future<void> getCategories() async {
    final network = await helpers.isInternetAvailable();
    Future<Either<ApiResponse, dynamic>>? resp;

    if (network) {
      updateLoadState(LoaderState.loading);
      try {
        resp = ecoDryCleanRepo.getCategories().thenRight((right) {
          categoriesResponseModel = right;
          updateCategoriesList(categoriesResponseModel);
          return Right(right);
        }).thenLeft((left) {
          debugPrint(left.toString());
          return Left(ApiResponse(exceptions: ApiExceptions.error));
        }).onError((error, stackTrace) {
          updateLoadState(LoaderState.error);
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

  Future<void> getProducts() async {
    final network = await helpers.isInternetAvailable();
    Future<Either<ApiResponse, dynamic>>? resp;
    if (network) {
      updateLoadState(LoaderState.loading);
      try {
        resp = ecoDryCleanRepo.getProducts(categoryId ?? 1).thenRight((right) {
          productsResponseModel = right;
          updateProductsList(productsResponseModel);
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
        //'Login $e'.log(name: 'LoginProvider');
        updateLoadState(LoaderState.error);
      }
    } else {
      helpers
          .errorToast('Network Error... Please check your internet connection');
    }
  }

  Future<void> getProductsWithSearch() async {
    final network = await helpers.isInternetAvailable();
    Future<Either<ApiResponse, dynamic>>? resp;
    if (network) {
      updateLoadState(LoaderState.loading);
      try {
        resp = ecoDryCleanRepo
            .getProductsWithSearch(
                categoryId ?? 1, searchTexEditingController.text.trim())
            .thenRight((right) {
          productsResponseModel = right;
          updateProductsList(productsResponseModel);
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
        //'Login $e'.log(name: 'LoginProvider');
        updateLoadState(LoaderState.error);
      }
    } else {
      helpers
          .errorToast('Network Error... Please check your internet connection');
    }
  }

  Future<void> addToCart(int productId, int quantity, double rate,
      {Function()? onSuccess, Function()? onFailure}) async {
    final network = await helpers.isInternetAvailable();
    Future<Either<ApiResponse, dynamic>>? resp;
    if (network) {
      updateBtnLoaderState(true);
      try {
        AddToCartModel addToCartModel = AddToCartModel(
            categoryId: categoryId,
            productId: productId,
            quantity: quantity,
            serviceId: serviceId,
            rate: rate);
        resp = ecoDryCleanRepo.addToCart(addToCartModel).thenRight((right) {
          if (right['status']) {
            if (onSuccess != null) onSuccess();
          }
          return Right(right);
        }).thenLeft((left) {
          updateErrorMessage(left.message ?? '');
          if (onFailure != null) onFailure();
          updateLoadState(LoaderState.loaded);
          return Left(ApiResponse(exceptions: ApiExceptions.error));
        }).onError((error, stackTrace) {
          updateLoadState(LoaderState.error);
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

  void updateCategoryId(int value) {
    categoryId = value;
    notifyListeners();
  }

  void updateErrorMessage(String msg) {
    errorMessage = msg;
    notifyListeners();
  }

  void updateCategoriesList(CategoriesResponseModel? categoriesResponseModel) {
    categoriesList = categoriesResponseModel?.categories ?? [];
    if (categoriesList.isNotEmpty) {
      updateLoadState(LoaderState.loaded);
    } else {
      updateLoadState(LoaderState.noProducts);
    }

    notifyListeners();
  }

  void updateProductsList(ProductsResponseModel? productsResponseModel) {
    productsList = productsResponseModel?.products ?? [];
    if (productsList.isNotEmpty) {
      updateLoadState(LoaderState.loaded);
    } else {
      updateLoadState(LoaderState.noProducts);
    }

    notifyListeners();
  }

  void updateServiceId(int id) {
    serviceId = id;
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
    super.updateBtnLoaderState(val);
  }
}
