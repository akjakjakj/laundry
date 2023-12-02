import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';
import 'package:laundry/services/api_reponse.dart';
import 'package:laundry/services/get_it.dart';
import 'package:laundry/services/helpers.dart';
import 'package:laundry/services/provider_helper_class.dart';
import 'package:laundry/utils/enums.dart';
import 'package:laundry/views/manage_address/model/add_address_request_model.dart';
import 'package:laundry/views/manage_address/model/manage_address_response_model.dart';
import 'package:laundry/views/manage_address/repo/manage_address_repo.dart';
import 'package:location/location.dart';

class ManageAddressProvider extends ChangeNotifier with ProviderHelperClass {
  Helpers helpers = sl.get<Helpers>();
  ManageAddressRepo manageAddressRepo = sl.get<ManageAddressRepo>();

  ManageAddressResponse? manageAddressResponse;
  List<Addresses> addressesList = [];

  String? errorMessage;

  TextEditingController addressEditingController = TextEditingController();
  TextEditingController addressCityController = TextEditingController();
  TextEditingController addressStateController = TextEditingController();

  LocationData? locationData;

  Future<void> getAddress({Function()? onSuccess}) async {
    final network = await helpers.isInternetAvailable();
    Future<Either<ApiResponse, dynamic>>? resp;
    if (network) {
      updateLoadState(LoaderState.loading);
      resp = manageAddressRepo.getAddress().thenRight((right) {
        manageAddressResponse = right;
        updateAddressList(manageAddressResponse);
        if (onSuccess != null) onSuccess();
        return Right(right);
      }).thenLeft((left) {
        updateLoadState(LoaderState.error);
        return Left(ApiResponse(exceptions: ApiExceptions.error));
      }).onError((error, stackTrace) {
        updateLoadState(LoaderState.error);
        return Left(ApiResponse(exceptions: ApiExceptions.error));
      });
    } else {
      helpers
          .errorToast('Network Error... Please check your internet connection');
    }
  }

  Future<void> removeAddress(int addressId) async {
    final network = await helpers.isInternetAvailable();
    Future<Either<ApiResponse, dynamic>>? resp;
    if (network) {
      updateLoadState(LoaderState.loading);
      resp = manageAddressRepo.removeAddress(addressId).thenRight((right) {
        if (right['status']) {
          getAddress();
        }
        return Right(right);
      }).thenLeft((left) {
        updateErrorMessage(left.message ?? '');
        updateLoadState(LoaderState.loaded);
        return Left(ApiResponse(exceptions: ApiExceptions.error));
      }).onError((error, stackTrace) {
        updateLoadState(LoaderState.error);
        return Left(ApiResponse(exceptions: ApiExceptions.error));
      });
    } else {
      helpers
          .errorToast('Network Error... Please check your internet connection');
    }
  }

  Future<void> addAddress(
      {Function()? onSuccess, Function()? onFailure}) async {
    final network = await helpers.isInternetAvailable();
    Future<Either<ApiResponse, dynamic>>? resp;
    if (network) {
      updateLoadState(LoaderState.loading);
      AddAddressRequestModel addAddressRequestModel = AddAddressRequestModel(
          address: addressEditingController.text.trim(),
          city: addressCityController.text.trim(),
          country: addressEditingController.text.trim(),
          postalCode: 0,
          latitude: locationData?.latitude,
          longitude: locationData?.longitude);
      resp = manageAddressRepo
          .addAddress(addAddressRequestModel)
          .thenRight((right) {
        if (right['status']) {
          if (onSuccess != null) onSuccess();
        }
        return Right(right);
      }).thenLeft((left) {
        updateErrorMessage(left.message ?? '');
        updateLoadState(LoaderState.loaded);
        return Left(ApiResponse(exceptions: ApiExceptions.error));
      }).onError((error, stackTrace) {
        updateLoadState(LoaderState.error);
        return Left(ApiResponse(exceptions: ApiExceptions.error));
      });
    } else {
      helpers
          .errorToast('Network Error... Please check your internet connection');
    }
  }

  Future<void> getLocation() async {
    Location location = Location();
    locationData = await location.getLocation();
    print(locationData?.longitude);
    notifyListeners();
  }

  void updateAddressList(ManageAddressResponse? manageAddressResponse) {
    addressesList = manageAddressResponse?.addresses ?? [];
    if (addressesList.isNotEmpty) {
      updateLoadState(LoaderState.loaded);
    } else {
      updateLoadState(LoaderState.noData);
    }
  }

  void updateErrorMessage(String msg) {
    errorMessage = msg;
    notifyListeners();
  }

  void clearAddressControllers() {
    addressCityController.clear();
    addressEditingController.clear();
    addressStateController.clear();
    notifyListeners();
  }

  @override
  void updateBtnLoaderState(bool val) {
    btnLoaderState = val;
    super.updateBtnLoaderState(val);
  }

  @override
  void updateLoadState(LoaderState state) {
    loaderState = state;
    notifyListeners();
  }
}
