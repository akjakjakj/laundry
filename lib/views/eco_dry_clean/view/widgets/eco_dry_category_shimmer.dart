import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/common/extensions.dart';

class EcoDryCategoryShimmer extends StatelessWidget {
  const EcoDryCategoryShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 10,
      padding: EdgeInsets.symmetric(horizontal: 37.w, vertical: 15.h),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: context.sw(size: .300.w),
          crossAxisSpacing: 16.w,
          mainAxisSpacing: 15.h),
      itemBuilder: (context, index) {
        return Container(
            decoration: BoxDecoration(
                color: Colors.white,
                // color: ColorPalette.hintColor,
                borderRadius: BorderRadius.circular(15.r)));
      },
    ).addShimmer();
  }
}
