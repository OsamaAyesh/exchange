import 'package:exchange/features/home/attendance/data/models/attendance_model.dart';
import 'package:exchange/features/home/attendance/presentation/manager/data_extra_model_provider.dart';
import 'package:exchange/features/home/attendance/presentation/widgets/column_data_widget_process_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_forward_ios,
                color: AppColors.primaryColor,
              ),
            ),
          ],
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            "الحضور والغياب",
            style: GoogleFonts.cairo(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor),
          ),
        ),
        body: Column(
          children: [
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
                future: AttendanceController().fetchAttendance(context),
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
