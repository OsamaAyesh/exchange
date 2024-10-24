import 'package:exchange/core/utils/app_colors.dart';
import 'package:exchange/core/utils/screen_util_new.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class WidgetNotification extends StatelessWidget {
  const WidgetNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: ScreenUtilNew.width(16)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: ScreenUtilNew.height(8),
                width: ScreenUtilNew.width(8),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
              Expanded(child: SizedBox()),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "تم إضافة تحديث للتطبيق ",
                    style: GoogleFonts.cairo(
                      fontSize: 16.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    width: ScreenUtilNew.width(250),
                    child: Text(
                      "تم اضافة ميزة الاشعارات من قبل الادارة الى التطبيق الخاص بالشركة ",
                      style: GoogleFonts.cairo(
                        fontSize: 10.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: ScreenUtilNew.width(8),
              ),
              Container(
                height: ScreenUtilNew.height(36),
                width: ScreenUtilNew.width(36),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.secondaryColor.withOpacity(0.13),
                ),
                child: const Icon(
                  Icons.notifications,
                  color: AppColors.secondaryColor,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: ScreenUtilNew.width(8),),
        Divider(
          indent: ScreenUtilNew.width(8),
          endIndent: ScreenUtilNew.width(8),
        ),
        SizedBox(height: ScreenUtilNew.height(8),),
      ],
    );
  }
}
