import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:laundry/common/extensions.dart';
import 'package:laundry/common_widgets/common_fade_in_image.dart';
import 'package:laundry/common_widgets/common_functions.dart';
import 'package:laundry/utils/color_palette.dart';
import 'package:laundry/utils/enums.dart';
import 'package:laundry/utils/font_palette.dart';
import 'package:laundry/views/cart/model/cart_model.dart';
import 'package:laundry/views/cart/view/widgets/add_photo_widget.dart';
import 'package:laundry/views/cart/view/widgets/address_selection_widget.dart';
import 'package:laundry/views/cart/view/widgets/product_card_widget.dart';
import 'package:laundry/views/cart/view_model/cart_view_model.dart';
import 'package:provider/provider.dart';

class NormalService extends StatefulWidget {
  const NormalService({super.key, this.index});
  final int? index;
  @override
  State<NormalService> createState() => _NormalServiceState();
}

class _NormalServiceState extends State<NormalService> {
  TextEditingController pickDateInput = TextEditingController();
  TextEditingController deliveryDateInput = TextEditingController();
  TextEditingController pickTime = TextEditingController();
  TextEditingController deliveryTime = TextEditingController();

  TimeOfDay _pickUpTime = TimeOfDay.now();
  TimeOfDay _pickDeliverTime = TimeOfDay.now();

  void _selectPickTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _pickUpTime,
    );
    if (newTime != null) {
      setState(() {
        _pickUpTime = newTime;
        debugPrint(_pickUpTime.format(context));
        pickTime.text = _pickUpTime.format(context);
      });
    }
  }

  void _selectDeliverTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _pickDeliverTime,
    );
    if (newTime != null) {
      setState(() {
        _pickDeliverTime = newTime;
        deliveryTime.text = _pickDeliverTime.format(context);
        debugPrint(_pickUpTime.format(context));
      });
    }
  }

  CartViewProvider cartProvider = CartViewProvider();

  @override
  void initState() {
    CommonFunctions.afterInit(() {
      if (widget.index == 0) {
        cartProvider
          ..getDefaultAddress()
          ..getNormalService();
      } else {
        cartProvider
          ..getDefaultAddress()
          ..getExpressService();
      }
    });
    pickDateInput.text = "";
    deliveryDateInput.text = "";
    pickTime.text = "";
    deliveryTime.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: cartProvider,
      child: Consumer<CartViewProvider>(
        builder: (context, provider, child) {
          List<Cart>? cart = provider.cartNormalResponse?.cart ?? [];
          switch (provider.loaderState) {
            case LoaderState.loading:
              return const Expanded(
                  child: Center(child: CircularProgressIndicator()));
            case LoaderState.loaded:
              return Expanded(
                child: SingleChildScrollView(
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      SingleChildScrollView(
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
                              Row(
                                children: [
                                  Flexible(
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: const Color(0xfff3f3f4),
                                            borderRadius:
                                                BorderRadius.circular(10.r)),
                                        height: 50.h,
                                        child: Center(
                                            child: TextField(
                                          controller: pickDateInput,
                                          style: FontPalette.poppinsRegular
                                              .copyWith(
                                                  color:
                                                      const Color(0xff404041),
                                                  fontSize: 13.sp),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            suffixIcon: const Icon(
                                              Icons.arrow_forward_ios,
                                              color: Colors.black,
                                              size: 15,
                                            ),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 15.w,
                                                    vertical: 15.h),
                                            hintText: "Pickup Date",
                                            hintStyle: FontPalette
                                                .poppinsRegular
                                                .copyWith(
                                                    color:
                                                        const Color(0xff404041),
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
                                              setState(() {
                                                pickDateInput.text =
                                                    formattedDate;
                                              });
                                            } else {}
                                          },
                                        ))),
                                  ),
                                  12.horizontalSpace,
                                  Flexible(
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: const Color(0xfff3f3f4),
                                            borderRadius:
                                                BorderRadius.circular(10.r)),
                                        height: 50.h,
                                        child: Center(
                                            child: TextField(
                                          controller: pickTime,
                                          style: FontPalette.poppinsRegular
                                              .copyWith(
                                                  color:
                                                      const Color(0xff404041),
                                                  fontSize: 13.sp),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            suffixIcon: const Icon(
                                              Icons.arrow_forward_ios,
                                              color: Colors.black,
                                              size: 15,
                                            ),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 15.w,
                                                    vertical: 15.h),
                                            hintText: "Pickup Time",
                                            hintStyle: FontPalette
                                                .poppinsRegular
                                                .copyWith(
                                                    color:
                                                        const Color(0xff404041),
                                                    fontSize: 11.sp),
                                          ),
                                          readOnly: true,
                                          onTap: () async {
                                            _selectPickTime();
                                          },
                                        ))),
                                  ),
                                ],
                              ),
                              12.verticalSpace,
                              Row(
                                children: [
                                  Flexible(
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: const Color(0xfff3f3f4),
                                            borderRadius:
                                                BorderRadius.circular(10.r)),
                                        height: 50.h,
                                        child: Center(
                                            child: TextField(
                                          controller: deliveryDateInput,
                                          style: FontPalette.poppinsRegular
                                              .copyWith(
                                                  color:
                                                      const Color(0xff404041),
                                                  fontSize: 13.sp),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            suffixIcon: const Icon(
                                              Icons.arrow_forward_ios,
                                              color: Colors.black,
                                              size: 15,
                                            ),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 15.w,
                                                    vertical: 15.h),
                                            hintText: "Delivery Date",
                                            hintStyle: FontPalette
                                                .poppinsRegular
                                                .copyWith(
                                                    color:
                                                        const Color(0xff404041),
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
                                              setState(() {
                                                deliveryDateInput.text =
                                                    formattedDate;
                                              });
                                            } else {}
                                          },
                                        ))),
                                  ),
                                  12.horizontalSpace,
                                  Flexible(
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: const Color(0xfff3f3f4),
                                            borderRadius:
                                                BorderRadius.circular(10.r)),
                                        height: 50.h,
                                        child: Center(
                                            child: TextField(
                                          controller: deliveryTime,
                                          style: FontPalette.poppinsRegular
                                              .copyWith(
                                                  color:
                                                      const Color(0xff404041),
                                                  fontSize: 13.sp),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            suffixIcon: const Icon(
                                              Icons.arrow_forward_ios,
                                              color: Colors.black,
                                              size: 15,
                                            ),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 15.w,
                                                    vertical: 15.h),
                                            hintText: "Delivery Time",
                                            hintStyle: FontPalette
                                                .poppinsRegular
                                                .copyWith(
                                                    color:
                                                        const Color(0xff404041),
                                                    fontSize: 11.sp),
                                          ),
                                          readOnly: true,
                                          onTap: () async {
                                            _selectDeliverTime();
                                          },
                                        ))),
                                  ),
                                ],
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
                              Text(
                                "Your Items",
                                style: FontPalette.poppinsBold.copyWith(
                                    color: Colors.black, fontSize: 10.sp),
                              ),
                              15.verticalSpace,
                              Container(
                                height: 200.h * 1,
                                padding: EdgeInsets.all(10.r),
                                width: double.maxFinite,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    border: Border.all(
                                        color: const Color.fromARGB(
                                            255, 128, 128, 128),
                                        width: 1)),
                                child: ListView.builder(
                                  itemCount: cart.length,
                                  itemBuilder: (context, index) {
                                    Cart item = cart[index];
                                    return ProductCardWidget(
                                        productName: item.product?.name ?? "",
                                        amount: item.amount.toString(),
                                        productImage: item.product?.image ?? "",
                                        service: item.service?.name ?? "",
                                        qty: item.quantity);
                                  },
                                ),
                              ),
                              15.verticalSpace,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                      ),
                                      child: const Text('Continue shopping')),
                                  ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                      ),
                                      child: const Text('Cancel Order'))
                                ],
                              ),
                              180.verticalSpace
                            ],
                          ),
                        ),
                      ),
                      //
                      // total section
                      Container(
                        color: const Color(0xfff3f3f4),
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        width: double.maxFinite,
                        height: 100.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Text(
                                    "Total (incl. VAT): ",
                                    style: FontPalette.poppinsRegular.copyWith(
                                        color: const Color(0xff404041),
                                        fontSize: 12.sp),
                                  ),
                                  Flexible(
                                    child: Text(
                                      "AED 45.00",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: FontPalette.poppinsRegular
                                          .copyWith(
                                              color: ColorPalette.greenColor,
                                              fontSize: 15.sp),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                                child: const Text('Make Payment')),
                          ],
                        ),
                      )
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
