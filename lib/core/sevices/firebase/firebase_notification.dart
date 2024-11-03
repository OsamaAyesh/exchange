// import 'package:exchange/core/sevices/shared_pref_controller.dart';
// import 'package:exchange/core/utils/app_colors.dart';
// import 'package:exchange/core/utils/screen_util_new.dart';
// import 'package:exchange/exchange_app.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../../../config/routes/app_routes.dart';
// import 'package:flutter/material.dart';
//
// class FirebaseNotifications {
//   // Create an instance of Firebase Messaging
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//
//   // Track the current route
//   String? currentRoute;
//
//   // Initialize notifications for this app or device
//   Future<void> initNotifications() async {
//     // Request notification permissions
//     await _firebaseMessaging.requestPermission();
//
//     // Get and print the FCM token
//     String? token = await _firebaseMessaging.getToken();
//     print("Token: $token");
//     SharedPrefController().setValue(PrefKeys.fcmToken.name, token);
//
//     // Setup background and on-launch notification handling
//     handleBackgroundNotification();
//
//     // Setup foreground notification handling
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       // Display a snackbar notification if the app is in the foreground
//       if (navigatorKey.currentState != null) {
//
//         ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
//           SnackBar(
//             behavior: SnackBarBehavior.floating,
//             backgroundColor: AppColors.primaryColor,
//             padding: EdgeInsets.symmetric(horizontal: ScreenUtilNew.width(16)),
//             content: Text(message.notification?.title ?? "New Notification",style: GoogleFonts.cairo(
//             fontSize: 16.sp,
//             fontWeight: FontWeight.w400,color: Colors.white
//             ),
//             textDirection: TextDirection.rtl,
//             textAlign: TextAlign.center,),
//             duration: const Duration(seconds: 4),
//           ),
//         );
//       }
//     });
//   }
//
//   // Handle Notifications When App is in Background or Terminated
//   Future<void> handleBackgroundNotification() async {
//     // Handle when the app is launched by a notification
//     FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
//       if (message != null) {
//         navigatorKey.currentState!
//             .pushNamed(Routes.notificationScreen, arguments: message);
//         currentRoute = Routes.notificationScreen; // Update the current route
//       }
//     });
//
//     // Handle when a user taps on a notification to reopen the app
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       navigatorKey.currentState!
//           .pushNamed(Routes.notificationScreen, arguments: message);
//       currentRoute = Routes.notificationScreen; // Update the current route
//     });
//   }
// }
import 'package:exchange/core/sevices/shared_pref_controller.dart';
import 'package:exchange/core/utils/app_colors.dart';
import 'package:exchange/exchange_app.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';

import '../../../config/routes/app_routes.dart';

class FirebaseNotifications {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> initNotifications() async {
    // Request notification permissions
    await _firebaseMessaging.requestPermission();

    // Get the FCM token and save it
    String? token = await _firebaseMessaging.getToken();
    SharedPrefController().setValue(PrefKeys.fcmToken.name, token);

    // Initialize the flutter local notifications plugin
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // Setup background and on-launch notification handling
    handleBackgroundNotification();

    // Setup foreground notification handling
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // Show a local notification if the app is in the foreground
      _showLocalNotification(message);
    });
  }

  // Display a local notification
  Future<void> _showLocalNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
      'your_channel_id', // ID القناة
      'Notifications', // اسم القناة
      channelDescription: 'This channel is for app notifications',
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin.show(
      message.notification.hashCode,
      message.notification?.title ?? 'New Notification',
      message.notification?.body ?? '',
      notificationDetails,
    );
  }

  Future<void> handleBackgroundNotification() async {
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        navigatorKey.currentState!.pushNamed(Routes.notificationScreen, arguments: message);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      navigatorKey.currentState!.pushNamed(Routes.notificationScreen, arguments: message);
    });
  }
}
