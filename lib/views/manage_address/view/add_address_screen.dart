import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/common_widgets/custom_button.dart';
import 'package:laundry/common_widgets/custom_text_from_field.dart';
import 'package:laundry/services/get_it.dart';
import 'package:laundry/services/helpers.dart';
import 'package:laundry/utils/enums.dart';
import 'package:laundry/utils/font_palette.dart';
import 'package:laundry/views/manage_address/view_model/manage_address_view_model.dart';
import 'package:provider/provider.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({Key? key, required this.manageAddressProvider})
      : super(key: key);
  final ManageAddressProvider manageAddressProvider;

  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  Helpers helpers = sl.get<Helpers>();

  @override
  void initState() {
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
          child: Column(
            children: [
              40.verticalSpace,
              CustomTextField(
                controller:
                    widget.manageAddressProvider.addressEditingController,
                labelText: 'Address',
                hintText: 'Enter Your Address',
                // validator: (value) =>
                //     validator.validateEmail(context, value),
              ),
              40.verticalSpace,
              CustomTextField(
                controller: widget.manageAddressProvider.addressCityController,
                labelText: 'City',
                hintText: 'Enter Your city',
                // validator: (value) =>
                //     validator.validateEmail(context, value),
              ),
              40.verticalSpace,
              CustomTextField(
                controller: widget.manageAddressProvider.addressStateController,
                labelText: 'State',
                hintText: 'Enter Your state',
                // validator: (value) =>
                //     validator.validateEmail(context, value),
              ),
              40.verticalSpace,
              Expanded(
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 9.w),
                        child: Selector<ManageAddressProvider, LoaderState>(
                          selector: (context, provider) => provider.loaderState,
                          builder: (context, value, child) => CustomButton(
                            title: 'Add Address',
                            isLoading: value == LoaderState.loading,
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              if (widget.manageAddressProvider
                                      .addressEditingController.text
                                      .trim()
                                      .isEmpty &&
                                  widget.manageAddressProvider
                                      .addressStateController.text
                                      .trim()
                                      .isEmpty &&
                                  widget.manageAddressProvider
                                      .addressCityController.text
                                      .trim()
                                      .isEmpty) {
                                helpers.errorToast(
                                    'Please provide any of above values..');
                              } else {
                                widget.manageAddressProvider.addAddress(
                                  onSuccess: () => widget.manageAddressProvider
                                      .getAddress(
                                          onSuccess: () =>
                                              Navigator.pop(context)),
                                );
                              }
                            },
                          ),
                        ),
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
