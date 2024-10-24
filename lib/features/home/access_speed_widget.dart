import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/utils/app_strings.dart';
import '../../core/utils/assets_manger.dart';
import '../../core/utils/screen_util_new.dart';

class AccessSpeedWidget extends StatelessWidget {
  String pathIcon;
  String title;
  void Function()? onTap;

  AccessSpeedWidget(
      {super.key,
      required this.pathIcon,
      required this.title,
        required this.onTap
      });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      // onTap: (){},
      child: Container(
        // height: ScreenUtilNew.height(100),
        width: ScreenUtilNew.width(100),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.r),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.25),
                offset: const Offset(0, 4),
                blurRadius: 20,
                spreadRadius: 4,
                blurStyle: BlurStyle.normal)
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: ScreenUtilNew.height(16),
            ),
            Image.asset(
              pathIcon,
              width: ScreenUtilNew.width(48),
              height: ScreenUtilNew.height(48),
              fit: BoxFit.contain,
            ),
            SizedBox(
              height: ScreenUtilNew.height(8),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: ScreenUtilNew.width(4)),
              child: Text(
                title,
                style: GoogleFonts.cairo(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 10.sp,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            SizedBox(
              height: ScreenUtilNew.height(16),
            )
          ],
        ),
      ),
    );
  }
}
