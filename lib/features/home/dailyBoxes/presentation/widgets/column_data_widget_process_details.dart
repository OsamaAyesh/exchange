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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          title,
          style: GoogleFonts.cairo(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          textAlign: TextAlign.right,
        ),
        SizedBox(
          height: ScreenUtilNew.height(4),
        ),
        Text(
          subTitle,
          style: GoogleFonts.cairo(
            fontSize: 12.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: maxLines,
          textAlign: TextAlign.right,
          textDirection: TextDirection.rtl,
        ),
      ],
    );
  }
}
