import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/screen_util_new.dart';
class ContainerScanQr extends StatelessWidget {
  void Function()? onTap;
   ContainerScanQr({super.key,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap ,
      child: Container(
        width: ScreenUtilNew.width(52),
        height: ScreenUtilNew.height(52),
        decoration: BoxDecoration(
            color: AppColors.secondaryColor,
            borderRadius: BorderRadius.circular(5.r)),
        child: const Icon(
          Icons.qr_code_scanner_rounded,
          size: 36,
          color: Colors.white,
        ),
      ),
    );
  }
}
