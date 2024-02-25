import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/common/extensions.dart';
import 'package:laundry/common_widgets/custom_linear_progress_indicator.dart';
import 'package:laundry/services/route_generator.dart';
import 'package:laundry/utils/color_palette.dart';
import 'package:laundry/utils/enums.dart';
import 'package:laundry/utils/font_palette.dart';
import 'package:laundry/views/manage_address/model/add_address_arguments.dart';
import 'package:laundry/views/manage_address/view/widgets/manage_address_tile.dart';
import 'package:laundry/views/manage_address/view_model/manage_address_view_model.dart';
import 'package:provider/provider.dart';

class ManageAddressScreen extends StatefulWidget {
  const ManageAddressScreen({Key? key, this.isFromCart}) : super(key: key);
  final bool? isFromCart;
  @override
  _ManageAddressScreenState createState() => _ManageAddressScreenState();
}

class _ManageAddressScreenState extends State<ManageAddressScreen> {
  ManageAddressProvider manageAddressProvider = ManageAddressProvider();

  @override
  void initState() {
    manageAddressProvider
      ..getLocation()
      ..getAddress();
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
          (widget.isFromCart ?? false) ? 'Choose Address' : 'Manage Address',
          style: FontPalette.poppinsBold
              .copyWith(color: Colors.black, fontSize: 17.sp),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Icon(
          Icons.add,
          color: ColorPalette.primaryColor,
          size: 40.h,
        ),
        onPressed: () =>
            Navigator.pushNamed(context, RouteGenerator.routeLocationScreen),
        // onPressed: () => Navigator.pushNamed(
        //         context, RouteGenerator.routeAddAddressScreen,
        //         arguments: AddAddressArguments(
        //             manageAddressProvider: manageAddressProvider))
        // .then((value) => manageAddressProvider.clearAddressControllers()),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: ChangeNotifierProvider.value(
          value: manageAddressProvider,
          child: Consumer<ManageAddressProvider>(
            builder: (context, provider, child) {
              switch (provider.loaderState) {
                case LoaderState.loading:
                  return const CustomLinearProgress();
                case LoaderState.loaded:
                  return Padding(
                    padding: EdgeInsets.only(top: 40.h),
                    child: AddressTile(
                      addressList: provider.addressesList,
                      manageAddressProvider: provider,
                      isFromCart: widget.isFromCart,
                    ),
                  );
                case LoaderState.noProducts:
                  return Center(
                    child: Text(
                      'No address found',
                      style: FontPalette.poppinsBold,
                    ),
                  );
                case LoaderState.networkErr:
                  return Center(
                    child: Text(
                      'Network Error',
                      style: FontPalette.poppinsBold,
                    ),
                  );
                case LoaderState.error:
                  return Center(
                    child:
                        Text('Oops...! Error', style: FontPalette.poppinsBold),
                  );
                case LoaderState.noData:
                  return Center(
                    child: Text(
                      'No address Found',
                      style: FontPalette.poppinsBold,
                    ),
                  );
              }
            },
          ),
        ),
      ).withBackgroundImage(),
    );
  }
}
