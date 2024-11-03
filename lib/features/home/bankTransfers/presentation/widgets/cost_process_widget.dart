import 'package:exchange/core/utils/screen_util_new.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/utils/app_colors.dart';

class CostProcessWidget extends StatelessWidget {
  String title;
  String subTitle;
  int status;
   CostProcessWidget({super.key,required this.title,required this.subTitle,required this.status});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: GoogleFonts.cairo(
              fontWeight: FontWeight.w500,
              color: status==2?AppColors.primaryColor:AppColors.secondaryColor,
              fontSize: 10.sp),
        ),
        SizedBox(height: ScreenUtilNew.height(8),),
        Text(
          subTitle,
          style: GoogleFonts.cairo(
              fontWeight: FontWeight.bold,
              color: status==2?AppColors.primaryColor:AppColors.secondaryColor,
              fontSize: 10.sp),
        ),
      ],
    );
  }
}
