import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'config/routes/app_routes.dart';
import 'core/utils/screen_util_new.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class ExchangeApp extends StatelessWidget {
   ExchangeApp({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtilNew.init(context);
    return  ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_ , child) {
        return MaterialApp(
          navigatorKey: navigatorKey,
          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
          debugShowCheckedModeBanner: false,
          initialRoute: Routes.initialRoute,
          routes: routes,
        );
      },
    );
  }
}
