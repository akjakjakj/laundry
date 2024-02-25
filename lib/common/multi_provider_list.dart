import 'package:laundry/views/authentication/view_model/auth_view_model.dart';
import 'package:laundry/views/cart/view_model/cart_view_model.dart';
import 'package:laundry/views/main_screen/home_screen/view_model/home_view_model.dart';
import 'package:laundry/views/main_screen/past_orders/view_model/payment_view_model.dart';
import 'package:laundry/views/manage_address/view_model/manage_address_view_model.dart';
import 'package:laundry/views/profile/view_model/profile_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class MultiProviderList {
  static List<SingleChildWidget> providerList = [
    ChangeNotifierProvider(create: (_) => AuthProvider()),
    ChangeNotifierProvider(create: (_) => HomeProvider()),
    ChangeNotifierProvider(create: (_) => ProfileProvider()),
    ChangeNotifierProvider(create: (_) => PaymentProvider()),
    ChangeNotifierProvider(create: (_) => CartViewProvider()),
    ChangeNotifierProvider(create: (_) => ManageAddressProvider()),
  ];
}
