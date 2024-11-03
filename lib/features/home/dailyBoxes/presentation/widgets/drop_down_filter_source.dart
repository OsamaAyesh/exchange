import 'package:flutter/material.dart';
import 'package:exchange/core/utils/app_colors.dart';
import 'package:exchange/core/utils/screen_util_new.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/models/get_sources_controller.dart';

class DropDownFilterSource extends StatefulWidget {
  final int selectDefaultValue;
  final String textTitle;
  final List<DataSources> options; // قائمة الخيارات من نوع DataSources
  final ValueChanged<DataSources?>
  onChanged; // استدعاء دالة callback مع DataSources
  final String selectedValueString;

  const DropDownFilterSource(
      {super.key, required this.textTitle, required this.options, required this.onChanged, required this.selectedValueString,required this.selectDefaultValue});

  @override
  State<DropDownFilterSource> createState() =>
      _DropDownFilterSourceState();
}

class _DropDownFilterSourceState extends State<DropDownFilterSource> {
  DataSources? selectedAccount;

  // @override
  // void initState() {
  //   super.initState();
  //   // تعيين القيمة الابتدائية بناءً على القيمة المحددة
  //   selectedAccount = widget.options.firstWhere(
  //           (option) => option.id == widget.selectDefaultValue,
  //       orElse: () =>  widget.options[0]); // أو أول خيار كمثال
  //
  // }
  @override
  void initState() {
    super.initState();
    // تعيين القيمة الابتدائية بناءً على القيمة المحددة
    selectedAccount = widget.options.isNotEmpty
        ? widget.options.firstWhere(
            (option) => option.id == widget.selectDefaultValue,
        orElse: () => widget.options[0] // إعادة الخيار الأول كقيمة افتراضية
    )
        : null; // إذا كانت القائمة فارغة
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            height: ScreenUtilNew.height(52),
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.08),
              borderRadius: BorderRadius.circular(5.r),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<DataSources>(
                isExpanded: true,
                value: selectedAccount,
                icon: const Icon(Icons.keyboard_arrow_down,
                    color: Colors.black, size: 24),
                dropdownColor: Colors.white,
                onChanged: (DataSources? newValue) {
                  if (newValue != null) {
                    setState(() {
                      selectedAccount = newValue;
                      widget.onChanged(newValue);
                    });
                  }
                },
                items: widget.options.map((DataSources item) {
                  return DropdownMenuItem<DataSources>(
                    alignment: Alignment.centerRight,
                    value: item,
                    child: Text(
                      item.name!,
                      style: GoogleFonts.cairo(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
