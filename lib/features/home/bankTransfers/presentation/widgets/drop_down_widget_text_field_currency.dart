import 'package:flutter/material.dart';
import 'package:exchange/core/utils/app_colors.dart';
import 'package:exchange/core/utils/screen_util_new.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/models/beneficiarie_model.dart';
import '../../data/models/currency_model.dart';
class DropDownWidgetTextFieldCurrency extends StatefulWidget {
  final String textTitle;
  final List<CurrencyModel> options; // تغيير نوع الخيارات إلى BeneficiarieModel
  final ValueChanged<CurrencyModel?> onChanged; // تغيير نوع callback
  final String selectedValueString;
  final double width;
  int selectid;
  bool updated;
   DropDownWidgetTextFieldCurrency({   super.key,
    required this.textTitle,
    required this.options,
    required this.onChanged,
    required this.selectedValueString,
    required this.width,
    required this.selectid,
     required this.updated
});

  @override
  State<DropDownWidgetTextFieldCurrency> createState() => _DropDownWidgetTextFieldCurrencyState();
}

class _DropDownWidgetTextFieldCurrencyState extends State<DropDownWidgetTextFieldCurrency> {
  CurrencyModel? selectedAccount;

  @override
  void initState() {
    super.initState();
    if(widget.updated){
      selectedAccount = widget.options.firstWhere(
            (option) => option.currency != null && option.currency!.contains(widget.selectedValueString),
        orElse: () => widget.options[0],
      );
      for (var option in widget.options) {
        print(option.currency); // للتحقق من القيم الفعلية لـ option.name
      }
    }else{
      selectedAccount = widget.options.firstWhere(
            (option) => option.id == widget.selectid,
        orElse: () => widget.options[0],
      );
    }
    // // تعيين القيمة الابتدائية بناءً على القيمة المحددة
    // selectedAccount = widget.options.firstWhere(
    //       (option) => option.name == widget.selectedValueString,
    //   orElse: () => widget.options[0],
    // );


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
          textAlign: TextAlign.right,
          textDirection: TextDirection.rtl,
        ),
        SizedBox(height: ScreenUtilNew.height(8)),
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
              child: DropdownButton<CurrencyModel>(
                isExpanded: true,
                value: selectedAccount,
                icon: const Icon(Icons.keyboard_arrow_down,
                    color: Colors.black, size: 24),
                dropdownColor: Colors.white,
                onChanged: (CurrencyModel? newValue) {
                  if (newValue != null) {
                    setState(() {
                      selectedAccount = newValue;
                      widget.onChanged(newValue);
                    });
                  }
                },
                items: widget.options.map((CurrencyModel item) {
                  return DropdownMenuItem<CurrencyModel>(
                    alignment: Alignment.centerRight,
                    value: item,
                    child: Text(
                        "${item.currency??""}-${item.name}",
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

