import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/gen/assets.gen.dart';
import 'package:laundry/services/route_generator.dart';

import 'home_screen_service_container.dart';

class ChooseServiceWidget extends StatelessWidget {
  const ChooseServiceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        HomeScreenServiceContainer(
          image: Assets.icons.ironing.image(height: 23.h, width: 38.w),
          title: 'Steam Ironing',
        ),
        30.horizontalSpace,
        HomeScreenServiceContainer(
          image: Assets.icons.ecoDryClean.image(height: 34.h, width: 34.w),
          title: 'Eco-Dry Clean',
          onTap: () =>
              Navigator.pushNamed(context, RouteGenerator.routeEcoDryClean),
        ),
        30.horizontalSpace,
        HomeScreenServiceContainer(
          image: Assets.icons.offers.image(height: 32.h, width: 31.w),
          title: 'Offers',
        )
      ],
    );
  }
}
