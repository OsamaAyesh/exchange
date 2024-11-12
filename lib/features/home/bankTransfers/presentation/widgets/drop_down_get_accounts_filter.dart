import 'package:exchange/core/utils/app_colors.dart';
import 'package:exchange/core/utils/screen_util_new.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/models/account_model.dart';

class DropDownGetAccountsFilter extends StatefulWidget {
  final int selectDefaultValue;
  final String textTitle;
  final List<AccountModel> options; // قائمة الخيارات من نوع DataSources
  final ValueChanged<AccountModel?>
  onChanged; // استدعاء دالة callback مع DataSources
  final String selectedValueString;

  const DropDownGetAccountsFilter(
      {super.key, required this.textTitle, required this.options, required this.onChanged, required this.selectedValueString,required this.selectDefaultValue});

  @override
  State<DropDownGetAccountsFilter> createState() =>
      _DropDownGetAccountsFilterState();
}

class _DropDownGetAccountsFilterState extends State<DropDownGetAccountsFilter> {
  AccountModel? selectedAccount;

  @override
  void initState() {
    super.initState();
    // تعيين القيمة الابتدائية بناءً على القيمة المحددة
    selectedAccount = widget.options.firstWhere(
            (option) => option.id == widget.selectDefaultValue,
        orElse: () => widget.options[0]); // أو أول خيار كمثال

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
              child: DropdownButton<AccountModel>(
                isExpanded: true,
                value: selectedAccount,
                icon: const Icon(Icons.keyboard_arrow_down,
                    color: AppColors.primaryColor, size: 24),
                dropdownColor: Colors.white,
                onChanged: (AccountModel? newValue) {
                  if (newValue != null) {
                    setState(() {
                      selectedAccount = newValue;
                      widget.onChanged(newValue);
                    });
                  }
                },
                items: widget.options.map((AccountModel item) {
                  return DropdownMenuItem<AccountModel>(
                    alignment: Alignment.centerRight,
                    value: item,
                    child: Text(
                      item.name!,
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
