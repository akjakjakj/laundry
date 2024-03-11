import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:laundry/common_widgets/common_functions.dart';
import 'package:laundry/common_widgets/custom_linear_progress_indicator.dart';
import 'package:laundry/common_widgets/three_bounce.dart';
import 'package:laundry/services/route_generator.dart';
import 'package:laundry/utils/color_palette.dart';
import 'package:laundry/utils/enums.dart';
import 'package:laundry/utils/font_palette.dart';
import 'package:laundry/views/manage_address/model/add_address_arguments.dart';
import 'package:laundry/views/manage_address/view/widgets/place_auto_complete_text_field.dart';
import 'package:laundry/views/manage_address/view_model/manage_address_view_model.dart';
import 'package:provider/provider.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  void initState() {
    CommonFunctions.afterInit(() =>
        context.read<ManageAddressProvider>().getLocationFromLocalStorage());
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
          "Location",
          style: FontPalette.poppinsBold
              .copyWith(color: Colors.black, fontSize: 17.sp),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Consumer<ManageAddressProvider>(
        builder: (context, manageAddressProvider, child) =>
            manageAddressProvider.btnLoaderState
                ? const CustomLinearProgress()
                : Stack(
                    children: [
                      GoogleMap(
                        onMapCreated: (controller) {
                          manageAddressProvider.mapController = controller;
                        },
                        onCameraIdle: () {
                          manageAddressProvider.updateIsButtonLoading(false);
                        },
                        initialCameraPosition: CameraPosition(
                          target: LatLng(
                              manageAddressProvider.locationData?.latitude ??
                                  23.4241,
                              manageAddressProvider.locationData?.longitude ??
                                  53.8478), // Default location (San Francisco)
                          zoom: 12.0, // Initial zoom level
                        ),
                        markers: manageAddressProvider.markers,
                        onTap: (argument) =>
                            manageAddressProvider.handleTap(argument),
                      ),
                      Positioned(
                        left: 12.w,
                        right: 1.w,
                        child: Column(
                          children: [
                            PlaceAutoCompleteTextField(
                                manageAddressProvider: manageAddressProvider)
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                            height: 100.0,
                            color: Colors.white,
                            padding: EdgeInsets.only(
                                left: 50.w, right: 50.w, top: 10.0),
                            child: Column(
                              children: [
                                Text(
                                  manageAddressProvider
                                      .addressStreetController.text
                                      .trim(),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                5.verticalSpace,
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context,
                                        RouteGenerator.routeAddAddressScreen,
                                        arguments: AddAddressArguments(
                                            manageAddressProvider:
                                                manageAddressProvider));
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 48.0,
                                    decoration: BoxDecoration(
                                        color: ColorPalette.primaryColor,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: manageAddressProvider.isButtonLoading
                                        ? ThreeBounce(
                                            size: 30.r,
                                          )
                                        : Text('Continue',
                                            style: FontPalette.poppinsBold
                                                .copyWith(
                                              fontSize: 15.sp,
                                              color: Colors.white,
                                            )),
                                  ),
                                ),
                              ],
                            )),
                      )
                    ],
                  ),
      ),
    );
  }
}
