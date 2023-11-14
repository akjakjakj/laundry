import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/utils/color_palette.dart';
import 'package:laundry/utils/font_palette.dart';

class PastOrdersTile extends StatelessWidget {
  const PastOrdersTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 10,
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
                  'Order ID : #PQIWY1TMVL',
                  style: FontPalette.poppinsRegular
                      .copyWith(fontSize: 11.sp, color: HexColor('#000000')),
                ),
                const Spacer(),
                Text(
                  '15-08-2023',
                  style: FontPalette.poppinsRegular.copyWith(
                      fontSize: 11.sp, color: ColorPalette.greenColor),
                )
              ],
            ),
            30.verticalSpace,
            Row(
              children: [
                Text(
                  'T-SHIRT,LONG SHIRTS',
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
                  '1',
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
