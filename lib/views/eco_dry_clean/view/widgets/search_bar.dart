import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/utils/color_palette.dart';
import 'package:laundry/utils/font_palette.dart';

class EcoDrySearchBar extends StatelessWidget {
  const EcoDrySearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42.h,
      padding: EdgeInsets.only(left: 20.w, right: 20.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: HexColor('#F3F3F4')),
      child: Row(
        children: [
          const Icon(Icons.search),
          24.horizontalSpace,
          Container(
            width: 250.w,
            padding: EdgeInsets.only(bottom: 2.h),
            child: TextFormField(
              decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Search',
                  labelStyle: FontPalette.poppinsRegular
                      .copyWith(fontSize: 14.sp, color: HexColor('#404041')),
                  floatingLabelBehavior: FloatingLabelBehavior.never),
            ),
          ),
        ],
      ),
    );
  }
}
