import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:laundry/common_widgets/common_functions.dart';
import 'package:laundry/common_widgets/custom_button.dart';
import 'package:laundry/common_widgets/custom_linear_progress_indicator.dart';
import 'package:laundry/services/get_it.dart';
import 'package:laundry/services/helpers.dart';
import 'package:laundry/services/route_generator.dart';
import 'package:laundry/utils/enums.dart';
import 'package:laundry/utils/font_palette.dart';
import 'package:laundry/views/cart/model/cart_model.dart';
import 'package:laundry/views/cart/view/widgets/add_photo_widget.dart';
import 'package:laundry/views/cart/view/widgets/address_selection_widget.dart';
import 'package:laundry/views/cart/view/widgets/time_slot_tile.dart';
import 'package:laundry/views/cart/view_model/cart_view_model.dart';
import 'package:provider/provider.dart';

class NormalService extends StatefulWidget {
  const NormalService({super.key, this.index});
  final int? index;
  @override
  State<NormalService> createState() => _NormalServiceState();
}

class _NormalServiceState extends State<NormalService> {
  late CartViewProvider cartProvider;
  Helpers helpers = sl.get<Helpers>();
  @override
  void initState() {
    cartProvider = context.read<CartViewProvider>();
    CommonFunctions.afterInit(() {
      cartProvider
        ..getTimeSlots()
        ..getDefaultAddress();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
          "Cart",
          style: FontPalette.poppinsBold
              .copyWith(color: Colors.black, fontSize: 17.sp),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Consumer<CartViewProvider>(
        builder: (context, provider, child) {
          List<Cart>? cart = provider.cartNormalResponse?.cart ?? [];
          switch (provider.loaderState) {
            case LoaderState.loading:
              return const CustomLinearProgress();
            case LoaderState.loaded:
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: IgnorePointer(
                        ignoring: provider.btnLoaderState,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              10.verticalSpace,
                              AddressSelectionWidget(
                                address:
                                    cartProvider.defaultAddress?['house_no'] ??
                                        'N/A',
                                cartViewProvider: cartProvider,
                              ),
                              20.verticalSpace,
                              Text('Pick up Date',
                                  style: FontPalette.poppinsRegular.copyWith(
                                      color: const Color(0xff404041),
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.w500)),
                              5.verticalSpace,
                              Container(
                                  decoration: BoxDecoration(
                                      color: const Color(0xfff3f3f4),
                                      borderRadius:
                                          BorderRadius.circular(10.r)),
                                  height: 50.h,
                                  child: Center(
                                      child: TextField(
                                    controller: cartProvider.pickDateController,
                                    style: FontPalette.poppinsRegular.copyWith(
                                        color: const Color(0xff404041),
                                        fontSize: 13.sp),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      suffixIcon: const Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.black,
                                        size: 15,
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 15.w, vertical: 15.h),
                                      hintText: "Pickup Date",
                                      hintStyle: FontPalette.poppinsRegular
                                          .copyWith(
                                              color: const Color(0xff404041),
                                              fontSize: 11.sp),
                                    ),
                                    readOnly: true,
                                    onTap: () async {
                                      DateTime? pickedDate =
                                          await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime.now(),
                                              lastDate: DateTime(2100));

                                      if (pickedDate != null) {
                                        String formattedDate =
                                            DateFormat('yyyy-MM-dd')
                                                .format(pickedDate);

                                        cartProvider.pickDateController.text =
                                            formattedDate;
                                        cartProvider.updateIsCatFormValidated();
                                      }
                                    },
                                  ))),
                              12.verticalSpace,
                              Text('Select Slots',
                                  style: FontPalette.poppinsRegular.copyWith(
                                      color: const Color(0xff404041),
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.w500)),
                              GridView.builder(
                                itemCount: provider.pickUpTimeSlotsList.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        mainAxisExtent: 40,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10,
                                        crossAxisCount: 2),
                                itemBuilder: (context, index) {
                                  bool isAvailable = helpers
                                          .checkSelectedDateAndCurrentDateIsSame(
                                              cartProvider
                                                  .pickDateController.text
                                                  .trim())
                                      ? helpers.checkTimeSlotIsAvailableOrNot(
                                          provider.pickUpTimeSlotsList[index]
                                                  .to ??
                                              '10:00 AM')
                                      // helpers.returnGreaterTimeFlag(
                                      //         (helpers.convertTo24HoursFormat(
                                      //             (provider
                                      //                         .pickUpTimeSlotsList[
                                      //                             index]
                                      //                         .to ??
                                      //                     '10:00 am')
                                      //                 .split(' ')[0])),
                                      //         helpers
                                      //             .convertCurrentDateTimeTo24HoursFormat())
                                      : true;
                                  return TimeSlotTile(
                                      onTap: isAvailable
                                          ? () => provider
                                              .updatePickUpTimeSlotIndex(index)
                                          : null,
                                      isAvailable: isAvailable,
                                      isSelectedIndex: isAvailable
                                          ? index ==
                                              provider.pickUpTimeSlotIndex
                                          : false,
                                      title:
                                          '${provider.pickUpTimeSlotsList[index].from} - ${provider.pickUpTimeSlotsList[index].to}');
                                },
                              ),
                              20.verticalSpace,
                              Text(
                                "Add Your Comments",
                                style: FontPalette.poppinsBold.copyWith(
                                    color: Colors.black, fontSize: 11.sp),
                              ),
                              15.verticalSpace,
                              Container(
                                height: 100,
                                width: double.maxFinite,
                                decoration: BoxDecoration(
                                  color: const Color(0xfff3f3f4),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller:
                                            cartProvider.commentsController,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 15.w, vertical: 10.h),
                                          border: InputBorder.none,
                                        ),
                                        maxLines: null,
                                        expands: true,
                                        keyboardType: TextInputType.multiline,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              10.verticalSpace,
                              AddPhotoWidget(cartViewProvider: cartProvider),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                        // color: const Color(0xfff3f3f4),
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        width: double.maxFinite,
                        height: 100.h,
                        child: CustomButton(
                          isLoading: provider.btnLoaderState,
                          width: double.maxFinite,
                          height: 48,
                          title: 'Place Order',
                          textStyle: FontPalette.poppinsBold
                              .copyWith(fontSize: 15.sp, color: Colors.white),
                          isEnabled: provider.isCartFormValidated,
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            String deliveryAt =
                                '${cartProvider.deliveryDateController.text.trim()} ${cartProvider.deliveryTimeForApiCall}';
                            String pickUpAt =
                                '${cartProvider.pickDateController.text.trim()} ${cartProvider.pickUpTimeForApiCall}';

                            cartProvider.createOrderRequest({
                              'service_id': widget.index == 0 ? '1' : '2',
                              'service_type':
                                  widget.index == 0 ? 'normal' : 'express',
                              'address_id':
                                  cartProvider.defaultAddress?['id'].toString(),
                              'comments':
                                  cartProvider.commentsController.text.trim(),
                              'pickup_at': pickUpAt.trim(),
                              'time_slot_id':
                                  cartProvider.pickUpTimeSlotId.toString()
                            },
                                onSuccess: () {
                                  helpers.successToast(
                                      'Order Placed Successfully...!');
                                  cartProvider.clearValues();
                                  Navigator.popUntil(
                                    context,
                                    (route) =>
                                        route.settings.name ==
                                        RouteGenerator.routeMainScreen,
                                  );
                                },
                                onFailure: () => helpers.errorToast(
                                    'OOps...! Something went wrong...!'));
                          },
                        )),
                  ),
                ],
              );
            case LoaderState.noProducts:
              return Center(
                child: Text(
                  'No Data found',
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
                child: Text('Oops...! Error', style: FontPalette.poppinsBold),
              );
            case LoaderState.noData:
              return Center(
                child: Text(
                  'No Data Found',
                  style: FontPalette.poppinsBold,
                ),
              );

            //
          }
        },
      ),
    );
  }
}
