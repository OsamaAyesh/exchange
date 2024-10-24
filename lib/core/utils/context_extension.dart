import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:ghala_new/core/utils/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

extension ContextExtension on BuildContext{

  void showSnackBar({
    required String message,
    bool erorr= false,
  })
  {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message,style: GoogleFonts.cairo(
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,color: Colors.white
        ),
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.center,),
        backgroundColor: erorr ? Colors.red.shade800 :  AppColors.primaryColor,
        duration: const Duration(seconds: 4),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r)
        ),
      ),
    );
  }
}