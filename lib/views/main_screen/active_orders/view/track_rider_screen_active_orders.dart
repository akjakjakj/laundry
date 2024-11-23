import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:laundry/utils/color_palette.dart';
import 'package:laundry/utils/font_palette.dart';
import 'package:laundry/views/main_screen/active_orders/view_model/active_orders_view_model.dart';
import 'package:provider/provider.dart';

class TrackRiderActiveOrder extends StatefulWidget {
  const TrackRiderActiveOrder({super.key, required this.activeOrdersProvider});
  final ActiveOrdersProvider activeOrdersProvider;
  @override
  State<TrackRiderActiveOrder> createState() => _TrackRiderActiveOrderState();
}

class _TrackRiderActiveOrderState extends State<TrackRiderActiveOrder> {
  @override
  void initState() {
    widget.activeOrdersProvider.initPusher();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Padding(
          padding: EdgeInsets.only(left: 15.r),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Center(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 4,
                        blurStyle: BlurStyle.outer,
                        color: Color.fromARGB(255, 224, 224, 224),
                        spreadRadius: 0.5)
                  ],
                ),
                child: CircleAvatar(
                    radius: 18.r,
                    backgroundColor: Colors.white,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(left: 6.w),
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                          size: 18.r,
                        ),
                      ),
                    )),
              ),
            ),
          ),
        ),
        title: Text(
          "Track Rider",
          style: FontPalette.poppinsBold
              .copyWith(color: Colors.black, fontSize: 17.sp),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: ChangeNotifierProvider.value(
        value: widget.activeOrdersProvider,
        child: Container(
          color: Colors.white,
          child: Consumer<ActiveOrdersProvider>(
            builder: (context, activeOrdersProvider, child) => Stack(
              children: [
                activeOrdersProvider.driverLocation != null
                    ? GoogleMap(
                        onMapCreated: (controller) {
                          activeOrdersProvider.mapController = controller;
                        },
                        onCameraIdle: () {
                          // manageAddressProvider.updateIsButtonLoading(false);
                        },
                        initialCameraPosition: CameraPosition(
                          target: LatLng(
                              activeOrdersProvider.driverLocation!.latitude,
                              activeOrdersProvider.driverLocation!
                                  .longitude), // Default location (San Francisco)
                          zoom: 12.0, // Initial zoom level
                        ),
                        markers: Set<Marker>.of(
                            widget.activeOrdersProvider.markers.values),
                        polylines: Set<Polyline>.of(
                            widget.activeOrdersProvider.polylines.values),
                        // markers: activeOrdersProvider.markers,
                        // onTap: (argument) =>
                        //     manageAddressProvider.handleTap(argument),
                      )
                    : Center(
                        child: Text('Can\'t find Rider Information',
                            style: FontPalette.poppinsRegular.copyWith(
                                fontSize: 14.sp,
                                color: HexColor('#000000'),
                                fontWeight: FontWeight.w500)),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
