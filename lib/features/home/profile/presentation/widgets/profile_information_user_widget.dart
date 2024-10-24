import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/screen_util_new.dart';
class ProfileInformationUserWidget extends StatelessWidget {
  String title;
  String subTitle;
   ProfileInformationUserWidget({super.key,required this.title,required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Text(
            title,
            style: GoogleFonts.cairo(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.primaryColor,
            ),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
            maxLines: 1,
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Text(
            subTitle,
            style: GoogleFonts.cairo(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0XFF8A8A8A
              ),
            ),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}
