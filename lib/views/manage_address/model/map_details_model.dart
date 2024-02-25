import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapDetails {
  String? name;
  String? placeId;
  LatLng? latLng;
  MapDetails({this.name, this.placeId, this.latLng});
  clear() {
    name = "";
    placeId = "";
    latLng = null;
  }
}
