import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:laundry/common_widgets/common_functions.dart';
import 'package:laundry/common_widgets/custom_button.dart';
import 'package:laundry/common_widgets/custom_linear_progress_indicator.dart';
import 'package:laundry/common_widgets/stack_loader.dart';
import 'package:laundry/services/get_it.dart';
import 'package:laundry/services/helpers.dart';
import 'package:laundry/services/route_generator.dart';
import 'package:laundry/utils/enums.dart';
import 'package:laundry/utils/font_palette.dart';
import 'package:laundry/views/cart/model/cart_model.dart';
import 'package:laundry/views/cart/model/place_order_request.dart';
import 'package:laundry/views/cart/view/widgets/add_photo_widget.dart';
import 'package:laundry/views/cart/view/widgets/address_selection_widget.dart';
import 'package:laundry/views/cart/view/widgets/product_card_widget.dart';
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
    cartProvider.clearDateAndTime();
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
              return StackLoader(
                inAsyncCall: provider.btnLoaderState,
                child: SingleChildScrollView(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      IgnorePointer(
                        ignoring: provider.btnLoaderState,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              10.verticalSpace,
                              AddressSelectionWidget(
                                address:
                                    cartProvider.defaultAddress?['address'],
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
                                              firstDate: DateTime(1950),
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
                                itemBuilder: (context, index) => TimeSlotTile(
                                    onTap: () => provider
                                        .updatePickUpTimeSlotIndex(index),
                                    isSelectedIndex:
                                        index == provider.pickUpTimeSlotIndex,
                                    title:
                                        '${provider.pickUpTimeSlotsList[index].from} - ${provider.pickUpTimeSlotsList[index].to}'),
                              ),
                              // Row(
                              //   children: [
                              //     Flexible(
                              //       child: Container(
                              //           decoration: BoxDecoration(
                              //               color: const Color(0xfff3f3f4),
                              //               borderRadius:
                              //                   BorderRadius.circular(10.r)),
                              //           height: 50.h,
                              //           child: Center(
                              //               child: TextField(
                              //             controller:
                              //                 cartProvider.pickDateController,
                              //             style: FontPalette.poppinsRegular
                              //                 .copyWith(
                              //                     color:
                              //                         const Color(0xff404041),
                              //                     fontSize: 13.sp),
                              //             decoration: InputDecoration(
                              //               border: InputBorder.none,
                              //               suffixIcon: const Icon(
                              //                 Icons.arrow_forward_ios,
                              //                 color: Colors.black,
                              //                 size: 15,
                              //               ),
                              //               contentPadding:
                              //                   EdgeInsets.symmetric(
                              //                       horizontal: 15.w,
                              //                       vertical: 15.h),
                              //               hintText: "Pickup Date",
                              //               hintStyle: FontPalette
                              //                   .poppinsRegular
                              //                   .copyWith(
                              //                       color: const Color(
                              //                           0xff404041),
                              //                       fontSize: 11.sp),
                              //             ),
                              //             readOnly: true,
                              //             onTap: () async {
                              //               DateTime? pickedDate =
                              //                   await showDatePicker(
                              //                       context: context,
                              //                       initialDate:
                              //                           DateTime.now(),
                              //                       firstDate: DateTime(1950),
                              //                       lastDate: DateTime(2100));
                              //
                              //               if (pickedDate != null) {
                              //                 String formattedDate =
                              //                     DateFormat('yyyy-MM-dd')
                              //                         .format(pickedDate);
                              //
                              //                 cartProvider.pickDateController
                              //                     .text = formattedDate;
                              //                 cartProvider
                              //                     .updateIsCatFormValidated();
                              //               }
                              //             },
                              //           ))),
                              //     ),
                              //     12.horizontalSpace,
                              //     Flexible(
                              //       child: Container(
                              //           decoration: BoxDecoration(
                              //               color: const Color(0xfff3f3f4),
                              //               borderRadius:
                              //                   BorderRadius.circular(10.r)),
                              //           height: 50.h,
                              //           child: Center(
                              //               child: TextField(
                              //             controller: cartProvider
                              //                 .pickUpTimeController,
                              //             style: FontPalette.poppinsRegular
                              //                 .copyWith(
                              //                     color:
                              //                         const Color(0xff404041),
                              //                     fontSize: 13.sp),
                              //             decoration: InputDecoration(
                              //               border: InputBorder.none,
                              //               suffixIcon: const Icon(
                              //                 Icons.arrow_forward_ios,
                              //                 color: Colors.black,
                              //                 size: 15,
                              //               ),
                              //               contentPadding:
                              //                   EdgeInsets.symmetric(
                              //                       horizontal: 15.w,
                              //                       vertical: 15.h),
                              //               hintText: "Pickup Time",
                              //               hintStyle: FontPalette
                              //                   .poppinsRegular
                              //                   .copyWith(
                              //                       color: const Color(
                              //                           0xff404041),
                              //                       fontSize: 11.sp),
                              //             ),
                              //             readOnly: true,
                              //             onTap: () async {
                              //               cartProvider
                              //                   .selectPickTime(context);
                              //             },
                              //           ))),
                              //     ),
                              //   ],
                              // ),
                              12.verticalSpace,
                              Text('Delivery Date',
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
                                    controller:
                                        cartProvider.deliveryDateController,
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
                                      hintText: "Delivery Date",
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
                                              firstDate: DateTime(1950),
                                              lastDate: DateTime(2100));

                                      if (pickedDate != null) {
                                        String formattedDate =
                                            DateFormat('yyyy-MM-dd')
                                                .format(pickedDate);

                                        cartProvider.deliveryDateController
                                            .text = formattedDate;
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
                                itemCount: provider.deliveryTimeSlotList.length,
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
                                itemBuilder: (context, index) => TimeSlotTile(
                                    onTap: () => provider
                                        .updateDeliveryTimeSlotIndex(index),
                                    isSelectedIndex:
                                        index == provider.deliveryTimeSlotIndex,
                                    title:
                                        '${provider.deliveryTimeSlotList[index].from} - ${provider.deliveryTimeSlotList[index].to}'),
                              ),
                              // Row(
                              //   children: [
                              //     Flexible(
                              //       child: Container(
                              //           decoration: BoxDecoration(
                              //               color: const Color(0xfff3f3f4),
                              //               borderRadius:
                              //                   BorderRadius.circular(10.r)),
                              //           height: 50.h,
                              //           child: Center(
                              //               child: TextField(
                              //             controller: cartProvider
                              //                 .deliveryDateController,
                              //             style: FontPalette.poppinsRegular
                              //                 .copyWith(
                              //                     color:
                              //                         const Color(0xff404041),
                              //                     fontSize: 13.sp),
                              //             decoration: InputDecoration(
                              //               border: InputBorder.none,
                              //               suffixIcon: const Icon(
                              //                 Icons.arrow_forward_ios,
                              //                 color: Colors.black,
                              //                 size: 15,
                              //               ),
                              //               contentPadding:
                              //                   EdgeInsets.symmetric(
                              //                       horizontal: 15.w,
                              //                       vertical: 15.h),
                              //               hintText: "Delivery Date",
                              //               hintStyle: FontPalette
                              //                   .poppinsRegular
                              //                   .copyWith(
                              //                       color: const Color(
                              //                           0xff404041),
                              //                       fontSize: 11.sp),
                              //             ),
                              //             readOnly: true,
                              //             onTap: () async {
                              //               DateTime? pickedDate =
                              //                   await showDatePicker(
                              //                       context: context,
                              //                       initialDate:
                              //                           DateTime.now(),
                              //                       firstDate: DateTime(1950),
                              //                       lastDate: DateTime(2100));
                              //
                              //               if (pickedDate != null) {
                              //                 String formattedDate =
                              //                     DateFormat('yyyy-MM-dd')
                              //                         .format(pickedDate);
                              //
                              //                 cartProvider
                              //                     .deliveryDateController
                              //                     .text = formattedDate;
                              //                 cartProvider
                              //                     .updateIsCatFormValidated();
                              //               }
                              //             },
                              //           ))),
                              //     ),
                              //     12.horizontalSpace,
                              //     Flexible(
                              //       child: Container(
                              //           decoration: BoxDecoration(
                              //               color: const Color(0xfff3f3f4),
                              //               borderRadius:
                              //                   BorderRadius.circular(10.r)),
                              //           height: 50.h,
                              //           child: Center(
                              //               child: TextField(
                              //             controller: cartProvider
                              //                 .deliveryTimeController,
                              //             style: FontPalette.poppinsRegular
                              //                 .copyWith(
                              //                     color:
                              //                         const Color(0xff404041),
                              //                     fontSize: 13.sp),
                              //             decoration: InputDecoration(
                              //               border: InputBorder.none,
                              //               suffixIcon: const Icon(
                              //                 Icons.arrow_forward_ios,
                              //                 color: Colors.black,
                              //                 size: 15,
                              //               ),
                              //               contentPadding:
                              //                   EdgeInsets.symmetric(
                              //                       horizontal: 15.w,
                              //                       vertical: 15.h),
                              //               hintText: "Delivery Time",
                              //               hintStyle: FontPalette
                              //                   .poppinsRegular
                              //                   .copyWith(
                              //                       color: const Color(
                              //                           0xff404041),
                              //                       fontSize: 11.sp),
                              //             ),
                              //             readOnly: true,
                              //             onTap: () async {
                              //               cartProvider
                              //                   .selectDeliverTime(context);
                              //             },
                              //           ))),
                              //     ),
                              //   ],
                              // ),
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
                              15.verticalSpace,
                              // Text(
                              //   "Your Items",
                              //   style: FontPalette.poppinsBold.copyWith(
                              //       color: Colors.black, fontSize: 10.sp),
                              // ),
                              // 15.verticalSpace,
                              // Container(
                              //   height: 200.h * 1,
                              //   padding: EdgeInsets.all(10.r),
                              //   width: double.maxFinite,
                              //   decoration: BoxDecoration(
                              //       borderRadius: BorderRadius.circular(10.r),
                              //       border: Border.all(
                              //           color: const Color.fromARGB(
                              //               255, 128, 128, 128),
                              //           width: 1)),
                              //   child: ListView.builder(
                              //     itemCount: cart.length,
                              //     itemBuilder: (context, index) {
                              //       Cart item = cart[index];
                              //       return ProductCardWidget(
                              //         cartViewProvider: cartProvider,
                              //         productName: item.product?.name ?? "",
                              //         amount: item.amount.toString(),
                              //         productImage: item.product?.image ?? "",
                              //         service: item.service?.name ?? "",
                              //         qty: item.quantity,
                              //         cartId: item.id,
                              //         index: widget.index,
                              //       );
                              //     },
                              //   ),
                              // ),
                              // 15.verticalSpace,
                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     ElevatedButton(
                              //         onPressed: () => Navigator.pop(context),
                              //         style: ElevatedButton.styleFrom(
                              //           shape: RoundedRectangleBorder(
                              //             borderRadius:
                              //                 BorderRadius.circular(30.0),
                              //           ),
                              //         ),
                              //         child: const Text('Continue shopping')),
                              //     ElevatedButton(
                              //         onPressed: () =>
                              //             Navigator.pushNamedAndRemoveUntil(
                              //                 context,
                              //                 RouteGenerator.routeMainScreen,
                              //                 (route) => false),
                              //         style: ElevatedButton.styleFrom(
                              //           backgroundColor: Colors.red,
                              //           shape: RoundedRectangleBorder(
                              //             borderRadius:
                              //                 BorderRadius.circular(30.0),
                              //           ),
                              //         ),
                              //         child: const Text('Cancel Order'))
                              //   ],
                              // ),
                              180.verticalSpace
                            ],
                          ),
                        ),
                      ),
                      //
                      // total section

                      Positioned(
                        bottom: 0,
                        right: 0,
                        left: 0,
                        child: Container(
                            color: const Color(0xfff3f3f4),
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            width: double.maxFinite,
                            height: 100.h,
                            child: CustomButton(
                              width: double.maxFinite,
                              height: 48,
                              title: 'Place Order',
                              textStyle: FontPalette.poppinsBold.copyWith(
                                  fontSize: 15.sp, color: Colors.white),
                              isEnabled: provider.isCartFormValidated,
                              onTap: () {
                                String deliveryAt =
                                    '${cartProvider.deliveryDateController.text.trim()} ${cartProvider.deliveryTimeForApiCall}';
                                String pickUpAt =
                                    '${cartProvider.pickDateController.text.trim()} ${cartProvider.pickUpTimeForApiCall}';

                                cartProvider.createOrder(
                                    PlaceOrderRequest(
                                      image: cartProvider.imageFilesList,
                                      serviceId: widget.index == 0 ? 1 : 2,
                                      serviceType: widget.index == 0
                                          ? 'normal'
                                          : 'express',
                                      addressId:
                                          cartProvider.defaultAddress?['id'],
                                      comments: cartProvider
                                          .commentsController.text
                                          .trim(),
                                      deliveryAt: deliveryAt,
                                      pickupAt: pickUpAt,
                                    ),
                                    onSuccess: () {
                                      helpers.successToast(
                                          'Order Placed Successfully...!');
                                      Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          RouteGenerator.routeMainScreen,
                                          (route) => false);
                                    },
                                    onFailure: () => helpers.errorToast(
                                        'OOps...! Something went wrong...!'));
                              },
                            )
                            // Row(
                            //   children: [
                            //     // Expanded(
                            //     //   child: Row(
                            //     //     children: [
                            //     //       Text(
                            //     //         "Total (incl. VAT): ",
                            //     //         style: FontPalette.poppinsRegular
                            //     //             .copyWith(
                            //     //                 color: const Color(0xff404041),
                            //     //                 fontSize: 12.sp),
                            //     //       ),
                            //     //       Flexible(
                            //     //         child: Text(
                            //     //           "AED ${cartProvider.cartNormalResponse?.total}",
                            //     //           overflow: TextOverflow.ellipsis,
                            //     //           maxLines: 1,
                            //     //           style: FontPalette.poppinsRegular
                            //     //               .copyWith(
                            //     //                   color:
                            //     //                       ColorPalette.greenColor,
                            //     //                   fontSize: 15.sp),
                            //     //         ),
                            //     //       ),
                            //     //     ],
                            //     //   ),
                            //     // ),
                            //     // CustomButton(
                            //     //   width: 300.w,
                            //     //   height: 48,
                            //     //   title: 'Place Order',
                            //     //   textStyle: FontPalette.poppinsRegular.copyWith(
                            //     //       fontSize: 13.sp, color: Colors.white),
                            //     //   isEnabled: provider.isCartFormValidated,
                            //     //   onTap: () {
                            //     //     String deliveryAt =
                            //     //         '${cartProvider.deliveryDateController.text.trim()} ${cartProvider.deliveryTimeForApiCall}';
                            //     //     String pickUpAt =
                            //     //         '${cartProvider.pickDateController.text.trim()} ${cartProvider.pickUpTimeForApiCall}';
                            //     //
                            //     //     cartProvider.createOrder(
                            //     //         PlaceOrderRequest(
                            //     //           image: cartProvider.imageFilesList,
                            //     //           serviceId: widget.index == 0 ? 1 : 2,
                            //     //           serviceType: widget.index == 0
                            //     //               ? 'normal'
                            //     //               : 'express',
                            //     //           addressId:
                            //     //               cartProvider.defaultAddress?['id'],
                            //     //           comments: cartProvider
                            //     //               .commentsController.text
                            //     //               .trim(),
                            //     //           deliveryAt: deliveryAt,
                            //     //           pickupAt: pickUpAt,
                            //     //         ),
                            //     //         onSuccess: () {
                            //     //           helpers.successToast(
                            //     //               'Order Placed Successfully...!');
                            //     //           Navigator.pushNamedAndRemoveUntil(
                            //     //               context,
                            //     //               RouteGenerator.routeMainScreen,
                            //     //               (route) => false);
                            //     //         },
                            //     //         onFailure: () => helpers.errorToast(
                            //     //             'OOps...! Something went wrong...!'));
                            //     //   },
                            //     // )
                            //     // ElevatedButton(
                            //     //     onPressed: () {
                            //     //       String deliveryAt =
                            //     //           '${cartProvider.deliveryDateInput.text.trim()} ${cartProvider.deliveryTime}';
                            //     //       String pickUpAt =
                            //     //           '${cartProvider.pickDateInput.text.trim()} ${cartProvider.pickTime}';
                            //     //       cartProvider.createOrder(
                            //     //           PlaceOrderRequest(
                            //     //             image: cartProvider.imageFilesList,
                            //     //             serviceId:
                            //     //                 widget.index == 0 ? 1 : 2,
                            //     //             serviceType: widget.index == 0
                            //     //                 ? 'normal'
                            //     //                 : 'express',
                            //     //             addressId: cartProvider
                            //     //                 .defaultAddress?['id'],
                            //     //             comments: cartProvider
                            //     //                 .commentsController.text
                            //     //                 .trim(),
                            //     //             deliveryAt: deliveryAt,
                            //     //             pickupAt: pickUpAt,
                            //     //           ),
                            //     //           onSuccess: () {
                            //     //             helpers.successToast(
                            //     //                 'Order Placed Successfully...!');
                            //     //             Navigator.pushNamedAndRemoveUntil(
                            //     //                 context,
                            //     //                 RouteGenerator.routeMainScreen,
                            //     //                 (route) => false);
                            //     //           },
                            //     //           onFailure: () => helpers.errorToast(
                            //     //               'OOps...! Something went wrong...!'));
                            //     //     },
                            //     //     style: ElevatedButton.styleFrom(
                            //     //       shape: RoundedRectangleBorder(
                            //     //         borderRadius:
                            //     //             BorderRadius.circular(30.0),
                            //     //       ),
                            //     //     ),
                            //     //     child: const Text('Place Order')),
                            //   ],
                            // ),
                            ),
                      ),
                    ],
                  ),
                ),
              );
            case LoaderState.noProducts:
              return Expanded(
                child: Center(
                  child: Text(
                    'No Data found',
                    style: FontPalette.poppinsBold,
                  ),
                ),
              );
            case LoaderState.networkErr:
              return Expanded(
                child: Center(
                  child: Text(
                    'Network Error',
                    style: FontPalette.poppinsBold,
                  ),
                ),
              );
            case LoaderState.error:
              return Expanded(
                child: Center(
                  child: Text('Oops...! Error', style: FontPalette.poppinsBold),
                ),
              );
            case LoaderState.noData:
              return Expanded(
                child: Center(
                  child: Text(
                    'No Data Found',
                    style: FontPalette.poppinsBold,
                  ),
                ),
              );

            //
          }
        },
      ),
    );
  }
}
