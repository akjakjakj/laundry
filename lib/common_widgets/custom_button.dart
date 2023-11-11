import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/utils/color_palette.dart';
import 'package:laundry/utils/font_palette.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      this.color,
      this.title,
      this.width,
      this.height,
      this.decoration})
      : super(key: key);
  final String? title;
  final Color? color;
  final double? height;
  final double? width;
  final BoxDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 61.h,
      width: width ?? double.infinity,
      alignment: Alignment.center,
      decoration: decoration ??
          BoxDecoration(
              color: color ?? ColorPalette.greenColor,
              borderRadius: BorderRadius.circular(40.r)),
      child: Text(
        title ?? '',
        style: FontPalette.poppinsBold
            .copyWith(color: Colors.white, fontSize: 17.sp),
      ),
    );
  }
}
