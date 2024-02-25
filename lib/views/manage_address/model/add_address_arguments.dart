import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:laundry/views/manage_address/view_model/manage_address_view_model.dart';
import 'package:location/location.dart';

class AddAddressArguments {
  ManageAddressProvider manageAddressProvider;

  AddAddressArguments({required this.manageAddressProvider});
}

class ManageAddressArguments {
  bool? isFromCart;

  ManageAddressArguments({this.isFromCart});
}

class LocationArguments {
  LocationData latLng;
  LocationArguments({required this.latLng});
}
