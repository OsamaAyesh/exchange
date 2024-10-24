import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/assets_manger.dart';
import '../../../../../core/utils/screen_util_new.dart';

class DailyBoxesWidget extends StatelessWidget {
  String nameBox;
  String balanceAva;
  String balanceRemain;
  String coinName;
  String dateCreatedBox;

  DailyBoxesWidget(
      {super.key,
      required this.nameBox,
      required this.balanceAva,
      required this.balanceRemain,
      required this.coinName,
      required this.dateCreatedBox});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtilNew.width(16)),
      child: Container(
        // height: ScreenUtilNew.height(132),
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.secondaryColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurStyle: BlurStyle.normal,
              spreadRadius: 5,
              blurRadius: 20,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Image.asset(
                AssetsManger.backgroundBoxDaily,
                height: ScreenUtilNew.height(64),
                width: ScreenUtilNew.width(64),
                fit: BoxFit.fill,
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: ScreenUtilNew.height(20),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: ScreenUtilNew.width(16)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            // height: ScreenUtilNew.height(24),
                            // width: ScreenUtilNew.width(88),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5.r)),
                            padding: EdgeInsets.symmetric(
                              horizontal: ScreenUtilNew.width(8),
                              vertical: ScreenUtilNew.width(4),
                            ),

                            child: Center(
                              child: Text(
                                coinName,
                                style: GoogleFonts.cairo(
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.primaryColor,
                                    fontSize: 12.sp),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: ScreenUtilNew.height(16),
                          ),
                          Text(
                            "تاريخ الإنشاء",
                            style: GoogleFonts.cairo(
                              color: Colors.white,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          SizedBox(
                            height: ScreenUtilNew.height(4),
                          ),
                          Text(
                            dateCreatedBox,
                            style: GoogleFonts.cairo(
                              color: Colors.white,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      const Expanded(child: SizedBox()),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            nameBox,
                            style: GoogleFonts.cairo(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                            ),
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.right,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            height: ScreenUtilNew.height(4),
                          ),
                          Text(
                            "الرصيد الحالي:$balanceAva",
                            style: GoogleFonts.cairo(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 16.sp,
                            ),
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.right,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            height: ScreenUtilNew.height(4),
                          ),
                          Text(
                            "الرصيد المتبقي:$balanceRemain",
                            style: GoogleFonts.cairo(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 16.sp,
                            ),
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.right,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: ScreenUtilNew.height(20),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
