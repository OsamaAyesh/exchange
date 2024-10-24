import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/screen_util_new.dart';



class TextFieldsUpdatedDataWidget extends StatelessWidget {
  String title;
  String hintText;
  IconData iconData;
  bool enabled;
  Color filledColor;
  TextEditingController controller;
   TextFieldsUpdatedDataWidget(
      {super.key,
      required this.title,
      required this.hintText,
      required this.iconData,
      required this.enabled,
      required this.filledColor,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "*",
              style: GoogleFonts.cairo(color: Colors.red),
            ),
            Padding(
              padding: EdgeInsets.only(
                right: ScreenUtilNew.width(16),
                top: ScreenUtilNew.height(16),
              ),
              child: Text(
                title,
                style: GoogleFonts.cairo(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0XFF959595),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: ScreenUtilNew.height(8),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: ScreenUtilNew.width(16)),
          child: SizedBox(
            // height: ScreenUtilNew.height(46),
            child: TextField(
              controller: controller,
              textDirection: TextDirection.rtl,
              style: GoogleFonts.cairo(
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontSize: 12.sp,
              ),
              decoration: InputDecoration(
                enabled: enabled,
                hintTextDirection: TextDirection.rtl,
                hintText: hintText,
                hintStyle: GoogleFonts.cairo(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontSize: 12.sp,
                ),
                filled: !enabled,
                fillColor: filledColor,
                suffixIcon:  Icon(iconData, color: Color(0XFF959595)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.r),
                  borderSide: enabled? const BorderSide(color: Color(0XFF959595)):BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.r),
                  borderSide: const BorderSide(color: AppColors.primaryColor),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
