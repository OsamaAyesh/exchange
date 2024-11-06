import 'package:exchange/features/home/attendance/data/models/attendance_model.dart';
import 'package:exchange/features/home/attendance/presentation/manager/data_extra_model_provider.dart';
import 'package:exchange/features/home/attendance/presentation/widgets/column_data_widget_process_details.dart';
import 'package:exchange/features/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:page_animation_transition/animations/right_to_left_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';
import 'package:provider/provider.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/assets_manger.dart';
import '../../../../../core/utils/screen_util_new.dart';
import '../../domain/use_cases/attendance_controller.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  String? startDate;
  String? endDate;

  // Function to fetch data with selected dates
  Future<List<AttendanceModel>> _fetchFilteredData() {
    return AttendanceController().fetchAttendance(context, startDate: startDate, endDate: endDate);
  }

  void _openFilterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController _startDateController = TextEditingController(text: startDate);
        final TextEditingController _endDateController = TextEditingController(text: endDate);

        DateTime? selectedStartDate;
        DateTime? selectedEndDate;
        final ValueNotifier<String> _startDateTextValue = ValueNotifier<String>("قم باختيار تاريخ البدء");
        final ValueNotifier<String> _endDateTextValue = ValueNotifier<String>("قم باختيار تاريخ الانتهاء");

        Future<void> _selectStartDate(BuildContext context) async {
          final DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
          );
          if (pickedDate != null && pickedDate != selectedStartDate) {
            selectedStartDate = pickedDate;
            _startDateTextValue.value = DateFormat('dd-MM-yyyy').format(selectedStartDate!);
            _startDateController.text = _startDateTextValue.value;
          }
        }

        Future<void> _selectEndDate(BuildContext context) async {
          final DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
          );
          if (pickedDate != null && pickedDate != selectedEndDate) {
            selectedEndDate = pickedDate;
            _endDateTextValue.value = DateFormat('dd-MM-yyyy').format(selectedEndDate!);
            _endDateController.text = _endDateTextValue.value;
          }
        }

        Widget _buildInputField({
          required String labelText,
          required TextEditingController controller,
          VoidCallback? onTap,
          ValueNotifier<String>? textValueNotifier,
        }) {
          return GestureDetector(
            onTap: onTap,
            child: Container(
              height: ScreenUtilNew.height(52),
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0XFFEBF7F1),
                borderRadius: BorderRadius.circular(5.r),
              ),
              child: Row(
                children: [
                  SizedBox(width: ScreenUtilNew.width(8)),
                  const Icon(Icons.date_range, color: AppColors.primaryColor),
                  const Expanded(child: SizedBox()),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: ScreenUtilNew.width(8)),
                      child: ValueListenableBuilder<String>(
                        valueListenable: textValueNotifier!,
                        builder: (context, value, child) {
                          return Text(
                            value,
                            style: GoogleFonts.cairo(
                              fontWeight: FontWeight.w400,
                              fontSize: 16.sp,
                              color: AppColors.primaryColor,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return AlertDialog(
          title: Center(
            child: Text(
              "فلترة البيانات",
              style: GoogleFonts.cairo(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildInputField(
                labelText: "Start Date",
                controller: _startDateController,
                onTap: () {
                  _selectStartDate(context);
                },
                textValueNotifier: _startDateTextValue,
              ),
              SizedBox(height: ScreenUtilNew.height(16)),
              _buildInputField(
                labelText: "End Date",
                controller: _endDateController,
                onTap: () {
                  _selectEndDate(context);
                },
                textValueNotifier: _endDateTextValue,
              ),
              SizedBox(height: ScreenUtilNew.height(16)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  startDate = _startDateController.text;
                  endDate = _endDateController.text;
                });
                _fetchFilteredData();
                Navigator.of(context).pop();
              },
              child: Text(
                "تطبيق",
                style: GoogleFonts.cairo(
                  fontSize: 16.sp,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "إلغاء",
                style: GoogleFonts.cairo(
                  fontSize: 16.sp,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            SizedBox(
              height: ScreenUtilNew.height(48),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: (){
                        setState(() {
                          startDate = null;
                          endDate = null;
                        });
                        _fetchFilteredData();
                      },
                      icon: const Icon(
                        Icons.update,
                        color: Colors.red,
                      ),
                    ),
                    IconButton(
                      onPressed: (){
                        _openFilterDialog();
                      },
                      icon: const Icon(
                        Icons.filter_list_outlined,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "الحضور والغياب",
                  style: GoogleFonts.cairo(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).push(PageAnimationTransition(
                        page: HomeScreen(),
                        pageAnimationType: RightToLeftTransition(),
                      ));                  },
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.primaryColor,
                    ))
              ],
            ),
            // FutureBuilder(future: , builder: builder),
            Consumer<DataExtraModelProvider>(builder: (context,provider,child){
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: ScreenUtilNew.width(16)),
                child: Container(
                  height: ScreenUtilNew.height(90),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: AppColors.secondaryColor,
                      borderRadius: BorderRadius.circular(5.r)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ColumnDataWidgetProcessDetails(title: "أيام الغياب", subTitle: "${provider.dataAttendanceExtra.absenceDays}"),
                          ColumnDataWidgetProcessDetails(title: "أيام الحضور", subTitle: "${provider.dataAttendanceExtra.attendanceDays}")
                        ],
                      )
                    ],
                  ),
                ),
              );
            }),
            Padding(
              padding: EdgeInsets.only(right: ScreenUtilNew.width(16)),
              child: Align(
                alignment: Alignment.topRight,
                child: Text(
                  "سجل الحضور",
                  style: GoogleFonts.cairo(
                      fontSize: 16.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            SizedBox(
              height: ScreenUtilNew.height(16),
            ),
            FutureBuilder<List<AttendanceModel>>(
                future: _fetchFilteredData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                          backgroundColor: AppColors.secondaryColor,
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Expanded(
                      child: Center(child: Text('Error: ${snapshot.error}')),
                    );
                  } else if (snapshot.hasData) {
                    List<AttendanceModel>? data =
                        snapshot.data?.cast<AttendanceModel>();
                    if (data == null || data.isEmpty) {
                      return Expanded(
                        child: Center(
                          child: Text(
                            'لا يوجد بيانات تخص الحضور والغياب لعرضها',
                            style: GoogleFonts.cairo(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                              color: AppColors.secondaryColor,
                            ),
                          ),
                        ),
                      );
                    }
                    return Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                          physics: const BouncingScrollPhysics(),
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            var box = data[index];
                            return Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: ScreenUtilNew.width(16)),
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: AppColors.primaryColor,
                                      ),
                                      height: ScreenUtilNew.height(122),
                                      width: double.infinity,
                                      child: Stack(
                                        children: [
                                          Align(
                                            alignment: Alignment.bottomLeft,
                                            child: Image.asset(
                                              AssetsManger
                                                  .detailsWidgetBackground,
                                              height: ScreenUtilNew.height(57),
                                              width: ScreenUtilNew.width(61),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  ColumnDataWidgetProcessDetails(
                                                      title: "تاريخ الحضور",
                                                      subTitle:
                                                      "${data[index].attendanceDate}"),
                                                  SizedBox(
                                                    height:
                                                    ScreenUtilNew.height(
                                                        16),
                                                  ),
                                                  ColumnDataWidgetProcessDetails(
                                                      title: "تاريخ المغادرة",
                                                      subTitle:
                                                      "${data[index].leaveDate}"),
                                                ],
                                              ),
                                              VerticalDivider(
                                                color: Colors.white
                                                    .withOpacity(0.6),
                                                endIndent: 8,
                                                indent: 8,
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  ColumnDataWidgetProcessDetails(
                                                      title: "وقت الحضور",
                                                      subTitle:
                                                      "${data[index].attendanceTime}"),
                                                  SizedBox(
                                                    height:
                                                    ScreenUtilNew.height(
                                                        16),
                                                  ),
                                                  ColumnDataWidgetProcessDetails(
                                                      title: "وقت المغادرة",
                                                      subTitle:
                                                      "${data[index].leaveTime}"),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      )),
                                ),
                                SizedBox(
                                  height: ScreenUtilNew.height(16),
                                )
                              ],
                            );
                          }),
                    ); // Replace this with actual UI rendering
                  } else {
                    return const Expanded(
                      child: Center(child: Text('لا يوجد بيانات لعرضها حاليا')),
                    );
                  }
                }),
          ],
        ));
  }
}
