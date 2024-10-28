import 'package:device_preview/device_preview.dart';
import 'package:exchange/core/sevices/firebase/firebase_notification.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl.dart'; // تأكد من استيراد المكتبة
// import 'core/sevices/firebase/firebase_message.dart';
import 'core/sevices/shared_pref_controller.dart';
import 'exchange_app.dart';
import 'features/home/bankTransfers/presentation/manager/image_path_provider_controller.dart';
import 'features/home/bankTransfers/presentation/manager/is_loading_add_transaction_provider.dart';
import 'features/home/dailyBoxes/presentation/manager/providers/controller_selected_sourse.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // معالجة الرسائل عند ورودها في الخلفية
  print("Handling a background message: ${message.messageId}");
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefController().initPreferences();
  await Firebase.initializeApp();
  await FirebaseNotifications().initNotifications();
  // await initializeDateFormatting('en', 'EN'); // 'AR' is an example for Arabic in Algeria
  // final firebaseApi = FirebaseApi();
  // await firebaseApi.initNotifications();
  // await FirebaseApi().initNotifications();
  // await initializeDateFormatting('ar', "ar.json"); // Initialize for Arabic

  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // قفل التوجيه على الوضع العمودي
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  FastCachedImageConfig.init(
    clearCacheAfter: const Duration(days: 2), // مدة التخزين المؤقت
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ControllerSelectedSource()),
        ChangeNotifierProvider(
          create: (context) => IsLoadingAddTransactionProvider(),
        ),
        ChangeNotifierProvider(create: (_) => ImagePathProviderController()),

      ],
      child: ExchangeApp(),
    ),
    // DevicePreview(
    //   enabled: !kReleaseMode,
    //   builder: (context) =>
    // ),
  );
}
