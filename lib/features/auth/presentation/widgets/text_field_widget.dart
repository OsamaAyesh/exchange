import 'package:exchange/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/screen_util_new.dart';
class TextFieldWidget extends StatefulWidget {
  TextEditingController textEditingController;
  IconData iconData;
  String hintText;
  String label;
  bool passwordTextFiled;
   TextFieldWidget({super.key,required this.textEditingController,required this.iconData,required this.hintText,required this.label,required this.passwordTextFiled});

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  bool secureText=false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(right: ScreenUtilNew.width(16)),
          child: Align(
            alignment: Alignment.topRight,
            child: Text(
              widget.label,
              style: GoogleFonts.cairo(
                color: const Color(0XFF959595),
                fontWeight: FontWeight.w500,
                fontSize: 12.sp,
              ),
            ),
          ),
        ),
        SizedBox(height: ScreenUtilNew.height(8),),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: ScreenUtilNew.width(16)),
          child: TextField(
            obscureText: secureText,
            obscuringCharacter: "*",
            controller:widget.textEditingController ,
            textDirection: TextDirection.rtl,
            decoration: InputDecoration(
              prefixIcon:widget.passwordTextFiled?IconButton(onPressed: (){
                setState(() {
                  secureText=!secureText;
                });
              }, icon: Icon(secureText?Icons.remove_red_eye:Icons.visibility_off,color: AppColors.primaryColor,),) :null,
              suffixIcon: Icon(widget.iconData,color:  const Color(0XFF959595),),
              hintText: widget.hintText,
              hintTextDirection: TextDirection.rtl,
              hintStyle: GoogleFonts.cairo(
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.r),
                borderSide: const BorderSide(
                  color: Color(0XFF959595),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.r),
                borderSide: const BorderSide(
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
