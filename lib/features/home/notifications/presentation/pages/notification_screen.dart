import 'package:exchange/core/utils/app_colors.dart';
import 'package:exchange/core/utils/app_strings.dart';
import 'package:exchange/core/utils/assets_manger.dart';
import 'package:exchange/core/utils/screen_util_new.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/widget_notification.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          AppStrings.notificationScreen1,
          style: GoogleFonts.cairo(
            fontSize: 16.sp,
            color: AppColors.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_forward,
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // SizedBox(
          //   height: ScreenUtilNew.height(32),
          // ),
          // Center(
          //   child: Image.asset(
          //     AssetsManger.noNotificationImage,
          //     height: ScreenUtilNew.height(316),
          //     width: ScreenUtilNew.width(254),
          //   ),
          // ),
          // Text(
          //   AppStrings.notificationScreen2,
          //   style: GoogleFonts.cairo(
          //       color: const Color(0XFF858585),
          //       fontWeight: FontWeight.w400,
          //       fontSize: 24.sp),
          // ),
          Expanded(
            child: ListView.builder(
              itemCount: 8,
                itemBuilder: (context, index) {
              return const WidgetNotification();
            }),
          )
        ],
      ),
    );
  }
}
