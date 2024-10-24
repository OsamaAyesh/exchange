import 'package:exchange/core/utils/app_colors.dart';
import 'package:exchange/core/utils/screen_util_new.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/models/get_sources_controller.dart';

class DropDownWidgetTextField extends StatefulWidget {
  String textTitle;
  List<String> options;
  final Function(String) onChanged; // إضافة دالة callback

  DropDownWidgetTextField(
      {super.key, required this.textTitle, required this.options,required this.onChanged});

  @override
  State<DropDownWidgetTextField> createState() =>
      _DropDownWidgetTextFieldState();
}

class _DropDownWidgetTextFieldState extends State<DropDownWidgetTextField> {
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    // تعيين القيمة الافتراضية إذا كانت `selectedValue` فارغة
    if (widget.options.isEmpty) {
      selectedValue = null; // إذا كانت القائمة فارغة، تعيين القيمة كـ null
    } else {
      selectedValue = widget.options.first; // تعيين أول عنصر كقيمة افتراضية
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          widget.textTitle,
          style: GoogleFonts.cairo(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        SizedBox(
          height: ScreenUtilNew.height(8),
        ),
        SizedBox(
          height: ScreenUtilNew.height(52), // تحديد الطول
          width: ScreenUtilNew.width(160), // تحديد العرض
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.08),
                borderRadius: BorderRadius.circular(5.r),
              ),
              child: DropdownButtonHideUnderline(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: ScreenUtilNew.width(8)),
                  child: DropdownButton<String>(
                    alignment: Alignment.topRight,
                    borderRadius: BorderRadius.circular(5.r),
                    isExpanded: true,
                    // إذا كانت القيمة الحالية غير متوفرة في القائمة، تعيين قيمة افتراضية أو null
                    value: (widget.options.contains(selectedValue) ? selectedValue : null),
                    icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.primaryColor, size: 24),
                    iconSize: 24,
                    dropdownColor: Colors.white,
                    onChanged: (newValue) {
                      setState(() {
                        selectedValue = newValue; // تحديث الخيار
                        widget.onChanged(newValue!); // استدعاء دالة callback
                        print(selectedValue);
                      });
                    },
                    // تأكد من وجود عنصر واحد على الأقل
                    items: widget.options.isEmpty
                        ? [
                      DropdownMenuItem(
                        value: null,
                        child: Text(
                          'No Value',
                          style: GoogleFonts.cairo(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      )
                    ]
                        : widget.options.map((item) {
                      return DropdownMenuItem<String>(
                        alignment: Alignment.centerRight,
                        value: item,
                        child: Text(
                          item,
                          style: GoogleFonts.cairo(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
