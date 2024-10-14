import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/common/multi_provider_list.dart';
import 'package:laundry/services/get_it.dart';
import 'package:laundry/services/notification_services.dart';
import 'package:laundry/services/route_generator.dart';
import 'package:laundry/utils/color_palette.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

Future _firebaseBackgroundMessage(RemoteMessage remoteMessage) async {
  if (remoteMessage.notification != null) {
    print('backgroud notification');
  }
}

void main() async {
  setUpLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  PushNotificationService pushNotificationService =
      sl.get<PushNotificationService>();
  pushNotificationService.init();
  pushNotificationService.localNotificationInit();
  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);
  FirebaseMessaging.onMessage.listen((event) {
    String payLoad = jsonEncode(event.data);
    print('Got a message in foreground');
    PushNotificationService.showSimpleNotification(
        title: event.notification?.title ?? '',
        body: event.notification?.body ?? '',
        payload: payLoad);
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: MultiProviderList.providerList,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp(
          title: 'Le Degraissage',
          debugShowCheckedModeBanner: false,
          theme: ColorPalette.themeData,
          onGenerateRoute: RouteGenerator.instance.generateRoute,
        ),
      ),
    );
  }
}
