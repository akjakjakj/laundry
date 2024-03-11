import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/common/extensions.dart';
import 'package:laundry/services/route_generator.dart';
import 'package:laundry/utils/color_palette.dart';
import 'package:laundry/utils/font_palette.dart';
import 'package:laundry/views/cart/view_model/cart_view_model.dart';
import 'package:laundry/views/manage_address/model/add_address_arguments.dart';

class AddressSelectionWidget extends StatelessWidget {
  const AddressSelectionWidget(
      {Key? key, this.address, required this.cartViewProvider})
      : super(key: key);
  final String? address;
  final CartViewProvider cartViewProvider;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Choose Address',
              style: FontPalette.poppinsBold.copyWith(fontSize: 18.sp),
            ),
            InkWell(
              onTap: () => Navigator.pushNamed(
                      context, RouteGenerator.routeAddressScreen,
                      arguments: ManageAddressArguments(isFromCart: true))
                  .then((value) => cartViewProvider.getDefaultAddress()),
              child: Row(
                children: [
                  Icon(
                    Icons.add,
                    color: ColorPalette.primaryColor,
                    size: 13.h,
                  ),
                  3.horizontalSpace,
                  Text(
                    'Change Address',
                    style: FontPalette.poppinsRegular.copyWith(
                        color: ColorPalette.primaryColor, fontSize: 13.sp),
                  )
                ],
              ),
            ).removeSplash()
          ],
        ),
        25.verticalSpace,
        Container(
          height: 53.h,
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: const Color(0xfff3f3f4),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Column(
            children: [
              TextField(
                enabled: false,
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                    border: InputBorder.none,
                    hintText: address ?? 'Current Address',
                    hintStyle:
                        FontPalette.poppinsRegular.copyWith(fontSize: 13.sp)),
                keyboardType: TextInputType.multiline,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
