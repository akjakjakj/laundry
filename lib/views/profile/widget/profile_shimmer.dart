import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/common/extensions.dart';
import 'package:laundry/utils/color_palette.dart';
import 'package:laundry/utils/font_palette.dart';

class ProfileShimmer extends StatelessWidget {
  const ProfileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Stack(
        //   alignment: Alignment.bottomRight,
        //   children: [
        //     CircleAvatar(
        //       radius: 80,
        //       backgroundColor: const Color.fromARGB(255, 221, 221, 221),
        //       child: Text(
        //         "A",
        //         style: FontPalette.poppinsRegular.copyWith(
        //             color: ColorPalette.primaryColor, fontSize: 50.sp),
        //       ),
        //     ),
        //     Container(
        //       height: 30.r,
        //       width: 30.r,
        //       margin: EdgeInsets.all(10.r),
        //       decoration: BoxDecoration(
        //         color: ColorPalette.primaryColor,
        //         shape: BoxShape.circle,
        //       ),
        //       child: Icon(
        //         size: 18.r,
        //         Icons.edit,
        //         color: Colors.white,
        //       ),
        //     ),
        //   ],
        // ),
        5.verticalSpace,
        Text(
          "",
          style: FontPalette.poppinsRegular
              .copyWith(color: const Color(0XFF707071), fontSize: 14.sp),
        ),
        Text(
          "",
          style: FontPalette.poppinsRegular
              .copyWith(color: const Color(0XFF707071), fontSize: 14.sp),
        ),
      ],
    ).addShimmer();
  }
}
