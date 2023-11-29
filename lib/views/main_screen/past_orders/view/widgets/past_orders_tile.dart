import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/utils/color_palette.dart';
import 'package:laundry/utils/font_palette.dart';
import 'package:laundry/views/main_screen/past_orders/model/past_orders_response_model.dart';

class PastOrdersTile extends StatelessWidget {
  const PastOrdersTile({Key? key, required this.ordersList}) : super(key: key);
  final List<Orders> ordersList;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: ordersList.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => Container(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 25.w),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.r),
            border: Border.all(color: ColorPalette.hintColor, width: 1.5.h)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Order ID : #${ordersList[index].id}',
                  style: FontPalette.poppinsRegular
                      .copyWith(fontSize: 11.sp, color: HexColor('#000000')),
                ),
                const Spacer(),
                Text(
                  ordersList[index].date ?? '',
                  style: FontPalette.poppinsRegular.copyWith(
                      fontSize: 11.sp, color: ColorPalette.greenColor),
                )
              ],
            ),
            30.verticalSpace,
            Row(
              children: [
                Text(
                  ordersList[index].product ?? '',
                  style: FontPalette.poppinsRegular
                      .copyWith(fontSize: 11.sp, color: HexColor('#000000')),
                ),
                const Spacer(),
                Text(
                  'Items',
                  style: FontPalette.poppinsRegular
                      .copyWith(fontSize: 11.sp, color: HexColor('#000000')),
                ),
              ],
            ),
            10.verticalSpace,
            Row(
              children: [
                Text(
                  'Service for men',
                  style: FontPalette.poppinsRegular
                      .copyWith(fontSize: 8.sp, color: HexColor('#000000')),
                ),
                const Spacer(),
                Text(
                  ordersList[index].quantity.toString(),
                  style: FontPalette.poppinsRegular
                      .copyWith(fontSize: 11.sp, color: HexColor('#000000')),
                ),
              ],
            ),
          ],
        ),
      ),
      separatorBuilder: (context, index) => 30.verticalSpace,
    );
  }
}
