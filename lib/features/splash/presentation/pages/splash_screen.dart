import 'package:exchange/config/routes/app_routes.dart';
import 'package:exchange/core/utils/app_colors.dart';
import 'package:exchange/core/utils/assets_manger.dart';
import 'package:exchange/core/utils/screen_util_new.dart';
import 'package:flutter/material.dart';

import '../../../../core/sevices/shared_pref_controller.dart';
import '../../domain/use_cases/mantinance_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   Future.delayed(const Duration(seconds:3),(){
  //     Navigator.pushNamed(context, Routes.loginScreen);
  //
  //   });
  //   super.initState();
  // }
  @override
  void initState() {
    super.initState();
    _checkMaintenanceStatus();
  }

  Future<void> _checkMaintenanceStatus() async {
    bool isUnderMaintenance =
        await MaintenanceService().isWebsiteUnderMaintenance();
    Future.delayed(const Duration(seconds: 3), () {
      String route;
      if (isUnderMaintenance) {
        route = Routes.maintenanceScreen;
      } else {
        route = Routes.loginScreen;
      }
      Navigator.pushReplacementNamed(context, route);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          GestureDetector(
              onTap: () {
                // Navigator.pushNamed(context, Routes.loginScreen);
              },
              child: Center(
                  child: Image.asset(
                AssetsManger.logoApp,
                height: ScreenUtilNew.height(132),
                width: ScreenUtilNew.width(216),
              ))),
          Padding(
            padding: EdgeInsets.only(top: ScreenUtilNew.height(500)),
            child: const Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
                backgroundColor: AppColors.secondaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
