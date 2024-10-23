import 'package:flutter/material.dart';
import 'package:laundry/views/authentication/view/forgot_password_otp_verification_screen.dart';
import 'package:laundry/views/authentication/view/forgot_password_reset_password_screen.dart';
import 'package:laundry/views/authentication/view/forgot_password_screen.dart';
import 'package:laundry/views/authentication/view/login_screen.dart';
import 'package:laundry/views/authentication/view/registration_screen.dart';
import 'package:laundry/views/cart/model/normal_service_arguments.dart';
import 'package:laundry/views/cart/view/cart.dart';
import 'package:laundry/views/cart/view/widgets/normal_service.dart';
import 'package:laundry/views/eco_dry_clean/view/eco_dry_clean_item_selection_screen.dart';
import 'package:laundry/views/eco_dry_clean/view/eco_dry_clean_screen.dart';
import 'package:laundry/views/eco_dry_clean/view/price_pdf_view.dart';
import 'package:laundry/views/eco_dry_clean/view_model/eco_dry_view_model.dart';
import 'package:laundry/views/main_screen/active_orders/view/active_orders_details_screen.dart';
import 'package:laundry/views/main_screen/active_orders/view_model/active_orders_view_model.dart';
import 'package:laundry/views/main_screen/home_screen/model/banners_model.dart';
import 'package:laundry/views/main_screen/home_screen/view/home_banner_vdo_player.dart';
import 'package:laundry/views/main_screen/home_screen/view/home_screen.dart';
import 'package:laundry/views/main_screen/main_screen.dart';
import 'package:laundry/views/main_screen/past_orders/model/order_details_arguments.dart';
import 'package:laundry/views/main_screen/past_orders/view/invoice_view.dart';
import 'package:laundry/views/main_screen/past_orders/view/order_details_screen.dart';
import 'package:laundry/views/main_screen/past_orders/view/past_orders_screen.dart';
import 'package:laundry/views/main_screen/past_orders/view_model/past_orders_view_model.dart';
import 'package:laundry/views/manage_address/model/add_address_arguments.dart';
import 'package:laundry/views/manage_address/view/add_address_screen.dart';
import 'package:laundry/views/manage_address/view/location_screen.dart';
import 'package:laundry/views/manage_address/view/manage_address_screen.dart';
import 'package:laundry/views/privacy_policy/privacy_policy.dart';
import 'package:laundry/views/profile/profile.dart';
import 'package:laundry/views/splash/view/splash_screen.dart';
import 'package:laundry/views/terms_of_use/terms_of_use.dart';

import '../views/eco_dry_clean/model/eco_dry_clean_arguments.dart';

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
  static const String routeVideoScreen = 'videoScreen';
  static const String routeForgotPassword = 'forgotPasswordScreen';
  static const String routePastOrders = 'pastOrdersScreen';
  static const String routeEcoDryClean = 'ecoDryCleanScreen';
  static const String routeEcoDryCleanSelectionScreen =
      'ecoDryCleanSelectionScreen';
  static const String routeCart = 'cartScreen';
  static const String routeProfile = 'profileScreen';
  static const String routeForgotPasswordOtpVerificationScreen =
      'forgotPasswordOtpVerificationScreen';
  static const String routeForgotPasswordResetPasswordScreen =
      'forgotPasswordResetPasswordScreen';
  static const String routeMainScreen = 'mainScreen';
  static const String routeAddressScreen = 'addressScreen';
  static const String routeAddAddressScreen = 'addAddAddressScreen';
  static const String routeTermsOfuse = 'routeTermsOfuse';
  static const String routePrivacyPolicy = 'routePrivacyPolicy';
  static const String routeOrderDetails = 'routeOrderDetails';
  static const String routePricePdfView = 'routePricePdfScreen';
  static const String routeNormalServiceScreen = 'routeNormalServiceScreen';
  static const String routeLocationScreen = 'routeLocationScreen';
  static const String routeActiveOrderDetails = 'activeOrderDetails';
  static const String routeInvoiceView = 'invoiceView';
  static const String routeBlackScreen = 'blackScreenView';

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
      case routeVideoScreen:
        BannersArguments routeArgs = args as BannersArguments;

        return _buildRoute(routeVideoScreen, VideoScreen(link: routeArgs.link));
      case routeForgotPassword:
        return _buildRoute(routeForgotPassword, const ForgotPasswordScreen());
      case routePastOrders:
        return _buildRoute(routePastOrders, const PastOrdersScreen());
      case routeEcoDryClean:
        EcoDryCleanArguments routeArgs = args as EcoDryCleanArguments;
        return _buildRoute(
            routeEcoDryClean,
            EcoDryCleanScreen(
              title: routeArgs.title ?? '',
              serviceId: routeArgs.serviceId ?? 0,
            ));
      case routeAddressScreen:
        ManageAddressArguments? routeArgs;
        if (args != null) {
          routeArgs = args as ManageAddressArguments;
        }
        return _buildRoute(
            routeAddressScreen,
            ManageAddressScreen(
              isFromCart: routeArgs?.isFromCart,
            ));
      case routeTermsOfuse:
        return _buildRoute(routeTermsOfuse, const Terms());
      case routePrivacyPolicy:
        return _buildRoute(routePrivacyPolicy, const Privacy());
      case routeEcoDryCleanSelectionScreen:
        EcoDryCleanArguments routeArgs = args as EcoDryCleanArguments;
        return _buildRoute(
            routeEcoDryCleanSelectionScreen,
            EcoDryScreenItemSelectionScreen(
              categoryId: routeArgs.categoryId ?? 0,
              title: routeArgs.title ?? '',
              ecoDryProvider: routeArgs.ecoDryProvider ?? EcoDryProvider(),
            ));
      case routeCart:
        return _buildRoute(routeCart, const Cart());
      case routeProfile:
        return _buildRoute(routeCart, const Profile());
      case routeForgotPasswordOtpVerificationScreen:
        return _buildRoute(routeForgotPasswordOtpVerificationScreen,
            const ForgotPasswordOtpVerificationScreen());
      case routeForgotPasswordResetPasswordScreen:
        return _buildRoute(routeForgotPasswordResetPasswordScreen,
            const ForgotPasswordResetPasswordScreen());
      case routeMainScreen:
        return _buildRoute(routeMainScreen, const MainScreen());
      case routeAddAddressScreen:
        AddAddressArguments routeArgs = args as AddAddressArguments;
        return _buildRoute(
            routeAddAddressScreen,
            AddAddressScreen(
              manageAddressProvider: routeArgs.manageAddressProvider,
            ));
      case routeOrderDetails:
        OrderDetailsArguments routeArgs = args as OrderDetailsArguments;
        return _buildRoute(
            routeOrderDetails,
            OrderDetailsScreen(
              pastOrdersProvider:
                  routeArgs.pastOrdersProvider ?? PastOrdersProvider(),
              orderId: routeArgs.orderId,
              orders: routeArgs.orders,
            ));
      case routeActiveOrderDetails:
        ActiveOrderDetailsArguments routeArgs =
            args as ActiveOrderDetailsArguments;
        return _buildRoute(
            routeActiveOrderDetails,
            ActiveOrdersDetailsScreen(
              activeOrdersProvider:
                  routeArgs.activeOrdersProvider ?? ActiveOrdersProvider(),
              orders: routeArgs.orders,
              orderId: routeArgs.orderId,
            ));
      case routePricePdfView:
        PriceListScreenArguments routeArgs = args as PriceListScreenArguments;
        return _buildRoute(
            routePricePdfView,
            PricePdfView(
                ecoDryProvider: routeArgs.ecoDryProvider,
                index: routeArgs.serviceId));
      case routeNormalServiceScreen:
        NormalServiceArguments routeArgs = args as NormalServiceArguments;
        return _buildRoute(
            routeNormalServiceScreen,
            NormalService(
              index: routeArgs.index,
            ));
      case routeInvoiceView:
        InvoiceArguments routeArgs = args as InvoiceArguments;
        return _buildRoute(routeInvoiceView,
            InvoiceView(url: routeArgs.url ?? 'https://flutter.dev'));
      case routeLocationScreen:
        return _buildRoute(routeLocationScreen, const LocationScreen());
      case routeBlackScreen:
        return _buildRoute(routeBlackScreen, const BlackScreen());
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
