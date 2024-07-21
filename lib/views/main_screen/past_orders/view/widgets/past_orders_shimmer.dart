import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/common/extensions.dart';
import 'package:laundry/utils/color_palette.dart';

class PastOrdersShimmer extends StatelessWidget {
  const PastOrdersShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListView.separated(
        itemCount: 10,
        shrinkWrap: true,
        padding: EdgeInsets.only(top: 30.h),
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => Container(
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 25.w),
          height: 120.h,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.r),
              border: Border.all(color: ColorPalette.hintColor, width: 1.5.h)),
        ),
        separatorBuilder: (context, index) => 30.verticalSpace,
      ),
    ).addShimmer();
  }
}
