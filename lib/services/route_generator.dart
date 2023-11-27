import 'package:flutter/material.dart';
import 'package:laundry/views/authentication/view/forgot_password_otp_verification_screen.dart';
import 'package:laundry/views/authentication/view/forgot_password_reset_password_screen.dart';
import 'package:laundry/views/authentication/view/forgot_password_screen.dart';
import 'package:laundry/views/authentication/view/login_screen.dart';
import 'package:laundry/views/authentication/view/registration_screen.dart';
import 'package:laundry/views/cart/cart.dart';
import 'package:laundry/views/eco_dry_clean/view/eco_dry_clean_item_selection_screen.dart';
import 'package:laundry/views/eco_dry_clean/view/eco_dry_clean_screen.dart';
import 'package:laundry/views/main_screen/home_screen/view/home_screen.dart';
import 'package:laundry/views/main_screen/main_screen.dart';
import 'package:laundry/views/main_screen/past_orders/view/past_orders_screen.dart';
import 'package:laundry/views/splash/view/splash_screen.dart';

class RouteGenerator {
  static RouteGenerator? _instance;

  static RouteGenerator get instance {
    _instance ??= RouteGenerator();
    return _instance!;
  }

  static const String routeInitial = "/";
  static const String routeLogin = 'loginScreen';
  static const String routeRegistration = 'registrationScreen';
  static const String routeHomeScreen = 'homeScreen';
  static const String routeForgotPassword = 'forgotPasswordScreen';
  static const String routePastOrders = 'pastOrdersScreen';
  static const String routeEcoDryClean = 'ecoDryCleanScreen';
  static const String routeEcoDryCleanSelectionScreen =
      'ecoDryCleanSelectionScreen';
  static const String routeCart = 'cartScreen';
  static const String routeForgotPasswordOtpVerificationScreen =
      'forgotPasswordOtpVerificationScreen';
  static const String routeForgotPasswordResetPasswordScreen =
      'forgotPasswordResetPasswordScreen';
  static const String routeMainScreen='mainScreen';

  Route generateRoute(RouteSettings settings, {var routeBuilders}) {
    var args = settings.arguments;
    switch (settings.name) {
      case routeInitial:
        return _buildRoute(routeInitial, const SplashScreen());
      case routeLogin:
        return _buildRoute(routeLogin, const LoginScreen());
      case routeRegistration:
        return _buildRoute(routeRegistration, const RegistrationScreen());
      case routeHomeScreen:
        return _buildRoute(routeHomeScreen, const HomeScreen());
      case routeForgotPassword:
        return _buildRoute(routeForgotPassword, const ForgotPasswordScreen());
      case routePastOrders:
        return _buildRoute(routePastOrders, const PastOrdersScreen());
      case routeEcoDryClean:
        return _buildRoute(routeEcoDryClean, const EcoDryCleanScreen());
      case routeEcoDryCleanSelectionScreen:
        return _buildRoute(routeEcoDryCleanSelectionScreen,
            const EcoDryScreenItemSelectionScreen());
      case routeCart:
        return _buildRoute(routeCart, const Cart());
      case routeForgotPasswordOtpVerificationScreen:
        return _buildRoute(routeForgotPasswordOtpVerificationScreen,
            const ForgotPasswordOtpVerificationScreen());
      case routeForgotPasswordResetPasswordScreen:
        return _buildRoute(routeForgotPasswordResetPasswordScreen,
            const ForgotPasswordResetPasswordScreen());
      case routeMainScreen:
        return _buildRoute(routeMainScreen, const MainScreen());
      default:
        return _buildRoute(routeInitial, const SplashScreen());
    }
  }

  Route _buildRoute(String route, Widget widget,
      {bool enableFullScreen = false}) {
    return MaterialPageRoute(
        fullscreenDialog: enableFullScreen,
        settings: RouteSettings(name: route),
        builder: (_) => widget);
  }
}
