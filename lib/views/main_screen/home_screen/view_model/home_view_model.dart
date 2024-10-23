import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:laundry/services/api_reponse.dart';
import 'package:laundry/services/get_it.dart';
import 'package:laundry/services/helpers.dart';
import 'package:laundry/services/provider_helper_class.dart';
import 'package:laundry/utils/enums.dart';
import 'package:laundry/views/main_screen/home_screen/model/banners_model.dart';
import 'package:laundry/views/main_screen/home_screen/model/categories_model.dart';
import 'package:laundry/views/main_screen/home_screen/model/services_model.dart';
import 'package:laundry/views/main_screen/home_screen/repo/home_screen_repo.dart';

class HomeProvider extends ChangeNotifier with ProviderHelperClass {
  Helpers helpers = sl.get<Helpers>();
  HomeRepo homeRepo = sl.get<HomeRepo>();

  ServicesResponseModel? servicesResponseModel;
  CategoriesResponseModel? categoriesResponseModel;
  HomeBanners? homeBannersModel;

  List<Services> servicesList = [];
  List<Categories> categoriesList = [];
  List<Banners> homeBanners = [];

  Future<void> getServices() async {
    final network = await helpers.isInternetAvailable();
    Future<Either<ApiResponse, dynamic>>? resp;
    if (network) {
      updateLoadState(LoaderState.loading);
      try {
        resp = homeRepo.getServices().thenRight((right) {
          debugPrint(right.toString());
          servicesResponseModel = right;
          updateServicesList(servicesResponseModel);
          return Right(right);
        }).thenLeft((left) {
          debugPrint(left.toString());
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

  Future<void> getCategories() async {
    final network = await helpers.isInternetAvailable();
    Future<Either<ApiResponse, dynamic>>? resp;
    if (network) {
      try {
        resp = homeRepo.getCategories().thenRight((right) {
          debugPrint(right.toString());
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

  Future<void> getBanners() async {
    final network = await helpers.isInternetAvailable();
    if (network) {
      try {
        homeRepo
            .getBanners()
            .fold((left) => Left(ApiResponse(exceptions: ApiExceptions.error)),
                (right) {
          homeBannersModel = right;
          updateBannersList(homeBannersModel);
        }).onError((error, stackTrace) {
          updateLoadState(LoaderState.error);
          return Left(ApiResponse(exceptions: ApiExceptions.error));
        });
      } catch (e) {
        updateBtnLoaderState(false);
        //'Login $e'.log(name: 'LoginProvider');
        updateLoadState(LoaderState.error);
      }
    }
  }

  void updateCategoriesList(CategoriesResponseModel? categoriesResponseModel) {
    categoriesList = categoriesResponseModel?.categories ?? [];
    updateLoadState(LoaderState.loaded);
    notifyListeners();
  }

  void updateBannersList(HomeBanners? homeBannersModel) {
    homeBanners = homeBannersModel?.banners ?? [];
    notifyListeners();
  }

  void updateServicesList(ServicesResponseModel? servicesResponseModel) {
    servicesList = servicesResponseModel?.services ?? [];
    updateLoadState(LoaderState.loaded);
    notifyListeners();
  }

  @override
  void updateLoadState(LoaderState state) {
    loaderState = state;
    notifyListeners();
  }
}
