import 'dart:convert';
import 'dart:developer';

import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:laundry/services/api_reponse.dart';
import 'package:laundry/services/get_it.dart';
import 'package:laundry/services/helpers.dart';
import 'package:laundry/services/provider_helper_class.dart';
import 'package:laundry/utils/enums.dart';
import 'package:laundry/views/main_screen/past_orders/model/order_details_model.dart';
import 'package:laundry/views/main_screen/past_orders/model/past_orders_response_model.dart';
import 'package:laundry/views/main_screen/past_orders/repo/past_orders_repo.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class PastOrdersProvider extends ChangeNotifier with ProviderHelperClass {
  Helpers helpers = sl.get<Helpers>();
  PastOrdersRepo pastOrdersRepo = PastOrdersRepo();

  PastOrdersResponse? pastOrdersResponse;

  OrderDetailsModel? orderDetailsModel;
  FullAddress? fullAddress;
  DriverLocationUpdatedEvent? driverLocation;

  List<Orders> ordersList = [];


  String? adminCommentStatus;
  String? message;
  String? returnId;

  bool? btnLoader = false;

  GoogleMapController? mapController;

  Map<PolylineId, Polyline> polylines = {};
  PolylinePoints polylinePoints = PolylinePoints();
  List<LatLng> polylineCoordinates = [];
  Map<MarkerId, Marker> markers = {};

  PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();

  Future<void> getPastOrders() async {
    updateLoadState(LoaderState.loading);
    final network = await helpers.isInternetAvailable();
    Future<Either<ApiResponse, dynamic>>? resp;
    if (network) {
      try {
        resp = pastOrdersRepo.getPastOrders().thenRight((right) {
          pastOrdersResponse = right;
          updateOrdersList(pastOrdersResponse);
          return Right(right);
        }).thenLeft((left) {
          updateLoadState(LoaderState.error);
          return Left(ApiResponse(exceptions: ApiExceptions.error));
        }).onError((error, stackTrace) {
          updateLoadState(LoaderState.error);
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



  Future<void> getOrderDetails(int orderId) async {
    final network = await helpers.isInternetAvailable();
    if (network) {
      updateLoadState(LoaderState.loading);
      try {
        pastOrdersRepo.getOrderDetails(orderId).thenRight((right) {
          orderDetailsModel = right;
          if (orderDetailsModel?.status ?? false) {
            updateLoadState(LoaderState.loaded);
          } else {
            updateLoadState(LoaderState.error);
          }
          return Right(right);
        }).thenLeft((left) {
          updateLoadState(LoaderState.error);
          return Left(ApiResponse(exceptions: ApiExceptions.error));
        }).onError((error, stackTrace) {
          updateLoadState(LoaderState.error);
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

  Future<void> updateAdminCommentStatus(
      {required String orderId,
      required String status,
      Function()? onSuccess,
      Function()? onFailure}) async {
    final network = await helpers.isInternetAvailable();
    updateBtnLoader(true);
    try {
      pastOrdersRepo.updateAdminComments(orderId: orderId, status: status).fold(
          (left) {
        updateBtnLoader(false);
        updateMessage(left.message ?? 'Oops... Something went wrong');
        if (onFailure != null) onFailure();
      }, (right) {
        updateBtnLoader(false);
        updateMessage(right.message ?? 'Successfully updated');
        if (onSuccess != null) onSuccess();
      });
    } catch (e) {
      updateBtnLoaderState(false);
      updateLoadState(LoaderState.error);
    }
  }

  updateOrdersList(PastOrdersResponse? pastOrdersResponse) {
    ordersList = pastOrdersResponse?.orders ?? [];
    if (ordersList.isNotEmpty) {
      updateLoadState(LoaderState.loaded);
    } else {
      updateLoadState(LoaderState.noData);
    }

    notifyListeners();
  }


  void updateFullAddress({required FullAddress? address, required String id}) {
    fullAddress = address;
    returnId = id;
  }

  /// pusher

  void initPusher() async {
    try {
      await pusher.init(
        apiKey: '4f0b4f15fc53e7b6ad85',
        cluster: 'ap2',
        onConnectionStateChange: onConnectionStateChange,
        onError: onError,
        onSubscriptionSucceeded: onSubscriptionSucceeded,
        onEvent: onEvent,
        onSubscriptionError: onSubscriptionError,
        onDecryptionFailure: onDecryptionFailure,
        onMemberAdded: onMemberAdded,
        onMemberRemoved: onMemberRemoved,
        onSubscriptionCount: onSubscriptionCount,
        // authEndpoint: "<Your Authendpoint Url>",
        // onAuthorizer: onAuthorizer
      );

      await pusher.subscribe(channelName: 'ledegraissage-$returnId');
      await pusher.connect();
    } catch (e) {
      log("ERROR: $e");
    }
  }

  void onConnectionStateChange(dynamic currentState, dynamic previousState) {
    log("Connection: $currentState");
  }

  void onError(String message, int? code, dynamic e) {
    log("onError: $message code: $code exception: $e");
  }

  void onEvent(PusherEvent event) {
    // log("onEvent: $event");
    // log(event.data);

    /// origin marker
    if (event.data != null) {
      Map<String, dynamic> eventData = json.decode(event.data!);

      driverLocation = DriverLocationUpdatedEvent.fromJson(eventData);

      addMarker(
          LatLng(double.parse(fullAddress?.latitude ?? '0'),
              double.parse(fullAddress?.longitude ?? '0')),
          "origin",
          BitmapDescriptor.defaultMarker);

      /// destination marker
      if (driverLocation != null) {
        addMarker(LatLng(driverLocation!.latitude, driverLocation!.longitude),
            "destination", BitmapDescriptor.defaultMarkerWithHue(90));
        getPolyline(
            customerLatLng: LatLng(double.parse(fullAddress?.latitude ?? '0'),
                double.parse(fullAddress?.longitude ?? '0')),
            riderLatLng:
                LatLng(driverLocation!.latitude, driverLocation!.longitude));
      }
    }
  }

  void onSubscriptionSucceeded(String channelName, dynamic data) {
    log("onSubscriptionSucceeded: $channelName data: $data");
    final me = pusher.getChannel(channelName)?.me;
    log("Me: $me");
  }

  void onSubscriptionError(String message, dynamic e) {
    log("onSubscriptionError: $message Exception: $e");
  }

  void onDecryptionFailure(String event, String reason) {
    log("onDecryptionFailure: $event reason: $reason");
  }

  void onMemberAdded(String channelName, PusherMember member) {
    log("onMemberAdded: $channelName user: $member");
  }

  void onMemberRemoved(String channelName, PusherMember member) {
    log("onMemberRemoved: $channelName user: $member");
  }

  void onSubscriptionCount(String channelName, int subscriptionCount) {
    log("onSubscriptionCount: $channelName subscriptionCount: $subscriptionCount");
  }

  dynamic onAuthorizer(String channelName, String socketId, dynamic options) {
    return {
      "auth": "foo:bar",
      "channel_data": '{"user_id": 1}',
      "shared_secret": "foobar"
    };
  }

  /// poly line
  void addPolyLine() {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id,
        color: Colors.black,
        points: polylineCoordinates,
        width: 1);
    polylines[id] = polyline;
    notifyListeners();
  }

  void getPolyline(
      {required LatLng riderLatLng, required LatLng customerLatLng}) async {
    try {
      // Clear previous route data to avoid duplicates
      polylineCoordinates.clear();

      // Fetch route from Google Maps API
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        // 'AIzaSyBb2wGZE012MilJ55Pw44d9WewvBmLsZSI',
        // PointLatLng(riderLatLng.latitude, riderLatLng.longitude),
        // PointLatLng(customerLatLng.latitude, customerLatLng.longitude),
        // travelMode: TravelMode.driving,
        request: PolylineRequest(
            origin: PointLatLng(riderLatLng.latitude, riderLatLng.longitude),
            destination:
                PointLatLng(customerLatLng.latitude, customerLatLng.longitude),
            mode: TravelMode.driving),
        googleApiKey: 'AIzaSyBb2wGZE012MilJ55Pw44d9WewvBmLsZSI',
        // travelMode: TravelMode.driving,
      );

      if (result.points.isNotEmpty) {
        // Add new route points
        for (var point in result.points) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        }

        // Update the polyline on the map
        addPolyLine();
      } else {
        print("No points returned for the route");
      }
    } catch (e) {
      print("Error fetching polyline: $e");
    }
  }

  void addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
        Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
  }

  void updateBtnLoader(bool value) {
    btnLoader = value;
    notifyListeners();
  }

  void updateMessage(String msg) {
    message = msg;
    notifyListeners();
  }

  @override
  void updateLoadState(LoaderState state) {
    loaderState = state;
    notifyListeners();
  }
}
