import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/screen_util_new.dart';
class WidgetWhenWatingDataDropDownMenu extends StatelessWidget {
  String textTitle;
  double width;
   WidgetWhenWatingDataDropDownMenu({super.key,required this.textTitle,required this.width});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          textTitle,
          style: GoogleFonts.cairo(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
          textAlign: TextAlign.right,
          textDirection: TextDirection.rtl,
        ),
        SizedBox(height: ScreenUtilNew.height(8)),
        Container(
          height: ScreenUtilNew.height(52),
          width: width,
          decoration: BoxDecoration(
           color:  AppColors.primaryColor.withOpacity(0.08),
          ),
          child: Row(
            children: [
              Padding(
                padding:EdgeInsets.only(left: ScreenUtilNew.width(16)),
                child: const Icon(Icons.keyboard_arrow_down,
                color: AppColors.primaryColor,),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
