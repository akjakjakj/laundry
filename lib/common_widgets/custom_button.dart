import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/common_widgets/three_bounce.dart';
import 'package:laundry/utils/color_palette.dart';
import 'package:laundry/utils/font_palette.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      this.color,
      this.title,
      this.width,
      this.height,
      this.decoration,
      this.onTap,
      this.textStyle,
      this.isLoading = false})
      : super(key: key);
  final String? title;
  final Color? color;
  final double? height;
  final double? width;
  final BoxDecoration? decoration;
  final VoidCallback? onTap;
  final TextStyle? textStyle;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? null : onTap,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: Container(
          height: height ?? 51.h,
          width: width ?? double.infinity,
          alignment: Alignment.center,
          decoration: decoration ??
              BoxDecoration(
                  color: color ?? ColorPalette.greenColor,
                  borderRadius: BorderRadius.circular(40.r)),
          child: isLoading
              ? ThreeBounce(
                  size: 25.r,
                )
              : Text(
                  title ?? '',
                  style: textStyle ??
                      FontPalette.poppinsBold
                          .copyWith(color: Colors.white, fontSize: 17.sp),
                ),
        ),
      ),
    );
  }
}
