import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';
import 'package:laundry/services/api_reponse.dart';
import 'package:laundry/services/get_it.dart';
import 'package:laundry/services/helpers.dart';
import 'package:laundry/services/provider_helper_class.dart';
import 'package:laundry/utils/enums.dart';
import 'package:laundry/views/manage_address/model/manage_address_response_model.dart';
import 'package:laundry/views/manage_address/repo/manage_address_repo.dart';

class ManageAddressProvider extends ChangeNotifier with ProviderHelperClass {
  Helpers helpers = sl.get<Helpers>();
  ManageAddressRepo manageAddressRepo = sl.get<ManageAddressRepo>();

  ManageAddressResponse? manageAddressResponse;
  List<Addresses> addressesList = [];

  Future<void> getAddress() async {
    final network = await helpers.isInternetAvailable();
    Future<Either<ApiResponse, dynamic>>? resp;
    if (network) {
      updateLoadState(LoaderState.loading);
      resp = manageAddressRepo.getAddress().thenRight((right) {
        manageAddressResponse = right;
        updateAddressList(manageAddressResponse);
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

  void updateAddressList(ManageAddressResponse? manageAddressResponse) {
    addressesList = manageAddressResponse?.addresses ?? [];
    if (addressesList.isNotEmpty) {
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
