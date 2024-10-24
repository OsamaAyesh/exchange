import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/screen_util_new.dart';
class ElevatedButtonCustomDataAndPasswordUpdated extends StatelessWidget {
  void Function()? onTap;
  String title;
   ElevatedButtonCustomDataAndPasswordUpdated({super.key,required this.onTap,required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: ScreenUtilNew.width(16)),
        child: Container(
          height: ScreenUtilNew.height(52),
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.r),
              color: AppColors.primaryColor),
          child: Center(
            child: Text(
              title,
              style: GoogleFonts.cairo(
                fontSize: 14.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
