import 'package:exchange/core/utils/app_colors.dart';
import 'package:exchange/core/utils/app_strings.dart';
import 'package:exchange/core/utils/assets_manger.dart';
import 'package:exchange/core/utils/screen_util_new.dart';
import 'package:exchange/features/home/summaryProcess/presentation/widgets/process_widget_summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/models/summary_process_data.dart';
import '../../domain/use_cases/summary_process_controller.dart';

class SummaryProcess extends StatelessWidget {
  const SummaryProcess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_forward,
              color: AppColors.primaryColor,
            ),
          ),
        ],
        title: Text(
          AppStrings.summaryProcessScreen1,
          style: GoogleFonts.cairo(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
      ),
      body: FutureBuilder<DataSummaryProcess?>(
        future: ApiSummaryProcessController().fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Column(
              children: [
                Expanded(child: SizedBox()),
                Center(
                    child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                  backgroundColor: AppColors.secondaryColor,
                )),
                Expanded(child: SizedBox()),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            DataSummaryProcess? data = snapshot.data;

            if (data == null) {
              return Center(
                child: Text(
                  'لا يوجد بيانات لعرضها',
                  style: GoogleFonts.cairo(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondaryColor),
                ),
              );
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  ProcessWidgetSummary(
                      imagePath: AssetsManger.walletIcon,
                      textBalance: "${data.totalBalance}",
                      title: "الرصيد الحالي "),
                  SizedBox(
                    height: ScreenUtilNew.height(16),
                  ),
                  ProcessWidgetSummary(
                      imagePath: AssetsManger.transBackProcessSummary,
                      textBalance: "${data.bankTransferCount}",
                      title: "التحويلات البنكية "),
                  SizedBox(
                    height: ScreenUtilNew.height(16),
                  ),
                  ProcessWidgetSummary(
                      imagePath: AssetsManger.personAttendance,
                      textBalance: "${data.attendanceDays}",
                      title: "عدد الحضور "),
                  SizedBox(
                    height: ScreenUtilNew.height(16),
                  ),
                  ProcessWidgetSummary(
                      imagePath: AssetsManger.personAttendanceTwo,
                      textBalance: "${data.absenceDays}",
                      title: "عدد الغياب")
                ],
              ),
            );
          } else {
            return Center(
              child: Text(
                'لا يوجد بيانات لعرضها',
                style: GoogleFonts.cairo(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondaryColor),
              ),
            );
          }
        },
      ),
    );
  }
}
