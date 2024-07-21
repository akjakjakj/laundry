import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/common/extensions.dart';
import 'package:laundry/common_widgets/common_fade_in_image.dart';
import 'package:laundry/utils/font_palette.dart';

class HomeScreenServiceContainer extends StatelessWidget {
  const HomeScreenServiceContainer(
      {super.key, required this.image, this.title, this.onTap});
  final String image;
  final String? title;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
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
                  offset:
                      const Offset(0, 2), // changes the position of the shadow
                ),
              ],
            ),
            child: CommonFadeInImage(
              image: image,
              height: 25.h,
              // width: 38.w,
              fit: BoxFit.contain,
            ),
          ),
          10.verticalSpace,
          Text(
            title ?? '',
            style: FontPalette.poppinsRegular.copyWith(
                fontSize: 11.sp,
                color: Colors.black,
                fontWeight: FontWeight.w500),
          )
        ],
      ),
    ).removeSplash();
  }
}
