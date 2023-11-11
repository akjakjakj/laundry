import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/utils/font_palette.dart';

class HomeScreenServiceContainer extends StatelessWidget {
  const HomeScreenServiceContainer({Key? key, required this.image, this.title})
      : super(key: key);
  final Widget image;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Column(
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
          child: image,
        ),
        20.verticalSpace,
        Text(
          title ?? '',
          style: FontPalette.poppinsRegular
              .copyWith(fontSize: 11.sp, color: Colors.black),
        )
      ],
    );
  }
}
