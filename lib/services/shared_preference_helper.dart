import 'package:shared_preferences/shared_preferences.dart';

import 'app_config.dart';

class SharedPreferencesHelper {
  final String authToken = "loginToken";
  final String userEmail = "user_email";
  final String userCartId = "user_cart_id";
  final String userLocation = "user_location";
  final String localLocale = "local_locale";
  final String wishListId = "wish_list_id";
  final String loginStatus = "login_status";
  final String authCustomerDetails = "auth_customer_details";



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
    AppConfig.accessToken = '';
    await prefs.remove(authToken);
  }

  Future<void> saveLoginStatus(bool stat) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(loginStatus, stat);
  }

  Future<bool> getLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(loginStatus) ?? false;
  }

  Future<void> saveWishListId(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(wishListId, id);
  }

  Future<int?> getWishListId() async {
    int? val;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(wishListId)) {
      val = prefs.getInt(wishListId)!;
    }
    return val;
  }

  Future<void> removeWishListId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(wishListId)) {
      prefs.remove(wishListId);
    }
  }

  Future<void> saveCartId(String? cartId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(userCartId, cartId ?? '');
  }

  Future<String> getCartId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userCartId) ?? '';
  }
}