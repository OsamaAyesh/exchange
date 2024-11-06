import 'package:exchange/core/utils/screen_util_new.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/assets_manger.dart';
class BoxWidget extends StatelessWidget {
  String nameBoxContain;
  String balance;
  Color backgroundColor;
   BoxWidget({super.key,required this.nameBoxContain,required this.balance,required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtilNew.width(16)),
      child: Container(
        // height: ScreenUtilNew.height(117),
        width: double.infinity,
        decoration:  BoxDecoration(color:backgroundColor),
        child: Stack(
          children: [
            Image.asset(
              AssetsManger.backGroundCardProfile,
              height: ScreenUtilNew.height(72),
              width: ScreenUtilNew.width(64),
              fit: BoxFit.fill,
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: ScreenUtilNew.width(16),top: ScreenUtilNew.height(16)),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      nameBoxContain,
                      style: GoogleFonts.cairo(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: ScreenUtilNew.width(56),top: ScreenUtilNew.height(8)),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      balance,
                      style: GoogleFonts.cairo(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 42.sp),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
