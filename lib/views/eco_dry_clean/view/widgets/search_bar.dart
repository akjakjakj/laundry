import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/common/extensions.dart';
import 'package:laundry/utils/color_palette.dart';
import 'package:laundry/utils/font_palette.dart';

class EcoDrySearchBar extends StatelessWidget {
  const EcoDrySearchBar(
      {super.key,
      this.textEditingController,
      this.onEditComplete,
      this.onChanged});
  final TextEditingController? textEditingController;
  final Function(String)? onChanged;
  final Function()? onEditComplete;

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
          const Icon(Icons.search).translateWidgetVertically(value: 1.h),
          24.horizontalSpace,
          Container(
            width: 250.w,
            padding: EdgeInsets.only(bottom: 0.h),
            child: TextFormField(
              controller: textEditingController,
              onChanged: onChanged,
              onEditingComplete: onEditComplete,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Search',
                  labelStyle: FontPalette.poppinsRegular
                      .copyWith(fontSize: 14.sp, color: HexColor('#404041')),
                  floatingLabelBehavior: FloatingLabelBehavior.never),
            ).translateWidgetVertically(
                value:
                    textEditingController!.text.trim().isNotEmpty ? -3.5.h : 1),
          ),
        ],
      ),
    );
  }
}
