import 'package:exchange/core/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/assets_manger.dart';
import '../../../../../core/utils/screen_util_new.dart';

class ProcessWidgetSummary extends StatelessWidget {
  String imagePath;
  String textBalance;
  String title;

  ProcessWidgetSummary(
      {super.key,
      required this.imagePath,
      required this.textBalance,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtilNew.width(16)),
      child: Container(
        height: ScreenUtilNew.height(128),
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurStyle: BlurStyle.normal,
              spreadRadius: 5,
              blurRadius: 20,
              offset: const Offset(0, 4))
        ]),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomLeft,
              child: Image.asset(
                AssetsManger.summaryProcessBackground,
                height: ScreenUtilNew.height(85),
                width: ScreenUtilNew.width(100),
                fit: BoxFit.fill,
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      bottom: ScreenUtilNew.height(32),
                      left: ScreenUtilNew.width(32)),
                  child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Image.asset(
                        imagePath,
                        height: ScreenUtilNew.height(64),
                        width: ScreenUtilNew.width(64),
                      )),
                ),
                const Expanded(child: SizedBox()),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      textBalance,
                      style: GoogleFonts.cairo(
                          fontWeight: FontWeight.bold,
                          fontSize: 32.sp,
                          color: AppColors.secondaryColor),
                    ),
                    Text(
                      title,
                      style: GoogleFonts.cairo(
                        color: const Color(0XFFA6A6A6),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      textAlign: TextAlign.right,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
                SizedBox(
                  width: ScreenUtilNew.width(16)
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
