import 'package:exchange/config/routes/app_routes.dart';
import 'package:exchange/core/utils/app_colors.dart';
import 'package:exchange/core/utils/assets_manger.dart';
import 'package:exchange/core/utils/screen_util_new.dart';
import 'package:exchange/features/home/dailyBoxes/presentation/widgets/widget_detalis_box_process.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/utils/app_strings.dart';
import '../widgets/column_data_widget_process_details.dart';
import '../widgets/cost_process_widget.dart';

class DetailsBoxScreen extends StatefulWidget {
  DetailsBoxScreen({super.key});

  @override
  State<DetailsBoxScreen> createState() => _DetailsBoxScreenState();
}

class _DetailsBoxScreenState extends State<DetailsBoxScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Routes.boxScreen);
        },
        backgroundColor: Colors.white,
        elevation: 10,
        child: const Icon(
          Icons.add,
          color: AppColors.secondaryColor,
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.filter_list_rounded,
            color: AppColors.primaryColor,
          ),
        ),
        actions: [
          IconButton(onPressed: () {
            Navigator.pop(context);
          }, icon: const Icon(Icons.arrow_forward))
        ],
        centerTitle: true,
        title: Text(
          "إسم الصندوق",
          style: GoogleFonts.cairo(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
      ),
      body: Column(
        children: [
          TabBar(
              controller: _tabController,
              dividerColor: Colors.transparent,
              labelColor: AppColors.secondaryColor,
              indicatorColor: AppColors.secondaryColor,
              unselectedLabelStyle: GoogleFonts.cairo(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.sp,
                  color: Colors.black),
              labelStyle: GoogleFonts.cairo(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.sp,
                  color: AppColors.secondaryColor),
              tabs: const [
                Tab(
                  child: Text(
                    AppStrings.detailsScreen2,
                  ),
                ),
                Tab(
                  child: Text(AppStrings.detailsScreen1),
                ),
              ]),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ListView.builder(
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        SizedBox(height: ScreenUtilNew.height(ScreenUtilNew.height(16)),),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: ScreenUtilNew.width(16)),
                          child: Slidable(
                            // startActionPane: ActionPane(
                            //
                            //   motion: const ScrollMotion(),
                            //   // A pane can dismiss the Slidable.
                            //   // dismissible: DismissiblePane(onDismissed: () {}),
                            //   // All actions are defined in the children parameter.
                            //   children: [
                            //     // A SlidableAction can have an icon and/or a label.
                            //     // SlidableAction(
                            //     //   onPressed: (value){},
                            //     //   backgroundColor: Color(0xFFFE4A49),
                            //     //   foregroundColor: Colors.white,
                            //     //   icon: Icons.delete,
                            //     //   label: 'Delete',
                            //     // ),
                            //     // SlidableAction(
                            //     //   onPressed: (value){},
                            //     //   backgroundColor: Color(0xFF21B7CA),
                            //     //   foregroundColor: Colors.white,
                            //     //   icon: Icons.share,
                            //     //   label: 'Share',
                            //     // ),
                            //   ],
                            // ),

                            // The end action pane is the one at the right or the bottom side.
                            endActionPane: ActionPane(
                              motion: ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (value) {
                                    Navigator.pushNamed(context, Routes.updateProcessScreen);

                                  },
                                  backgroundColor:
                                  AppColors.primaryColor.withOpacity(0.08),
                                  foregroundColor: AppColors.secondaryColor,

                                  icon: Icons.mode_edit,
                                  borderRadius: BorderRadius.only(topRight: Radius.circular(5.r),bottomRight: Radius.circular(5.r)),
                                  label: 'Update',
                                ),
                              ],
                            ),
                            // The child of the Slidable is what the user sees when the
                            // component is not dragged.
                            child: WidgetDetailsBoxProcess(),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                ListView.builder(
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        SizedBox(height: ScreenUtilNew.height(ScreenUtilNew.height(16)),),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: ScreenUtilNew.width(16)),
                          child: Slidable(
                            // startActionPane: ActionPane(
                            //
                            //   motion: const ScrollMotion(),
                            //   // A pane can dismiss the Slidable.
                            //   // dismissible: DismissiblePane(onDismissed: () {}),
                            //   // All actions are defined in the children parameter.
                            //   children: [
                            //     // A SlidableAction can have an icon and/or a label.
                            //     // SlidableAction(
                            //     //   onPressed: (value){},
                            //     //   backgroundColor: Color(0xFFFE4A49),
                            //     //   foregroundColor: Colors.white,
                            //     //   icon: Icons.delete,
                            //     //   label: 'Delete',
                            //     // ),
                            //     // SlidableAction(
                            //     //   onPressed: (value){},
                            //     //   backgroundColor: Color(0xFF21B7CA),
                            //     //   foregroundColor: Colors.white,
                            //     //   icon: Icons.share,
                            //     //   label: 'Share',
                            //     // ),
                            //   ],
                            // ),

                            // The end action pane is the one at the right or the bottom side.
                            endActionPane: ActionPane(
                              motion: ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (value) {
                                    Navigator.pushNamed(context, Routes.updateProcessScreen);
                                    // Navigator.pushNamed(context, Routes.updateProcessScreen);
                                  },
                                  backgroundColor:
                                      AppColors.primaryColor.withOpacity(0.08),
                                  foregroundColor: AppColors.secondaryColor,

                                  icon: Icons.mode_edit,
                                  borderRadius: BorderRadius.only(topRight: Radius.circular(5.r),bottomRight: Radius.circular(5.r)),
                                  label: 'Update',
                                ),
                              ],
                            ),
                            // The child of the Slidable is what the user sees when the
                            // component is not dragged.
                            child: WidgetDetailsBoxProcess(),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
