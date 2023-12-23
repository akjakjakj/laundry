import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/common/extensions.dart';

class HomeScreenShimmer extends StatelessWidget {
  const HomeScreenShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: context.sw(size: 1.1.h),
          color: Colors.white,
        ),
        19.verticalSpace,
        Container(
          width: 150.w,
          height: 15.h,
          color: Colors.white,
        ),
        16.verticalSpace,
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              3,
              (index) => Column(
                children: [
                  Container(
                    height: 65.h,
                    width: 65.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1.r,
                          blurRadius: 15.r,
                          offset: const Offset(
                              0, 2), // changes the position of the shadow
                        ),
                      ],
                    ),
                  ),
                  20.verticalSpace,
                  Container(
                    height: 15.h,
                    width: 100.w,
                    margin: EdgeInsets.only(right: 10.w),
                    color: Colors.white,
                  ),
                ],
              ),
            ))
      ],
    ).addShimmer();
  }
}
