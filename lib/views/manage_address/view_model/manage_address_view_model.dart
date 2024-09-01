import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:laundry/services/api_reponse.dart';
import 'package:laundry/services/get_it.dart';
import 'package:laundry/services/helpers.dart';
import 'package:laundry/services/provider_helper_class.dart';
import 'package:laundry/services/shared_preference_helper.dart';
import 'package:laundry/utils/enums.dart';
import 'package:laundry/views/manage_address/model/add_address_request_model.dart';
import 'package:laundry/views/manage_address/model/manage_address_response_model.dart';
import 'package:laundry/views/manage_address/model/map_details_model.dart';
import 'package:laundry/views/manage_address/repo/manage_address_repo.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;

class ManageAddressProvider extends ChangeNotifier with ProviderHelperClass {
  Helpers helpers = sl.get<Helpers>();
  SharedPreferencesHelper sharedPreferencesHelper =
      sl.get<SharedPreferencesHelper>();
  ManageAddressRepo manageAddressRepo = sl.get<ManageAddressRepo>();

  ManageAddressResponse? manageAddressResponse;
  List<Addresses> addressesList = [];
  List<MapDetails> mapDetailsList = [];

  String? errorMessage;
  final String apiKey = 'AIzaSyBb2wGZE012MilJ55Pw44d9WewvBmLsZSI';
  String? name;
  String? postalCode;

  TextEditingController buildingNumberEditingController =
      TextEditingController();
  TextEditingController addressStreetController = TextEditingController();
  TextEditingController fullAddressController = TextEditingController();
  TextEditingController addressEmirateController = TextEditingController();
  TextEditingController textEditingController = TextEditingController();

  Position? locationData;
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
          address: fullAddressController.text.trim(),
          houseNumber: buildingNumberEditingController.text.trim(),
          city: addressStreetController.text.trim(),
          country: addressEmirateController.text.trim(),
          postalCode: double.tryParse(postalCode ?? '0'),
          latitude: currentPosition?.latitude,
          longitude: currentPosition?.longitude);
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
        if (onFailure != null) onFailure();
        return Left(ApiResponse(exceptions: ApiExceptions.error));
      }).onError((error, stackTrace) {
        updateLoadState(LoaderState.error);
        if (onFailure != null) onFailure();
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
      getLocationFromLatLng(LatLng(lat, lng));
      updateCurrentPosition(LatLng(lat, lng), isUpdateButtonLoading: false);
      await updateCameraPositionAndMarker(LatLng(lat, lng));

      mapDetailsList.clear();
    }
    notifyListeners();
  }

  void handleTap(LatLng tappedPoint) async {
    updateIsButtonLoading(true);
    updateCurrentPosition(tappedPoint);
    await getLocationFromLatLng(tappedPoint);
    await updateCameraPositionAndMarker(tappedPoint);
    notifyListeners();
  }

  updateCurrentPosition(LatLng position,
      {bool? isUpdateButtonLoading, Function? onSuccess}) async {
    currentPosition = position;
    if ((isUpdateButtonLoading ?? true)) updateIsButtonLoading(false);
    if (onSuccess != null) onSuccess();
    notifyListeners();
  }

  Future<void> getLocation() async {
    final bool isPermissionGranted = await requestPermission();
    if (isPermissionGranted) {
      locationData = await Geolocator.getCurrentPosition();
      sharedPreferencesHelper.setCurrentLocation(LatLng(
          locationData?.latitude ?? 23.4241,
          locationData?.longitude ?? 53.8478));
      updateCameraPositionAndMarker(LatLng(locationData?.latitude ?? 23.4241,
          locationData?.longitude ?? 53.8478));
      await mapController?.animateCamera(CameraUpdate.newLatLng(LatLng(
          locationData?.latitude ?? 23.4241,
          locationData?.longitude ?? 53.8478)));
    }

    notifyListeners();
  }

  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    // Request permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return;
    }

    // Get the current position
    locationData = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    sharedPreferencesHelper.setCurrentLocation(LatLng(
        locationData?.latitude ?? 23.4241, locationData?.longitude ?? 53.8478));
    updateCameraPositionAndMarker(LatLng(
        locationData?.latitude ?? 23.4241, locationData?.longitude ?? 53.8478));
    await mapController?.animateCamera(CameraUpdate.newLatLng(LatLng(
        locationData?.latitude ?? 23.4241,
        locationData?.longitude ?? 53.8478)));
    notifyListeners();
  }

  Future<bool> requestPermission() async {
    var status = await Permission.location.status;
    if (status.isDenied || status.isRestricted || status.isPermanentlyDenied) {
      var result = await Permission.location.request();
      return result.isGranted;
    }
    return status.isDenied;
  }

  Future<void> getLocationFromLocalStorage() async {
    updateBtnLoaderState(true);
    LatLng? latLng = await sharedPreferencesHelper.getCurrentLocation();
    updateCurrentPosition(latLng ?? const LatLng(23.4241, 53.8478));
    updateCameraPositionAndMarker(latLng ?? const LatLng(23.4241, 53.8478));
    updateBtnLoaderState(false);
    notifyListeners();
  }

  Future<void> updateCameraPositionAndMarker(LatLng latLng) async {
    markers.clear();
    markers.add(
      Marker(
        markerId: const MarkerId('1'),
        position: LatLng(latLng.latitude, latLng.longitude),
        infoWindow: InfoWindow(
          title: name,
          snippet: name,
        ),
      ),
    );
    try {
      await mapController?.animateCamera(
          CameraUpdate.newLatLng(LatLng(latLng.latitude, latLng.longitude)));
    } catch (e) {
      updateBtnLoaderState(false);
    }
  }

  Future<void> getLocationFromLatLng(LatLng position) async {
    List<Placemark> placeMarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placeMarks[0];
    addressStreetController.text = (place.subLocality ?? '').isNotEmpty
        ? place.subLocality ?? ''
        : place.locality ?? '';
     fullAddressController.text = place.locality ?? '';
    addressEmirateController.text = place.country ?? '';
    postalCode = place.postalCode ?? '';
    notifyListeners();
  }

  void updateAddressList(ManageAddressResponse? manageAddressResponse) {
    addressesList = manageAddressResponse?.addresses ?? [];
    if (addressesList.isNotEmpty) {
      updateLoadState(LoaderState.loaded);
    } else {
      updateLoadState(LoaderState.noData);
    }
    notifyListeners();
  }

  void updateErrorMessage(String msg) {
    errorMessage = msg;
    notifyListeners();
  }

  void clearAddressControllers() {
    addressStreetController.clear();
    buildingNumberEditingController.clear();
    fullAddressController.clear();
    notifyListeners();
  }

  updateIsButtonLoading(bool value) {
    isButtonLoading = value;
    notifyListeners();
  }

  void clearValues() {
    buildingNumberEditingController.clear();
    addressStreetController.clear();
    fullAddressController.clear();
    addressEmirateController.clear();
    textEditingController.clear();
  }

  @override
  void updateBtnLoaderState(bool val) {
    btnLoaderState = val;
    notifyListeners();
  }

  @override
  void updateLoadState(LoaderState state) {
    loaderState = state;
    notifyListeners();
  }
}
