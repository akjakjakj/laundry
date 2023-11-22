import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/common/extensions.dart';
import 'package:laundry/gen/assets.gen.dart';
import 'package:laundry/services/route_generator.dart';
import 'package:laundry/utils/color_palette.dart';
import 'package:laundry/utils/font_palette.dart';

class EcoDryCleanScreen extends StatefulWidget {
  const EcoDryCleanScreen({Key? key}) : super(key: key);

  @override
  _EcoDryCleanScreenState createState() => _EcoDryCleanScreenState();
}

class _EcoDryCleanScreenState extends State<EcoDryCleanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        itemCount: 3,
        padding: EdgeInsets.symmetric(horizontal: 37.w, vertical: 60.h),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: context.sw(size: .413.w),
            crossAxisSpacing: 16.w,
            mainAxisSpacing: 33.h),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () => Navigator.pushNamed(
                context, RouteGenerator.routeEcoDryCleanSelectionScreen),
            child: Container(
              width: context.sw(size: .413.w),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: ColorPalette.hintColor,
                  borderRadius: BorderRadius.circular(15.r)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Assets.images.shoe.image(height: 55.h, width: 55.w),
                  Text(
                    'Shoes',
                    style: FontPalette.poppinsBold.copyWith(
                        fontSize: 17.sp, color: ColorPalette.greenColor),
                  )
                ],
              ),
            ),
          ).removeSplash();
        },
      ),
    );
  }
}
