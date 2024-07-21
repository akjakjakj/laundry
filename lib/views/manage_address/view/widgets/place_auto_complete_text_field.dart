import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:laundry/utils/font_palette.dart';
import 'package:laundry/views/manage_address/view_model/manage_address_view_model.dart';

class PlaceAutoCompleteTextField extends StatelessWidget {
  const PlaceAutoCompleteTextField(
      {super.key, required this.manageAddressProvider});
  final ManageAddressProvider manageAddressProvider;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white.withOpacity(.8),
      ),
      child: GooglePlaceAutoCompleteTextField(
        textEditingController: manageAddressProvider.textEditingController,
        boxDecoration: const BoxDecoration(
            border: Border.symmetric(
                horizontal: BorderSide.none, vertical: BorderSide.none)),
        googleAPIKey: manageAddressProvider.apiKey,
        inputDecoration: const InputDecoration(
          hintText: "Search your location",
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
        ),
        debounceTime: 400,
        isLatLngRequired: false,
        itemClick: (Prediction prediction) {
          SystemChannels.textInput.invokeMethod('TextInput.hide');
          manageAddressProvider.getPlaceDetails(prediction.placeId ?? '');
        },
        seperatedBuilder: const Divider(),
        // OPTIONAL// If you want to customize list view item builder
        itemBuilder: (context, index, Prediction prediction) {
          return Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                const Icon(Icons.location_on),
                const SizedBox(
                  width: 7,
                ),
                Expanded(
                    child: Text(
                  prediction.description ?? "",
                  style: FontPalette.poppinsRegular
                      .copyWith(fontSize: 14.sp, fontWeight: FontWeight.w500),
                ))
              ],
            ),
          );
        },

        isCrossBtnShown: true,

        // default 600 ms ,
      ),
    );
  }
}
