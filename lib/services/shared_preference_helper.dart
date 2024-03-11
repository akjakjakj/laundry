import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:laundry/views/manage_address/model/manage_address_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_config.dart';

class SharedPreferencesHelper {
  final String authToken = "loginToken";
  final String deviceToken = "deviceToken";
  final String userEmail = "user_email";
  final String userCartId = "user_cart_id";
  final String userLocation = "user_location";
  final String localLocale = "local_locale";
  final String wishListId = "wish_list_id";
  final String loginStatus = "login_status";
  final String authCustomerDetails = "auth_customer_details";
  final String defaultAddress = "default_address";
  final String currentLocation = "current_location";
  final String _latitudeKey = 'latitude';
  final String _longitudeKey = 'longitude';

  Future<String> getAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? stringValue = prefs.getString(authToken);
    return stringValue ?? "";
  }

  Future<void> saveUserToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(authToken, token);
    AppConfig.accessToken = "Bearer $token";
  }

  Future<void> removeLoginToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    AppConfig.accessToken = '';
    await prefs.remove(authToken);
  }

  Future<void> saveDeviceToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    AppConfig.deviceToken = token;
    await prefs.setString(deviceToken, token);
  }

  Future<String> getDeviceToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? stringValue = prefs.getString(deviceToken);
    return stringValue ?? "";
  }

  Future<void> saveLoginStatus(bool stat) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(loginStatus, stat);
  }

  Future<bool> getLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(loginStatus) ?? false;
  }

  Future<void> setDefaultAddress(Addresses defaultAddressModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        defaultAddress, jsonEncode(defaultAddressModel.toJson()));
  }

  Future<Map<String, dynamic>> getDefaultAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? defaultAddressString = prefs.getString(defaultAddress);
    if (defaultAddressString != null) {
      Map<String, dynamic> defaultAddressModel =
          jsonDecode(defaultAddressString);
      return defaultAddressModel;
    } else {
      return {};
    }
  }

  Future<void> setCurrentLocation(LatLng latLng) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_latitudeKey, latLng.latitude);
    await prefs.setDouble(_longitudeKey, latLng.longitude);
  }

  Future<LatLng?> getCurrentLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final latitude = prefs.getDouble(_latitudeKey);
    final longitude = prefs.getDouble(_longitudeKey);
    if (latitude != null && longitude != null) {
      return LatLng(latitude, longitude);
    }
    return null;
  }
  }

