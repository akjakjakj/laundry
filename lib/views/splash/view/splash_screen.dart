import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/gen/assets.gen.dart';
import 'package:laundry/services/get_it.dart';
import 'package:laundry/services/route_generator.dart';
import 'package:laundry/services/shared_preference_helper.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SharedPreferencesHelper sharedPreferencesHelper =
      sl.get<SharedPreferencesHelper>();
  late VideoPlayerController _controller;
  @override
  void initState() {
    super.initState();
    // _controller = VideoPlayerController.asset(Assets.images.splashScreen.)
    //   ..initialize().then((_) {
    //     // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
    //     setState(() {});
    //   });
    Future.delayed(
      const Duration(seconds: 4),
      () {
        getLoginStatus().then((value) {
          if (value) {
            Navigator.pushNamedAndRemoveUntil(
                context, RouteGenerator.routeMainScreen, (route) => false);
          } else {
            Navigator.pushNamedAndRemoveUntil(
                context, RouteGenerator.routeLogin, (route) => false);
          }
        });
      },
    );
  }

  Future<bool> getLoginStatus() async {
    return await sharedPreferencesHelper.getLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Assets.images.splashScreen.image()
        // SizedBox(
        //   height: double.infinity,
        //   child: Stack(alignment: Alignment.center, children: [
        //     Assets.images.bgImage.image(),
        //     Align(alignment: Alignment.center, child: Assets.images.logo.image()),
        //     Positioned(
        //         bottom: 100.h,
        //         child: Assets.images.electrolux.image(height: 60.h)),
        //   ]),
        // ),
        );
  }
}
