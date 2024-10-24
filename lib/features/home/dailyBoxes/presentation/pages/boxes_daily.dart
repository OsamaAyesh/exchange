import 'package:exchange/core/utils/assets_manger.dart';
import 'package:exchange/core/utils/screen_util_new.dart';
import 'package:exchange/features/home/dailyBoxes/domain/use_cases/daily_boxes_controller.dart';
import 'package:exchange/features/home/dailyBoxes/presentation/pages/box_screen.dart';
import 'package:exchange/features/home/dailyBoxes/presentation/widgets/daily_boxes_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_animation_transition/animations/left_to_right_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../data/models/daily_boxes.dart'; // Correct model import

class BoxesDailyScreen extends StatelessWidget {
  const BoxesDailyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
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
          AppStrings.boxesDaily,
          style: GoogleFonts.cairo(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
      ),
      body: Column(
        children: [
          FutureBuilder<List<BoxesDaily>?>(
            future: ApiDailyBoxesController().fetchData(),
            // No need for the nullable check if the future is guaranteed to return a non-null future object.
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
                List<BoxesDaily>? data = snapshot.data?.cast<BoxesDaily>();
                if (data == null || data.isEmpty) {
                  return Expanded(
                    child: Center(
                      child: Text(
                        'لا يوجد صناديق اليوم',
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
                            GestureDetector(
                              onTap:(){
                                Navigator.of(context).push(PageAnimationTransition(page: BoxScreen(idBox: box.id!,nameBox: box.name!,), pageAnimationType: LeftToRightTransition()));
                              },
                              child: DailyBoxesWidget(
                                  nameBox: "${box.name}",
                                  balanceAva: "${box.totalBalance}",
                                  balanceRemain: "${box.reminder}",
                                  coinName: "${box.currency}",
                                  dateCreatedBox: "${box.date}"),
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
                  child: Center(child: Text('No data available')),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
