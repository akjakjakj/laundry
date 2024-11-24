import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:laundry/services/helpers.dart';
import 'package:laundry/services/route_generator.dart';
import 'package:laundry/services/shared_preference_helper.dart';
import 'package:laundry/views/main_screen/past_orders/model/notification_invoice_model.dart';
import 'package:laundry/views/main_screen/past_orders/model/order_details_arguments.dart';
import 'package:laundry/views/main_screen/past_orders/model/past_orders_response_model.dart';

import 'get_it.dart';

class PushNotificationService {
  SharedPreferencesHelper sharedPreferencesHelper =
      sl.get<SharedPreferencesHelper>();
  static final _firebaseMessaging = FirebaseMessaging.instance;
  static final _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future init() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    final token = await _firebaseMessaging.getToken();
    FirebaseMessaging.instance.getInitialMessage();
    sharedPreferencesHelper.saveDeviceToken(token ?? '');
  }

  Future localNotificationInit() async {
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      onDidReceiveLocalNotification: (id, title, body, payload) {},
    );
    const LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(defaultActionName: 'Open notification');
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsDarwin,
            linux: initializationSettingsLinux);
    _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onNotificationTap,
        onDidReceiveBackgroundNotificationResponse: onNotificationTap);
  }

  static void onNotificationTap(NotificationResponse notificationResponse) {
    NavigationService navigationService = sl.get<NavigationService>();
    if ((notificationResponse.payload ?? '').isNotEmpty) {
      final decodedData = json.decode(notificationResponse.payload!);
      final notificationInvoiceModel =
          NotificationInvoiceModel.fromJson(decodedData);
      switch (notificationInvoiceModel.type) {
        case 'invoice':
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            navigationService.navigateTo(RouteGenerator.routeInvoiceView,
                arguments: InvoiceArguments(
                    orders: Orders(
                        id: int.parse(notificationInvoiceModel.orderId),
                        address: notificationInvoiceModel.customerBuilding,
                        phoneNumber: notificationInvoiceModel.customerMobile,
                        customer: notificationInvoiceModel.customerName,
                        invoice: Invoice(
                            netAmount: notificationInvoiceModel.netAmount),
                        email: notificationInvoiceModel.customerEmail),
                    url:
                        'https://ledegraissage-online-v2.azureposae.com/view/invoice-v3/html?order_id=${notificationInvoiceModel.id}'));
          });

        default:
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            navigationService.navigateTo(RouteGenerator.routeInvoiceView,
                arguments: InvoiceArguments(
                    orders: Orders(
                        id: int.parse(notificationInvoiceModel.orderId),
                        address: notificationInvoiceModel.customerBuilding,
                        phoneNumber: notificationInvoiceModel.customerMobile,
                        customer: notificationInvoiceModel.customerName,
                        invoice: Invoice(
                            netAmount: notificationInvoiceModel.netAmount),
                        email: notificationInvoiceModel.customerEmail),
                    url:
                        'https://ledegraissage-online-v2.azureposae.com/view/invoice-v3/html?order_id=${notificationInvoiceModel.id}'));
          });
      }
    }
  }

  static Future showSimpleNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            '1:290126836503:android:a80aac01f8841ce638bd52', 'Test channel',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await _flutterLocalNotificationsPlugin
        .show(0, title, body, notificationDetails, payload: payload);
  }
}
