import 'package:exchange/config/routes/app_routes.dart';
import 'package:exchange/core/sevices/shared_pref_controller.dart';
import 'package:exchange/core/utils/app_colors.dart';
import 'package:exchange/core/utils/app_strings.dart';
import 'package:exchange/core/utils/assets_manger.dart';
import 'package:exchange/core/utils/context_extension.dart';
import 'package:exchange/core/utils/screen_util_new.dart';
import 'package:exchange/features/home/attendance/presentation/pages/attendance_screen.dart';
import 'package:exchange/features/home/bankTransfers/presentation/pages/add_transaction_new_screen.dart';
import 'package:exchange/features/home/bankTransfers/presentation/pages/all_transactions_screen.dart';
import 'package:exchange/features/home/dailyBoxes/presentation/pages/boxes_daily.dart';
import 'package:exchange/features/home/notifications/presentation/pages/notification_screen.dart';
import 'package:exchange/features/home/profile/presentation/pages/profile_screen.dart';
import 'package:exchange/features/home/salary/presentation/pages/salary_screen.dart';
import 'package:exchange/features/home/summaryProcess/presentation/pages/summary_process.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:page_animation_transition/animations/bottom_to_top_transition.dart';
import 'package:page_animation_transition/animations/left_to_right_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';
import 'package:exchange/features/home/salary/presentation/pages/salary_screen.dart' show SingleChildScrollView;

import 'access_speed_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // DateTime now = DateTime.now();
    //
    // String formattedDate = DateFormat.yMMMMEEEEd('ar').format(now);
    //
    // String period = DateFormat('a', 'ar').format(now); // 'a' تعطينا AM أو PM
    //
    // String greeting = (period == 'ص') ? 'صباح الخير' : 'مساء الخير';
    // الحصول على التاريخ والوقت الحالي
    DateTime now = DateTime.now();
    //
    // // تنسيق التاريخ باللغة العربية
    // String formattedDate = DateFormat.yMMMMEEEEd('ar').format(now);

    // تحديد التحية بناءً على الساعة
    String greeting = (now.hour < 12) ? 'صباح الخير' : 'مساء الخير';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).push(PageAnimationTransition(page: const NotificationScreen(), pageAnimationType: BottomToTopTransition()));
            },
            icon: const Icon(
              Icons.notifications,
              color: Colors.black,
            )),
        automaticallyImplyLeading: false,
        title: Text(
          AppStrings.homeScreen1,
          style: GoogleFonts.cairo(
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
            fontSize: 16.sp,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: ScreenUtilNew.height(16),
            ),
            GestureDetector(
              onTap: (){
                Navigator.of(context).push(PageAnimationTransition(page: const ProfileScreen(), pageAnimationType: LeftToRightTransition()));
                print(SharedPrefController().getValue(PrefKeys.token.name));
                },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: ScreenUtilNew.width(16)),
                child: Container(
                  // height: ScreenUtilNew.height(132),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryColor,
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Image.asset(
                          AssetsManger.backGroundCardProfile,
                          height: ScreenUtilNew.height(66),
                          width: ScreenUtilNew.width(60),
                          fit: BoxFit.fill,
                        ),
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: ScreenUtilNew.height(16)
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: ScreenUtilNew.width(16),
                              ),
                              Text(
                                "$now",
                                style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 10.sp,
                                  color: Colors.white,
                                ),
                              ),
                              const Expanded(child: SizedBox()),
                              Text(
                                greeting,
                                style: GoogleFonts.cairo(
                                  fontSize: 16.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: ScreenUtilNew.width(16),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: ScreenUtilNew.height(8),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(right: ScreenUtilNew.width(16)),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                SharedPrefController().getValue(PrefKeys.nameEmployee.name),
                                style: GoogleFonts.cairo(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: ScreenUtilNew.height(8),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(right: ScreenUtilNew.width(16)),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                "${AppStrings.homeScreen2} "+SharedPrefController().getValue(PrefKeys.lastLoggedIn.name),
                                style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: ScreenUtilNew.width(16)),
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                SharedPrefController().getValue(PrefKeys.typeEmployee.name),
                                style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: ScreenUtilNew.height(16),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: ScreenUtilNew.height(16),
            ),
            Padding(
              padding: EdgeInsets.only(right: ScreenUtilNew.width(16)),
              child: Align(
                alignment: Alignment.topRight,
                child: Text(
                  AppStrings.homeScreen3,
                  style: GoogleFonts.cairo(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(height: ScreenUtilNew.height(16),),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: ScreenUtilNew.width(16)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AccessSpeedWidget(
                    title: AppStrings.homeScreen6,
                    pathIcon: AssetsManger.transBankIcon,
                    onTap: () {
                      Navigator.of(context).push(PageAnimationTransition(page:  AllTransactionsScreen(), pageAnimationType: LeftToRightTransition()));

                    },
                  ),
                  AccessSpeedWidget(
                    title: AppStrings.homeScreen5,
                    pathIcon: AssetsManger.boxDailyIcon,
                    onTap: () {
                      Navigator.of(context).push(PageAnimationTransition(page: const BoxesDailyScreen(), pageAnimationType: LeftToRightTransition()));
                    },
                  ),
                  AccessSpeedWidget(
                    title: AppStrings.homeScreen4,
                    pathIcon: AssetsManger.summaryProcess,
                    onTap: () {
                      Navigator.of(context).push(PageAnimationTransition(page: const SummaryProcess(), pageAnimationType: LeftToRightTransition()));
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: ScreenUtilNew.height(16),),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: ScreenUtilNew.width(16)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AccessSpeedWidget(
                    title: AppStrings.homeScreen10,
                    pathIcon: AssetsManger.person,
                    onTap: () {
                      Navigator.of(context).push(PageAnimationTransition(page: const AttendanceScreen(), pageAnimationType: LeftToRightTransition()));

                    },
                  ),
                  AccessSpeedWidget(
                    title: AppStrings.homeScreen9,
                    pathIcon: AssetsManger.salaryIcon,
                    onTap: () {
                      Navigator.of(context).push(PageAnimationTransition(page:  SalaryPage(), pageAnimationType: LeftToRightTransition()));

                    },
                  ),
                  AccessSpeedWidget(
                    title: AppStrings.homeScreen8,
                    pathIcon: AssetsManger.addTrans,
                    onTap: () {
                      Navigator.of(context).push(PageAnimationTransition(page: const AddTransactionNewScreen(), pageAnimationType: LeftToRightTransition()));
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: ScreenUtilNew.height(16),),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: ScreenUtilNew.width(16)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: ScreenUtilNew.height(100),
                    width: ScreenUtilNew.width(100),
                  ),
                  SizedBox(
                    height: ScreenUtilNew.height(100),
                    width: ScreenUtilNew.width(100),
                  ),
                  AccessSpeedWidget(
                    title: AppStrings.homeScreen11,
                    pathIcon: AssetsManger.addProcess,
                    onTap: () {
                      context.showSnackBar(message: "هذا القسم قيد التطوير",erorr: true);
                    },
                  ),
                ],
              ),
            ),


          ],
        ),
      ),
    );
  }
}


