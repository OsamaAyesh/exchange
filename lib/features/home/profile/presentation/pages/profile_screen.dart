import 'dart:ffi';

import 'package:exchange/config/routes/app_routes.dart';
import 'package:exchange/core/utils/app_colors.dart';
import 'package:exchange/core/utils/app_strings.dart';
import 'package:exchange/core/utils/assets_manger.dart';
import 'package:exchange/core/utils/context_extension.dart';
import 'package:exchange/core/utils/screen_util_new.dart';
import 'package:exchange/features/home/profile/presentation/widgets/profile_information_user_widget.dart';
import 'package:exchange/features/home/profile/presentation/widgets/widget_profile_updated_data_and_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/sevices/shared_pref_controller.dart';
import '../../../../auth/data/models/process_response.dart';
import '../../domain/use_cases/logout_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFFAFAFA),
      appBar: AppBar(
        backgroundColor: const Color(0XFFFAFAFA),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, Routes.homeScreen);
            },
            icon: const Icon(
              Icons.arrow_forward,
              color: Colors.black,
            ),
          ),
        ],
        title: Text(
          AppStrings.profileScreen1,
          style: GoogleFonts.cairo(
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
            fontSize: 16.sp,
          ),
        ),
      ),
      body:  SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: ScreenUtilNew.height(52),
            ),
            Center(
              child: SizedBox(
                height: ScreenUtilNew.height(130),
                width: ScreenUtilNew.width(130),
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: ScreenUtilNew.height(64),
                      backgroundImage:  NetworkImage(
                        "${SharedPrefController().getValue<String>(PrefKeys.pathImage.name)}" ,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: ScreenUtilNew.height(14),
                          right: ScreenUtilNew.width(16)),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          height: ScreenUtilNew.height(12),
                          width: ScreenUtilNew.width(12),
                          decoration: const BoxDecoration(
                              color: Colors.green, shape: BoxShape.circle),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: ScreenUtilNew.height(16),
            ),
            Center(
              child: Text(
                "${SharedPrefController().getValue<String>(PrefKeys.nameEmployee.name)}" ,
                style: GoogleFonts.cairo(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            Text(
              "${SharedPrefController().getValue<String>(PrefKeys.typeEmployee.name)}" ,
              style: GoogleFonts.cairo(
                color: const Color(0XFF999999),
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
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
                  AppStrings.profileScreen2,
                  style: GoogleFonts.cairo(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: ScreenUtilNew.height(8),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: ScreenUtilNew.width(16)),
              child: Container(
                  // height: ScreenUtilNew.height(188),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14.r),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          offset: const Offset(0, 3),
                          blurRadius: 20,
                          spreadRadius: 4,
                          blurStyle: BlurStyle.normal)
                    ],
                  ),
                  child: Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: ScreenUtilNew.height(16),
                          left: ScreenUtilNew.width(16),
                        ),
                        child: Container(
                          height: ScreenUtilNew.height(24),
                          width: ScreenUtilNew.width(95),
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(5.r)),
                          child: Center(
                            child: Text(
                              SharedPrefController().getValue<bool>(PrefKeys.isActive.name) ?? false
                                  ? "الحساب فعال"
                                  : "الحساب غير فعال",
                              style: GoogleFonts.cairo(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Column(
                        children: [
        
                          Padding(
                            padding: EdgeInsets.only(
                              right: ScreenUtilNew.width(24),
                              top: ScreenUtilNew.height(16),
                            ),
                            child: ProfileInformationUserWidget(
                                title: AppStrings.profileScreen3,
                                subTitle: "${SharedPrefController().getValue<String>(PrefKeys.emailEmployee.name)}"),
                          ),
                          SizedBox(
                            height: ScreenUtilNew.height(8),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              right: ScreenUtilNew.width(24),
                            ),
                            child: ProfileInformationUserWidget(
                                title: AppStrings.profileScreen4,
                                subTitle: "${SharedPrefController().getValue<String>(PrefKeys.phoneEmployee.name)}"),
                          ),
                          SizedBox(
                            height: ScreenUtilNew.height(8),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: ScreenUtilNew.width(16),
                              ),
                              ProfileInformationUserWidget(
                                  title: AppStrings.profileScreen5,
                                  subTitle: "${SharedPrefController().getValue<String>(PrefKeys.lastLoggedOut.name)}"),
                              const Expanded(child: SizedBox()),
                              ProfileInformationUserWidget(
                                  title: AppStrings.profileScreen6,
                                  subTitle: "${SharedPrefController().getValue<String>(PrefKeys.lastLoggedIn.name)}"),
                              SizedBox(
                                width: ScreenUtilNew.width(16),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: ScreenUtilNew.height(16),
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
            SizedBox(
              height: ScreenUtilNew.height(32),
            ),
            WidgetProfileUpdatedDataAndPassword(
                onTap: () {
                  Navigator.pushNamed(context, Routes.updateDataScreen);
                },
                title: AppStrings.profileScreen7,
                iconData: Icons.settings),
            SizedBox(
              height: ScreenUtilNew.height(32),
            ),
            WidgetProfileUpdatedDataAndPassword(
                onTap: () {
                  Navigator.pushNamed(context, Routes.updatePassword);
                },
                title: AppStrings.profileScreen8,
                iconData: Icons.update),
            SizedBox(
              height: ScreenUtilNew.height(32),
            ),
            GestureDetector(
              onTap: () =>_logout(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    AppStrings.profileScreen9,
                    style: GoogleFonts.cairo(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(
                    width: ScreenUtilNew.width(8),
                  ),
                  const Icon(
                    Icons.logout,
                    color: Colors.red,
                  ),
                  SizedBox(
                    width: ScreenUtilNew.width(16),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: ScreenUtilNew.height(32),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> _logout(BuildContext context) async {
    ProcessResponse processResponse = await LogoutApiController().logout();
    if (processResponse.success) {
      Navigator.pushReplacementNamed(context, Routes.loginScreen);
      context.showSnackBar(message: "تم تسجيل الخروج بنجاح",);
    }else{
      print("error");
    }
  }
}
