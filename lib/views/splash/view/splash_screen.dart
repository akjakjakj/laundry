import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/gen/assets.gen.dart';
import 'package:laundry/services/route_generator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 2),
      () => Navigator.pushNamedAndRemoveUntil(
          context, RouteGenerator.routeLogin, (route) => false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        child: Stack(alignment: Alignment.center, children: [
          Assets.images.bgImage.image(),
          Align(alignment: Alignment.center, child: Assets.images.logo.image()),
          Positioned(
              bottom: 100.h,
              child: Assets.images.electrolux.image(height: 60.h)),
        ]),
      ),
    );
  }
}
