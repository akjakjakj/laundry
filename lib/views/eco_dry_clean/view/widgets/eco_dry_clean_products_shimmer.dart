import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/common/extensions.dart';
import 'package:laundry/utils/color_palette.dart';

class EcoDryCLeanProductsShimmer extends StatelessWidget {
  const EcoDryCLeanProductsShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // 40.verticalSpace,
            // Container(
            //   height: 42.h,
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(20.r),
            //       color: Colors.white),
            // ),
            20.verticalSpace,
            GridView.builder(
              itemCount: 4,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 23.h,
                  mainAxisExtent: 260.h,
                  crossAxisSpacing: 12.w),
              itemBuilder: (context, index) => Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: HexColor('#F3F3F4')),
                    color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    ).addShimmer();
  }
}
