import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/utils/color_palette.dart';

import '../../../utils/font_palette.dart';

class ProfileTile extends StatelessWidget {
  final String? title;
  final Widget? childIcon;
  final VoidCallback? onTap;
  const ProfileTile({super.key, this.title, this.childIcon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: onTap,
        leading: Container(
          height: 40.r,
          width: 40.r,
          // padding: EdgeInsets.all(5.r),
          decoration: BoxDecoration(
            color: ColorPalette.primaryColor,
            shape: BoxShape.circle,
          ),
          child: childIcon,
        ),
        title: Text(
          title ?? "",
          style: FontPalette.poppinsRegular.copyWith(
              color: const Color(0XFF1A1A1A),
              fontSize: 14.sp,
              fontWeight: FontWeight.w500),
        ),
        trailing: const Icon(Icons.arrow_forward_ios));
  }
}
