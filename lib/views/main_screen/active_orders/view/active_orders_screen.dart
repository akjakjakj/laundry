import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/common/extensions.dart';
import 'package:laundry/gen/assets.gen.dart';
import 'package:laundry/utils/font_palette.dart';

class ActiveOrdersScreen extends StatefulWidget {
  const ActiveOrdersScreen({super.key});

  @override
  State<ActiveOrdersScreen> createState() => _ActiveOrdersScreenState();
}

class _ActiveOrdersScreenState extends State<ActiveOrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Column(
          children: [
            SizedBox(
              height: 50.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 15.w),
                    child: Assets.images.logo.image(
                      height: 50.h,
                    ),
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.pushNamed(context, RouteGenerator.routeCart);
                  //   },
                  //   child: Padding(
                  //       padding: EdgeInsets.only(right: 15.w),
                  //       child:
                  //           Assets.icons.cart.image(height: 30, width: 30)),
                  // ),
                ],
              ),
            ),
            Expanded(
                child: SizedBox(
              height: context.sh(),
              child: Center(
                child: Text(
                  'No active orders found',
                  style: FontPalette.poppinsBold,
                ),
              ),
            ))
          ],
        ),
      )),
    );
  }
}
