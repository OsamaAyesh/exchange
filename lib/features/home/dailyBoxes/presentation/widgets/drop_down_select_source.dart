// import 'package:exchange_new_app/core/utils/app_colors.dart';
// import 'package:exchange_new_app/core/utils/screen_util_new.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import '../../data/models/get_sources_controller.dart';
// class DropDownSelectSource extends StatefulWidget {
//   final String textTitle;
//   final List<DataSources> options; // قائمة الخيارات من نوع DataSources
//   final ValueChanged<DataSources?> onChanged; // استدعاء دالة callback مع DataSources
//
//   const DropDownSelectSource({super.key,required this.textTitle,required this.onChanged,required this.options});
//
//   @override
//   State<DropDownSelectSource> createState() => _DropDownSelectSourceState();
// }
//
// class _DropDownSelectSourceState extends State<DropDownSelectSource> {
//   DataSources? selectedSource; // تخزين المصدر المختار
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.end,
//       children: [
//         Text(
//           widget.textTitle,
//           style: GoogleFonts.cairo(
//             fontSize: 14.sp,
//             fontWeight: FontWeight.w600,
//             color: Colors.black,
//           ),
//         ),
//         SizedBox(
//           height: ScreenUtilNew.height(8),
//         ),
//         SizedBox(
//           height: ScreenUtilNew.height(52), // تحديد الطول
//           width: ScreenUtilNew.width(160), // تحديد العرض
//           child: Directionality(
//             textDirection: TextDirection.rtl,
//             child: Container(
//               padding: EdgeInsets.symmetric(horizontal: 8.0),
//               decoration: BoxDecoration(
//                 color: AppColors.primaryColor.withOpacity(0.08),
//                 borderRadius: BorderRadius.circular(5.r),
//               ),
//               child: DropdownButtonHideUnderline(
//                 child: DropdownButton<DataSources>(
//                   isExpanded: true,
//                   value: selectedSource,
//                   icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.primaryColor, size: 24),
//                   iconSize: 24,
//                   dropdownColor: Colors.white,                  onChanged: (DataSources? newValue) {
//                     setState(() {
//                       selectedSource = newValue; // تحديث المصدر المختار
//                       widget.onChanged(newValue); // استدعاء دالة callback مع المصدر
//                     });
//                   },
//                   items: widget.options.map((DataSources item) {
//                     return DropdownMenuItem<DataSources>(
//                       alignment: Alignment.centerRight,
//                       value: item,
//                       child: Text(
//                         item.name!,
//                         style: GoogleFonts.cairo(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),
//                       ),
//                     );
//                   }).toList(),                ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// //
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:exchange/core/utils/app_colors.dart';
// import 'package:exchange/core/utils/screen_util_new.dart';
//
// import '../../data/models/get_sources_controller.dart';

// class DropDownSelectSource extends StatefulWidget {
//   final String textTitle;
//   final List<DataSources> options; // قائمة الخيارات من نوع DataSources
//   final ValueChanged<DataSources?>
//       onChanged; // استدعاء دالة callback مع DataSources
//   final String selectedValueString;
//   const DropDownSelectSource({
//     super.key,
//     required this.textTitle,
//     required this.onChanged,
//     required this.options,
//     required this.selectedValueString
//   });
//
//   @override
//   State<DropDownSelectSource> createState() => _DropDownSelectSourceState();
// }
//
// class _DropDownSelectSourceState extends State<DropDownSelectSource> {
//   DataSources? selectedSource; // تخزين المصدر المختار
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.end, // محاذاة عناصر العمود لليمين
//       children: [
//         Text(
//           widget.textTitle,
//           style: GoogleFonts.cairo(
//             fontSize: 14.sp,
//             fontWeight: FontWeight.w600,
//             color: Colors.black,
//           ),
//           textAlign: TextAlign.right,
//           textDirection: TextDirection.rtl,
//         ),
//         SizedBox(height: ScreenUtilNew.height(8)),
//         SizedBox(
//           height: ScreenUtilNew.height(52),
//           width: ScreenUtilNew.width(160),
//           child: Stack(
//             children: [
//               Padding(
//                 padding:EdgeInsets.only(right: ScreenUtilNew.width(12)),
//                 child: Align(
//                   alignment:Alignment.centerRight,
//                     child: Text(widget.selectedValueString,style: GoogleFonts.cairo(
//                         fontSize: 14.sp,
//                         fontWeight: FontWeight.w400,
//                         color: AppColors.primaryColor),)),
//               ),
//               SizedBox(
//                 height: ScreenUtilNew.height(52), // تحديد الطول
//                 width: ScreenUtilNew.width(160), // تحديد العرض
//                 child: Directionality(
//                   textDirection: TextDirection.rtl,
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                     decoration: BoxDecoration(
//                       color: AppColors.primaryColor.withOpacity(0.08),
//                       borderRadius: BorderRadius.circular(5.r),
//                     ),
//                     child: DropdownButtonHideUnderline(
//                       child: DropdownButton<DataSources>(
//                         isExpanded: true,
//                         value: selectedSource, // تعيين القيمة المحددة
//                         icon: const Icon(Icons.keyboard_arrow_down,
//                             color: AppColors.primaryColor, size: 24),
//                         iconSize: 24,
//                         dropdownColor: Colors.white,
//                         onChanged: (DataSources? newValue) {
//                           setState(() {
//                             selectedSource = newValue; // تحديث المصدر المختار
//                             widget.onChanged(newValue); // استدعاء دالة callback مع المصدر
//                           });
//                         },
//                         items: widget.options.map((DataSources item) {
//                           return DropdownMenuItem<DataSources>(
//                             alignment: Alignment.centerRight,
//                             value: item,
//                             child: Text(
//                               item.name!, // عرض الاسم
//                               style: GoogleFonts.cairo(
//                                   fontSize: 14.sp,
//                                   fontWeight: FontWeight.w400,
//                                   color: AppColors.primaryColor),
//                             ),
//                           );
//                         }).toList(),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//
//         // SizedBox(
//         //   height: ScreenUtilNew.height(52), // تحديد الطول
//         //   width: ScreenUtilNew.width(160), // تحديد العرض
//         //   child: Directionality(
//         //     textDirection: TextDirection.rtl,
//         //     child: Container(
//         //       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//         //       decoration: BoxDecoration(
//         //         color: AppColors.primaryColor.withOpacity(0.08),
//         //         borderRadius: BorderRadius.circular(5.r),
//         //       ),
//         //       child: DropdownButtonHideUnderline(
//         //         child: DropdownButton<DataSources>(
//         //           isExpanded: true,
//         //           value: selectedSource,
//         //           // عرض المصدر المختار
//         //           hint: Text(
//         //             selectedSource != null?selectedSource!.name!:"اختر المصدر",
//         //             style: GoogleFonts.cairo(
//         //                 fontSize: 14.sp,
//         //                 fontWeight: FontWeight.w400,
//         //                 color: AppColors.primaryColor),
//         //           ),
//         //           icon: const Icon(Icons.keyboard_arrow_down,
//         //               color: AppColors.primaryColor, size: 24),
//         //           iconSize: 24,
//         //           dropdownColor: Colors.white,
//         //           onChanged: (DataSources? newValue) {
//         //             setState(() {
//         //               selectedSource = newValue; // تحديث المصدر المختار
//         //               widget.onChanged(
//         //                   newValue); // استدعاء دالة callback مع المصدر
//         //             });
//         //           },
//         //           items: widget.options.map((DataSources item) {
//         //             return DropdownMenuItem<DataSources>(
//         //               alignment: Alignment.centerRight,
//         //               value: item,
//         //               child: Text(
//         //                 item.name!, // عرض الاسم
//         //                 style: GoogleFonts.cairo(
//         //                     fontSize: 14.sp,
//         //                     fontWeight: FontWeight.w400,
//         //                     color: Colors.black),
//         //               ),
//         //             );
//         //           }).toList(),
//         //         ),
//         //       ),
//         //     ),
//         //   ),
//         // ),
//       ],
//     );
//   }
// }

import 'package:exchange/core/utils/app_colors.dart';
import 'package:exchange/core/utils/screen_util_new.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/models/get_sources_controller.dart';

class DropDownSelectSource extends StatefulWidget {
  final int selectDefaultValue;
  final String textTitle;
  final List<DataSources> options; // قائمة الخيارات من نوع DataSources
  final ValueChanged<DataSources?>
  onChanged; // استدعاء دالة callback مع DataSources
  final String selectedValueString;

  const DropDownSelectSource(
      {super.key, required this.textTitle, required this.options, required this.onChanged, required this.selectedValueString,required this.selectDefaultValue});

  @override
  State<DropDownSelectSource> createState() =>
      _DropDownSelectSourceState();
}

class _DropDownSelectSourceState extends State<DropDownSelectSource> {
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
    // selectedAccount = widget.options.isNotEmpty
    //     ? widget.options.firstWhere(
    //         (option) => option.id == widget.selectDefaultValue,
    //     orElse: () => widget.options[0] // إعادة الخيار الأول كقيمة افتراضية
    // )
    //     : null; // إذا كانت القائمة فارغة
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
