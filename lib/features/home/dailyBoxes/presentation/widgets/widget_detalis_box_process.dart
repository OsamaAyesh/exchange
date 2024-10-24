import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/assets_manger.dart';
import '../../../../../core/utils/screen_util_new.dart';
import 'column_data_widget_process_details.dart';
import 'cost_process_widget.dart';
class WidgetDetailsBoxProcess extends StatelessWidget {
  const WidgetDetailsBoxProcess({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // height: ScreenUtilNew.height(164),
          width: double.infinity,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurStyle: BlurStyle.normal,
                  spreadRadius: 6,
                  blurRadius: 20,
                  offset: const Offset(0, 3))
            ],
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(5.r),
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: Image.asset(
                  AssetsManger.detailsWidgetBackground,
                  height: ScreenUtilNew.height(57),
                  width: ScreenUtilNew.width(61),
                  fit: BoxFit.fill,
                ),
              ),
              Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(height: ScreenUtilNew.height(8),),
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            right: ScreenUtilNew.width(24),
                            top: ScreenUtilNew.height(8)),
                        child:
                        ColumnDataWidgetProcessDetails(
                          title: AppStrings.detailsScreen4,
                          subTitle: "19",
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            right: ScreenUtilNew.width(8),
                            top: ScreenUtilNew.height(8)),
                        child:
                        ColumnDataWidgetProcessDetails(
                          title: AppStrings.detailsScreen3,
                          subTitle: "1209109210",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtilNew.height(8),
                  ),
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            right: ScreenUtilNew.width(24),
                            top: ScreenUtilNew.height(8)),
                        child:
                        ColumnDataWidgetProcessDetails(
                          title: AppStrings.detailsScreen6,
                          subTitle: "بنكي",
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            right: ScreenUtilNew.width(8),
                            top: ScreenUtilNew.height(8)),
                        child:
                        ColumnDataWidgetProcessDetails(
                          title: AppStrings.detailsScreen5,
                          subTitle: "إيداع",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtilNew.height(8),
                  ),
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            right: ScreenUtilNew.width(24),
                            top: ScreenUtilNew.height(8)),
                        child:
                        ColumnDataWidgetProcessDetails(
                          title: AppStrings.detailsScreen8,
                          subTitle: "أحمد صالحة",
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            right: ScreenUtilNew.width(8),
                            top: ScreenUtilNew.height(8)),
                        child:
                        ColumnDataWidgetProcessDetails(
                          title: AppStrings.detailsScreen7,
                          subTitle: "20",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: ScreenUtilNew.height(8),),

                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(height: ScreenUtilNew.height(8),),
                  Padding(
                    padding: EdgeInsets.only(
                        top: ScreenUtilNew.height(8),
                        left: ScreenUtilNew.width(8)),
                    child: Container(
                      height: ScreenUtilNew.height(67),
                      width: ScreenUtilNew.width(155),
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(5.r),
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              const Expanded(
                                  child: SizedBox()),
                              CostProcessWidget(
                                title: "مبلغ العملية",
                                subTitle: "1700",
                              ),
                              Expanded(child: SizedBox()),
                            ],
                          ),
                          const VerticalDivider(
                            indent: 8,
                            endIndent: 8,
                          ),
                          Column(
                            children: [
                              Expanded(child: SizedBox()),
                              CostProcessWidget(
                                title: "مبلغ العملية",
                                subTitle: "1700",
                              ),
                              Expanded(child: SizedBox()),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtilNew.height(8),
                  ),
                  ColumnDataWidgetProcessDetails(
                    title: AppStrings.detailsScreen9,
                    subTitle: "",
                  ),
                  SizedBox(height: ScreenUtilNew.height(8),),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
