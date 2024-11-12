import 'package:flutter/material.dart';
import 'package:exchange/core/utils/app_colors.dart';
import 'package:exchange/core/utils/screen_util_new.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/models/beneficiarie_model.dart';

class DropDownWidgetGetUsersFilter extends StatefulWidget {
  final String textTitle;
  final List<BeneficiarieModel> options; // تغيير نوع الخيارات إلى BeneficiarieModel
  final ValueChanged<BeneficiarieModel?> onChanged; // تغيير نوع callback
  final String selectedValueString;
  final double width;
  final int defaultValueId;
  const DropDownWidgetGetUsersFilter({
    super.key,
    required this.textTitle,
    required this.options,
    required this.onChanged,
    required this.selectedValueString,
    required this.width,
    required this.defaultValueId
  });

  @override
  State<DropDownWidgetGetUsersFilter> createState() =>
      _DropDownWidgetGetUsersFilterState();
}

class _DropDownWidgetGetUsersFilterState extends State<DropDownWidgetGetUsersFilter> {
  BeneficiarieModel? selectedAccount;

  @override
  void initState() {
    super.initState();

    // تعيين القيمة الابتدائية بناءً على القيمة المحددة
    selectedAccount = widget.options.firstWhere(
          (option) => option.id == widget.defaultValueId,
      orElse: () => widget.options[0], // إرجاع أول خيار أو كائن جديد كبديل
    );
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
            width: widget.width,
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.08),
              borderRadius: BorderRadius.circular(5.r),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<BeneficiarieModel>(
                isExpanded: true,
                value: selectedAccount,
                icon: const Icon(Icons.keyboard_arrow_down,
                    color: AppColors.primaryColor, size: 24),
                dropdownColor: Colors.white,
                onChanged: (BeneficiarieModel? newValue) {
                  if (newValue != null) {
                    setState(() {
                      selectedAccount = newValue;
                      widget.onChanged(newValue);
                    });
                  }
                },
                items: widget.options.map((BeneficiarieModel item) {
                  return DropdownMenuItem<BeneficiarieModel>(
                    alignment: Alignment.centerRight,
                    value: item,
                    child: Text(
                      item.name!, // تأكد من أن الاسم ليس null
                      style: GoogleFonts.cairo(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primaryColor),
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
