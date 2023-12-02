import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/common/extensions.dart';
import 'package:laundry/utils/color_palette.dart';
import 'package:laundry/utils/font_palette.dart';

import 'custom_button.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog(
      {super.key,
      this.width,
      this.height,
      this.title,
      this.message,
      this.actionButtonText,
      this.cancelButtonText,
      this.insetPadding,
      this.disableCancelBtn = false,
      this.enableCloseBtn = true,
      this.onActionButtonPressed,
      this.onCancelButtonPressed,
      this.cancelIsLoading = false,
      this.isLoading});

  final double? width;
  final double? height;
  final EdgeInsets? insetPadding;
  final String? title;
  final String? message;
  final String? actionButtonText;
  final String? cancelButtonText;
  final bool disableCancelBtn;
  final bool enableCloseBtn;
  final Function()? onActionButtonPressed;
  final VoidCallback? onCancelButtonPressed;
  final bool? isLoading;
  final bool cancelIsLoading;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: insetPadding ?? EdgeInsets.symmetric(horizontal: 40.w),
      titlePadding: EdgeInsets.zero,
      iconPadding: EdgeInsets.zero,
      buttonPadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.white,
      shape:  RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r)),
      elevation: 0,
      content: SizedBox(
        width: width ?? context.sw(),
        height: height ?? 300.h,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                40.57.verticalSpace,
                Text(
                  title ?? '',
                  style: FontPalette.poppinsBold
                      .copyWith(color: Colors.black, fontSize: 18.sp),
                ),
                10.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 19.w),
                  child: Text(
                    message ?? '',
                    textAlign: TextAlign.center,
                    style: FontPalette.poppinsRegular
                        .copyWith(color: Colors.black, fontSize: 18.sp),
                  ),
                ),
                30.43.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 49.w),
                  child: CustomButton(
                    height: 40.h,
                    isLoading: isLoading ?? false,
                    onTap: onActionButtonPressed,
                    title: actionButtonText,
                  ),
                ),
                10.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 49.w),
                  child: CustomButton(
                    height: 40.h,
                    isLoading: isLoading ?? false,
                    color: HexColor('#F11A1A'),
                    onTap: onCancelButtonPressed,
                    title: cancelButtonText,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
