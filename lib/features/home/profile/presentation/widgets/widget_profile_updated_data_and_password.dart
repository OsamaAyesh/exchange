import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/screen_util_new.dart';
class WidgetProfileUpdatedDataAndPassword extends StatelessWidget {
  void Function()? onTap;
  String title;
  IconData iconData;
   WidgetProfileUpdatedDataAndPassword({super.key,required this.onTap,required this.title,required this.iconData});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(width: ScreenUtilNew.width(16),),
           Icon(Icons.arrow_back_ios,color: Colors.black,),
          const Expanded(child: SizedBox()),
          Text(
            title,
            style: GoogleFonts.cairo(
              fontWeight: FontWeight.w400,
              fontSize: 14.sp,
              color: Colors.black,
            ),
          ),
          SizedBox(width: ScreenUtilNew.width(8),),
           Icon(
            iconData,
            color: Colors.black,
            size: 24,
          ),
          SizedBox(width: ScreenUtilNew.width(16),),
        ],
      ),
    );
  }
}
