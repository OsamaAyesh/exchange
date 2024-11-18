import 'package:exchange/core/utils/app_colors.dart';
import 'package:exchange/core/utils/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class MaintenanceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("الصيانة",style:  GoogleFonts.cairo(
          fontWeight: FontWeight.bold,
          color: AppColors.primaryColor,
          fontSize: 16.sp
      ),
          textAlign: TextAlign.center,),
      centerTitle: true,),
      body: Center(
        child: Text(
          'التطبيق في مرحلة صيانة. يرجى المحاولة لاحقًا.',
          style: GoogleFonts.cairo(
            fontWeight: FontWeight.w400,
            color: AppColors.secondaryColor,
            fontSize: 14.sp
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
