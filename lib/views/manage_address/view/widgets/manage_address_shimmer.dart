import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/common/extensions.dart';

class ManageAddressShimmer extends StatelessWidget {
  const ManageAddressShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListView.separated(
        itemCount: 10,
        shrinkWrap: true,
        itemBuilder: (context, index) => Container(
          padding: EdgeInsets.only(left: 12.w, bottom: 15.h, top: 15.h),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r), color: Colors.white),
          height: 100.h,
        ),
        separatorBuilder: (context, index) => 50.verticalSpace,
      ),
    ).addShimmer();
  }
}
