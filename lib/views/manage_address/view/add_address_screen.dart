import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/common_widgets/common_functions.dart';
import 'package:laundry/common_widgets/custom_button.dart';
import 'package:laundry/common_widgets/custom_text_from_field.dart';
import 'package:laundry/services/get_it.dart';
import 'package:laundry/services/helpers.dart';
import 'package:laundry/services/route_generator.dart';
import 'package:laundry/utils/enums.dart';
import 'package:laundry/utils/font_palette.dart';
import 'package:laundry/utils/validator.dart';
import 'package:laundry/views/manage_address/view_model/manage_address_view_model.dart';
import 'package:provider/provider.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key, required this.manageAddressProvider});
  final ManageAddressProvider manageAddressProvider;

  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final Helpers helpers = sl.get<Helpers>();
  final Validator validator = sl.get<Validator>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    CommonFunctions.afterInit(() => widget.manageAddressProvider.clearValues());
    super.dispose();
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
          'Add Address',
          style: FontPalette.poppinsBold
              .copyWith(color: Colors.black, fontSize: 17.sp),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 24.w),
        child: ChangeNotifierProvider.value(
          value: widget.manageAddressProvider,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        40.verticalSpace,
                        CustomTextField(
                          controller: widget.manageAddressProvider
                              .buildingNumberEditingController,
                          labelText: 'Building Number',
                          hintText: 'Enter Your Building Number',
                          validator: (value) => validator.validateEmptyField(
                              context,
                              widget.manageAddressProvider
                                  .buildingNumberEditingController.text
                                  .trim()),
                        ),
                        40.verticalSpace,
                        CustomTextField(
                          controller: widget
                              .manageAddressProvider.addressStreetController,
                          labelText: 'Street Name',
                          hintText: 'Enter Your Street Name',
                          validator: (value) => validator.validateEmptyField(
                              context,
                              widget.manageAddressProvider
                                  .addressStreetController.text
                                  .trim()),
                        ),
                        40.verticalSpace,
                        CustomTextField(
                          controller: widget
                              .manageAddressProvider.addressCityController,
                          labelText: 'City',
                          hintText: 'Enter Your City',
                          validator: (value) => validator.validateEmptyField(
                              context,
                              widget.manageAddressProvider.addressCityController
                                  .text
                                  .trim()),
                        ),
                        40.verticalSpace,
                        CustomTextField(
                          controller: widget
                              .manageAddressProvider.addressEmirateController,
                          labelText: 'Emirate',
                          hintText: 'Enter Your Emirate',
                          validator: (value) => validator.validateEmptyField(
                              context,
                              widget.manageAddressProvider
                                  .addressEmirateController.text
                                  .trim()),
                        ),
                        60.verticalSpace
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 9.w,
                  ),
                  child: Selector<ManageAddressProvider, LoaderState>(
                    selector: (context, provider) => provider.loaderState,
                    builder: (context, value, child) => CustomButton(
                      title: 'Confirm Address',
                      isLoading: value == LoaderState.loading,
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        if (_formKey.currentState != null) {
                          if (_formKey.currentState!.validate()) {
                            widget.manageAddressProvider.addAddress(
                              onSuccess: () => widget.manageAddressProvider
                                  .getAddress(
                                      onSuccess: () => Navigator.popUntil(
                                          context,
                                          (route) =>
                                              route.settings.name ==
                                              RouteGenerator
                                                  .routeAddressScreen)),
                              onFailure: () => helpers.errorToast(
                                  widget.manageAddressProvider.errorMessage ??
                                      'Oops something went wrong'),
                            );
                          }
                        }
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
