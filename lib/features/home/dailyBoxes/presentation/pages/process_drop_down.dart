import 'package:exchange/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../data/models/data_type_process.dart';
import '../manager/providers/selectdata_list_process_provider.dart';

class ProcessDropdown extends StatefulWidget {
  final DataTypeProcess? selectedValue;
  final ValueChanged<DataTypeProcess?> onChanged;
  final List<DataTypeProcess> dataListProcess;

  ProcessDropdown({
    Key? key,
    required this.selectedValue,
    required this.onChanged,
    required this.dataListProcess,
  }) : super(key: key);

  @override
  _ProcessDropdownState createState() => _ProcessDropdownState();
}

class _ProcessDropdownState extends State<ProcessDropdown> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SelectdataListProcessProvider>(builder: (context,provider,child){
      return Directionality(
        textDirection: TextDirection.rtl, // تعيين اتجاه النص
        child: Container(
          height: ScreenUtil().setHeight(52), // استخدام ScreenUtil لتحديد ارتفاع الحاوية
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(0.08), // يمكنك تعديل لون الخلفية حسب الحاجة
            borderRadius: BorderRadius.circular(5.r), // حواف دائرية
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<DataTypeProcess>(
              isExpanded: true,
              value: widget.selectedValue, // Use selectedValue passed to the widget
              icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black, size: 24),
              dropdownColor: Colors.white,
              onChanged: (value) {
                if (value != null) {
                  Provider.of<SelectdataListProcessProvider>(context, listen: false).newDataTypeProcess = value;
                  widget.onChanged(value);
                }
              },
              items: widget.dataListProcess.map((DataTypeProcess item) {
                return DropdownMenuItem<DataTypeProcess>(
                  value: item,
                  child: Text(
                    item.name,
                    style: GoogleFonts.cairo(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      );
    });
  }
}
