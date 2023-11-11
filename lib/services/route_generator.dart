import 'package:flutter/material.dart';
import 'package:laundry/views/authentication/view/login_screen.dart';
import 'package:laundry/views/authentication/view/registration_screen.dart';
import 'package:laundry/views/main_screen/home_screen/view/home_screen.dart';
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
