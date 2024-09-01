import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/common/extensions.dart';
import 'package:laundry/common_widgets/common_functions.dart';
import 'package:laundry/common_widgets/custom_alert_dialogue.dart';
import 'package:laundry/services/get_it.dart';
import 'package:laundry/services/shared_preference_helper.dart';
import 'package:laundry/utils/color_palette.dart';
import 'package:laundry/utils/font_palette.dart';
import 'package:laundry/views/manage_address/model/manage_address_response_model.dart';
import 'package:laundry/views/manage_address/view_model/manage_address_view_model.dart';

class AddressTile extends StatelessWidget {
  AddressTile(
      {super.key,
      required this.addressList,
      this.manageAddressProvider,
      this.isFromCart});
  final List<Addresses> addressList;
  final ManageAddressProvider? manageAddressProvider;
  final bool? isFromCart;
  final SharedPreferencesHelper sharedPreferencesHelper =
      sl.get<SharedPreferencesHelper>();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: addressList.length,
      padding: const EdgeInsets.only(top: 40.0, bottom: 25.0),
      itemBuilder: (context, index) => Container(
        padding: EdgeInsets.only(left: 12.w, bottom: 15.h, top: 15.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: const Color(0XFFF3F3F4)),
        child: InkWell(
          onTap: (isFromCart ?? false)
              ? () async {
                  await sharedPreferencesHelper
                      .setDefaultAddress(addressList[index]);
                  CommonFunctions.afterInit(() => Navigator.pop(context));
                }
              : null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    addressList[index].houseNumber ?? '',
                    style: FontPalette.poppinsRegular.copyWith(
                        color: HexColor('#404041'),
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  if (addressList[index].isDefault == 1)
                    Text(
                      'Default Address',
                      style: FontPalette.poppinsBold
                          .copyWith(color: ColorPalette.primaryColor),
                    ),
                  20.horizontalSpace
                ],
              ),
              2.verticalSpace,
              Text(
                addressList[index].address ?? '',
                style: FontPalette.poppinsRegular.copyWith(
                    color: HexColor('#404041'),
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500),
              ),
              2.verticalSpace,
              Row(
                children: [
                  // SizedBox(
                  //   width: 145.w,
                  //   child: Text(
                  //     addressList[index].country ?? '',
                  //     style: FontPalette.poppinsRegular.copyWith(
                  //         color: HexColor('#404041'),
                  //         fontSize: 15.sp,
                  //         fontWeight: FontWeight.w500),
                  //     maxLines: 10,
                  //     overflow: TextOverflow.ellipsis,
                  //   ),
                  // ),
                  const Spacer(),
                  if (addressList[index].isDefault != 1 &&
                      (!(isFromCart ?? false)))
                    Row(
                      children: [
                        InkWell(
                          onTap: () => manageAddressProvider?.setDefaultAddress(
                              addressList[index].id ?? 0, onSuccess: () async {
                            await sharedPreferencesHelper
                                .setDefaultAddress(addressList[index]);
                            manageAddressProvider?.getAddress(
                                enableLoader: true);
                          }),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            color: ColorPalette.primaryColor,
                            height: 23.h,
                            width: 100.w,
                            alignment: Alignment.center,
                            child: Text(
                              'Set As Default',
                              style: FontPalette.poppinsRegular.copyWith(
                                  fontSize: 10.0, color: Colors.white),
                              softWrap: true,
                            ),
                          ),
                        ),
                        10.horizontalSpace,
                      ],
                    ),
                  if (!(isFromCart ?? false))
                    InkWell(
                      onTap: () => CommonFunctions.showDialogPopUp(
                        context,
                        CustomAlertDialog(
                          title: 'Remove Address',
                          message: 'Are you sure, you want to remove address?',
                          actionButtonText: 'Yes',
                          cancelButtonText: 'No',
                          isLoading: false,
                          onCancelButtonPressed: () => Navigator.pop(context),
                          onActionButtonPressed: () {
                            Navigator.pop(context);
                            manageAddressProvider
                                ?.removeAddress(addressList[index].id ?? 0);
                          },
                        ),
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        color: const Color(0XFFC11E00),
                        height: 23.h,
                        alignment: Alignment.center,
                        child: Text(
                          'Remove',
                          style: FontPalette.poppinsRegular
                              .copyWith(fontSize: 10.0, color: Colors.white),
                        ),
                      ),
                    ).removeSplash(),
                ],
              ),
            ],
          ),
        ).removeSplash(),
      ),
      separatorBuilder: (context, index) => 50.verticalSpace,
    );
  }
}
