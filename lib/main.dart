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
import 'features/home/attendance/presentation/manager/data_extra_model_provider.dart';
import 'features/home/bankTransfers/presentation/manager/filterd_or_not.dart';
import 'features/home/bankTransfers/presentation/manager/image_path_provider_controller.dart';
import 'features/home/bankTransfers/presentation/manager/is_load_more_in_all_transactions.dart';
import 'features/home/bankTransfers/presentation/manager/is_loading_add_transaction_provider.dart';
import 'features/home/bankTransfers/presentation/manager/is_loading_data_not_load_more.dart';
import 'features/home/dailyBoxes/data/models/data_type_process.dart';
import 'features/home/dailyBoxes/presentation/manager/providers/commision_controller_in_update_screen_provider.dart';
import 'features/home/dailyBoxes/presentation/manager/providers/controller_selected_sourse.dart';
import 'features/home/dailyBoxes/presentation/manager/providers/enabled_text_fileds_or_not_provider.dart';
import 'features/home/dailyBoxes/presentation/manager/providers/fill_color_commision_controller_provider.dart';
import 'features/home/dailyBoxes/presentation/manager/providers/is_loading_in_update_screen.dart';
import 'features/home/dailyBoxes/presentation/manager/providers/name_service_controller.dart';
import 'features/home/dailyBoxes/presentation/manager/providers/selectdata_list_process_provider.dart';
import 'features/home/dailyBoxes/presentation/manager/providers/types_operation.dart';
import 'features/home/salary/presentation/manager/summary_balance.dart';


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
        ChangeNotifierProvider(create: (_)=>NameServiceController()),
        ChangeNotifierProvider(create: (_)=>TypesOperationProvider()),
        ChangeNotifierProvider(create: (_) => CommissionControllerInUpdateScreenProvider()),
        ChangeNotifierProvider(create: (_)=>IsLoadingInUpdateScreen()),
        ChangeNotifierProvider(create: (_)=>DataExtraModelProvider()),
        ChangeNotifierProvider(create: (_)=>SummaryBalance()),
        ChangeNotifierProvider(create: (_)=>FillColorCommissionControllerProvider()),
        ChangeNotifierProvider(create: (_)=>EnabledTextFiledsOrNotProvider()),
        ChangeNotifierProvider(create: (_)=>SelectdataListProcessProvider(DataTypeProcess(id: '1', name: 'Initial Process'))),
        ChangeNotifierProvider(create: (_)=>FilterdOrNot()),
        ChangeNotifierProvider(create: (_)=>IsLoadMoreInAllTransactions()),
        ChangeNotifierProvider(create: (_)=>IsLoadingDataNotLoadMore())
      ],
      child: ExchangeApp(),
    ),
    // DevicePreview(
    //   enabled: !kReleaseMode,
    //   builder: (context) =>
    // ),
  );
}
