import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/common/extensions.dart';
import 'package:laundry/common_widgets/common_functions.dart';
import 'package:laundry/common_widgets/custom_alert_dialogue.dart';
import 'package:laundry/utils/color_palette.dart';
import 'package:laundry/utils/font_palette.dart';
import 'package:laundry/views/manage_address/model/manage_address_response_model.dart';
import 'package:laundry/views/manage_address/view_model/manage_address_view_model.dart';

class AddressTile extends StatelessWidget {
  const AddressTile(
      {Key? key, required this.addressList, this.manageAddressProvider})
      : super(key: key);
  final List<Addresses> addressList;
  final ManageAddressProvider? manageAddressProvider;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: addressList.length,
      itemBuilder: (context, index) => Container(
        padding: EdgeInsets.only(left: 12.w, bottom: 15.h, top: 15.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: const Color(0XFFF3F3F4)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              addressList[index].name ?? '',
              style: FontPalette.poppinsRegular
                  .copyWith(color: HexColor('#404041'), fontSize: 15.sp),
            ),
            2.verticalSpace,
            Text(
              addressList[index].address ?? '',
              style: FontPalette.poppinsRegular
                  .copyWith(color: HexColor('#404041'), fontSize: 15.sp),
            ),
            2.verticalSpace,
            Row(
              children: [
                Text(
                  addressList[index].city ?? '',
                  style: FontPalette.poppinsRegular
                      .copyWith(color: HexColor('#404041'), fontSize: 15.sp),
                ),
                const Spacer(),
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
                          .copyWith(fontSize: 12.sp, color: Colors.white),
                    ),
                  ),
                ).removeSplash()
              ],
            ),
          ],
        ),
      ),
      separatorBuilder: (context, index) => 50.verticalSpace,
    );
  }
}
