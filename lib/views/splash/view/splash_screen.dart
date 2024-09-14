import 'dart:async';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:laundry/gen/assets.gen.dart';
import 'package:laundry/services/get_it.dart';
import 'package:laundry/services/route_generator.dart';
import 'package:laundry/services/shared_preference_helper.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SharedPreferencesHelper sharedPreferencesHelper =
      sl.get<SharedPreferencesHelper>();
  late VideoPlayerController _controller;
  FirebaseRemoteConfig? _remoteConfig;
  String _fetchedValue = "Loading...";
  // Fetch Remote Config values
  Future<void> _fetchRemoteConfig() async {
    _remoteConfig = FirebaseRemoteConfig.instance;

    // Set configuration settings for dev (optional: change for production)
    await _remoteConfig?.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10), // Timeout
      minimumFetchInterval:
          const Duration(seconds: 0), // For testing, fetch every time
    ));

    try {
      // Fetch and activate the Remote Config values from the Firebase Console
      await _remoteConfig?.fetchAndActivate();

      // Retrieve the value of 'welcome_message' from the console
      String fetchedMessage =
          _remoteConfig?.getString('is_notification_enabled') ??
              "No value found";

      // Update the state with the fetched message
      setState(() {
        _fetchedValue = fetchedMessage;
      });
      print(_fetchedValue);
    } catch (e) {
      setState(() {
        _fetchedValue = "Error fetching remote config";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchRemoteConfig();
    Future.delayed(
      const Duration(seconds: 4),
      () {
        if (_fetchedValue.toString() == 'true') {
          Navigator.pushNamedAndRemoveUntil(
              context, RouteGenerator.routeBlackScreen, (route) => false);
          return;
        }
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
    return Scaffold(body: Assets.images.splashScreen.image());
  }
}

class BlackScreen extends StatelessWidget {
  const BlackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
    );
  }
}
