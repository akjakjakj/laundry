import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:laundry/services/api_reponse.dart';
import 'package:laundry/services/get_it.dart';
import 'package:laundry/services/helpers.dart';
import 'package:laundry/services/provider_helper_class.dart';
import 'package:laundry/utils/enums.dart';
import 'package:laundry/views/manage_address/model/add_address_request_model.dart';
import 'package:laundry/views/manage_address/model/manage_address_response_model.dart';
import 'package:laundry/views/manage_address/model/map_details_model.dart';
import 'package:laundry/views/manage_address/repo/manage_address_repo.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class ManageAddressProvider extends ChangeNotifier with ProviderHelperClass {
  Helpers helpers = sl.get<Helpers>();
  ManageAddressRepo manageAddressRepo = sl.get<ManageAddressRepo>();

  ManageAddressResponse? manageAddressResponse;
  List<Addresses> addressesList = [];
  List<MapDetails> mapDetailsList = [];

  String? errorMessage;
  final String apiKey = 'AIzaSyBb2wGZE012MilJ55Pw44d9WewvBmLsZSI';
  String? name;

  TextEditingController addressEditingController = TextEditingController();
  TextEditingController addressCityController = TextEditingController();
  TextEditingController addressStateController = TextEditingController();
  TextEditingController textEditingController = TextEditingController();

  LocationData? locationData;
  LatLng? currentPosition;
  LatLng? tappedLocation;

  GoogleMapController? mapController;

  bool isButtonLoading = false;

  final Set<Marker> markers = {};

  Future<void> getAddress(
      {Function()? onSuccess, bool enableLoader = true}) async {
    final network = await helpers.isInternetAvailable();
    Future<Either<ApiResponse, dynamic>>? resp;
    if (network) {
      if (enableLoader) updateLoadState(LoaderState.loading);
      resp = manageAddressRepo.getAddress().thenRight((right) {
        manageAddressResponse = right;
        updateAddressList(manageAddressResponse);
        if (onSuccess != null) onSuccess();
        updateBtnLoaderState(false);
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

  Future<void> setDefaultAddress(int addressId,
      {Function? onSuccess, Function? onFailure}) async {
    final network = await helpers.isInternetAvailable();
    Future<Either<ApiResponse, dynamic>>? resp;
    if (network) {
      updateLoadState(LoaderState.loading);
      try {
        resp =
            manageAddressRepo.setDefaultAddress(addressId).thenRight((right) {
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
          updateBtnLoaderState(false);
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

  Future<void> getPlaceDetails(String placeId) async {
    updateIsButtonLoading(true);
    String url =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$apiKey';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Map data = json.decode(response.body)['result'];
      double lat = data['geometry']['location']['lat'];
      double lng = data['geometry']['location']['lng'];
      markers.clear();
      markers.add(
        Marker(
          markerId: MarkerId(placeId),
          position: LatLng(lat, lng),
          infoWindow: InfoWindow(
            title: name,
            snippet: name,
          ),
        ),
      );
      await mapController
          ?.animateCamera(CameraUpdate.newLatLng(LatLng(lat, lng)));
      await updateCurrentPosition(LatLng(lat, lng),
          isUpdateButtonLoading: false);
      mapDetailsList.clear();
    }
    notifyListeners();
  }

  // void handleTap(LatLng tappedPoint) {
  //   tappedLocation = tappedPoint;
  //   updateCurrentPosition(tappedPoint);
  //   markers.clear(); // Clear existing markers
  //   markers.add(
  //     Marker(
  //       markerId: MarkerId(tappedPoint.toString()),
  //       position: tappedPoint,
  //       infoWindow: InfoWindow(
  //         title: 'Marker',
  //         snippet:
  //         'Lat: ${tappedPoint.latitude}, Lng: ${tappedPoint.longitude}',
  //       ),
  //     ),
  //   );
  //   // Get location details from the tapped coordinates using reverse geocoding
  //   getLocationFromLatLng(tappedPoint);
  //   // Center the map on the tapped location
  //   mapController?.animateCamera(
  //     CameraUpdate.newLatLng(tappedPoint),
  //   );
  //   notifyListeners();
  // }

  updateCurrentPosition(LatLng position,
      {bool? isUpdateButtonLoading, Function? onSuccess}) async {
    currentPosition = position;
    if ((isUpdateButtonLoading ?? true)) updateIsButtonLoading(false);
    if (onSuccess != null) onSuccess();
    notifyListeners();
  }

  Future<void> getLocation() async {
    updateBtnLoaderState(true);
    Location location = Location();
    locationData = await location.getLocation();
    markers.clear();
    markers.add(
      Marker(
        markerId: const MarkerId('1'),
        position: LatLng(locationData?.latitude ?? 23.4241,
            locationData?.longitude ?? 53.8478),
        infoWindow: InfoWindow(
          title: name,
          snippet: name,
        ),
      ),
    );
    await mapController?.animateCamera(CameraUpdate.newLatLng(LatLng(
        locationData?.latitude ?? 23.4241,
        locationData?.longitude ?? 53.8478)));
    updateBtnLoaderState(false);
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

  updateIsButtonLoading(bool value) {
    isButtonLoading = value;
    notifyListeners();
  }

  @override
  void updateBtnLoaderState(bool val) {
    btnLoaderState = val;
    notifyListeners();
    super.updateBtnLoaderState(val);
  }

  @override
  void updateLoadState(LoaderState state) {
    loaderState = state;
    notifyListeners();
  }
}
