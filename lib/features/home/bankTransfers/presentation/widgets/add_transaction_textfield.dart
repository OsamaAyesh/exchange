import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/screen_util_new.dart';

class AddTransactionTextField extends StatelessWidget {
  String hintText;
  int minLines;
  int maxLines;

  AddTransactionTextField(
      {super.key,
      required this.hintText,
      required this.maxLines,
      required this.minLines});

  @override
  Widget build(BuildContext context) {
    return TextField(
      textDirection: TextDirection.rtl,
      style: GoogleFonts.cairo(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.primaryColor,
      ),
      minLines: minLines,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintTextDirection: TextDirection.rtl,
        hintText: hintText,
        hintStyle: GoogleFonts.cairo(
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.primaryColor,
        ),
        filled: true,
        fillColor: AppColors.primaryColor.withOpacity(0.07),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: BorderSide.none),
      ),
    );
  }
}
