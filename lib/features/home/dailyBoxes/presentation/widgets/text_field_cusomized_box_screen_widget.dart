import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/assets_manger.dart';
import '../../../../../core/utils/screen_util_new.dart';

class TextFieldCusomizedBoxScreenWidget extends StatelessWidget {
  TextEditingController textEditingController;
  String hintText;
  IconData iconData;
  bool textFiledDiscount;
  double width;
  int maxLines;
  int minLines;
  bool enabled;
  Color filledColor;
  TextStyle styleHintText;
  TextInputType textInputType;
  void Function(String vlaueChanged)? onChanged;


  TextFieldCusomizedBoxScreenWidget(
      {super.key,
      required this.hintText,
      required this.iconData,
      required this.textEditingController,
      required this.textFiledDiscount,
      required this.width,
      required this.minLines,
      required this.maxLines,
      required this.enabled,
      required this.filledColor,
      required this.styleHintText,
      required this.textInputType,
        this.onChanged
      });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: SizedBox(
        width: width,
        // height: ScreenUtilNew.height(52),
        child: TextField(
          // keyboardType: TextInputType.number,
          onChanged: onChanged,
          keyboardType: textInputType,
          enabled: enabled,
          controller: textEditingController,
          style: styleHintText,
          textAlign: TextAlign.right,
          maxLines: maxLines,
          minLines: minLines,
          textDirection: TextDirection.rtl,
          decoration: InputDecoration(
            prefixIcon: textFiledDiscount ? Icon(iconData,color: Colors.black,) : null,
            hintTextDirection: TextDirection.rtl,
            hintText: hintText,
            hintStyle:styleHintText,
            filled: true,
            fillColor: filledColor,
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(5.r)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(5.r)),
          ),
        ),
      ),
    );
  }

}
