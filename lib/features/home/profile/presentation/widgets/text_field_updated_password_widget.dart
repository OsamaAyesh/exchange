import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/screen_util_new.dart';

class TextFieldUpdatedPasswordWidget extends StatefulWidget {
  String title;
  String hintText;
  IconData iconData;
  bool enabled;
  Color filledColor;
  TextEditingController controller;


  TextFieldUpdatedPasswordWidget(
      {super.key,
      required this.title,
      required this.hintText,
      required this.iconData,
      required this.enabled,
      required this.filledColor,
      required this.controller});

  @override
  State<TextFieldUpdatedPasswordWidget> createState() => _TextFieldUpdatedPasswordWidgetState();
}

class _TextFieldUpdatedPasswordWidgetState extends State<TextFieldUpdatedPasswordWidget> {
  bool visablePassword=false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "*",
              style: GoogleFonts.cairo(color: Colors.red),
            ),
            Padding(
              padding: EdgeInsets.only(
                right: ScreenUtilNew.width(16),
                top: ScreenUtilNew.height(16),
              ),
              child: Text(
                widget.title,
                style: GoogleFonts.cairo(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0XFF959595),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: ScreenUtilNew.height(8),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: ScreenUtilNew.width(16)),
          child: SizedBox(
            // height: ScreenUtilNew.height(46),
            child: TextField(
              controller:widget.controller ,
              textDirection: TextDirection.rtl,
              style: GoogleFonts.cairo(
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontSize: 12.sp,
              ),
              obscureText: visablePassword,
              obscuringCharacter: "*",
              decoration: InputDecoration(
                prefixIcon: IconButton(onPressed: (){
                  setState(() {
                    visablePassword=!visablePassword;
                  });
                }, icon:  Icon(visablePassword?Icons.remove_red_eye:Icons.visibility_off,color: AppColors.primaryColor,)),
                enabled: widget.enabled,
                hintTextDirection: TextDirection.rtl,
                hintText: widget.hintText,
                hintStyle: GoogleFonts.cairo(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontSize: 12.sp,
                ),
                filled: !widget.enabled,
                fillColor: widget.filledColor,
                suffixIcon: Icon(widget.iconData, color: Color(0XFF959595)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.r),
                  borderSide: widget.enabled
                      ? const BorderSide(color: Color(0XFF959595))
                      : BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.r),
                  borderSide: const BorderSide(color: AppColors.primaryColor),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
