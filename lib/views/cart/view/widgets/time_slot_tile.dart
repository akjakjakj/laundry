import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/common/extensions.dart';
import 'package:laundry/utils/color_palette.dart';
import 'package:laundry/utils/font_palette.dart';

class TimeSlotTile extends StatelessWidget {
  const TimeSlotTile(
      {super.key,
      this.title,
      required this.isSelectedIndex,
      this.onTap,
      this.isAvailable});
  final String? title;
  final bool isSelectedIndex;
  final Function()? onTap;
  final bool? isAvailable;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: isSelectedIndex
                ? ColorPalette.primaryColor
                : const Color(0xfff3f3f4),
            borderRadius: BorderRadius.circular(10.r)),
        width: 300,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.timer,
              color: (isAvailable ?? true)
                  ? isSelectedIndex
                      ? Colors.white
                      : ColorPalette.primaryColor
                  : ColorPalette.primaryColor.withOpacity(.5),
            ),
            5.horizontalSpace,
            Text(
              title ?? '',
              style: FontPalette.poppinsRegular.copyWith(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                  color: (isAvailable ?? true)
                      ? isSelectedIndex
                          ? Colors.white
                          : Colors.black
                      : Colors.black.withOpacity(.5)),
            )
          ],
        ),
      ),
    ).removeSplash();
  }
}
