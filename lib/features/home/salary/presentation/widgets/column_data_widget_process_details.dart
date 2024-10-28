import 'package:exchange/core/utils/screen_util_new.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ColumnDataWidgetProcessDetails extends StatelessWidget {
  String title;
  String subTitle;
  int maxLines;
   ColumnDataWidgetProcessDetails(
      {super.key, required this.title, required this.subTitle,required this.maxLines});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ScreenUtilNew.width(100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(title,style: GoogleFonts.cairo(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          textDirection: TextDirection.rtl,
          maxLines: 1,
          textAlign: TextAlign.right,
          overflow: TextOverflow.ellipsis,),
          SizedBox(height: ScreenUtilNew.height(4),),
          Text(subTitle=="null"?"لا يوجد":subTitle,style: GoogleFonts.cairo(
            fontSize: 12.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
            textDirection: TextDirection.rtl,
            maxLines: maxLines,
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,),
        ],
      ),
    );
  }
}
