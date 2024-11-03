import 'package:exchange/features/home/bankTransfers/presentation/widgets/column_data_widget_process_details.dart';
import 'package:exchange/features/home/bankTransfers/presentation/widgets/cost_process_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/assets_manger.dart';
import '../../../../../core/utils/screen_util_new.dart';

class WidgetTransferBankInformation extends StatelessWidget {
  int id;
  String refNumber;
  int accountId;
  String accountName;
  int userId;
  String userName;
  String nameReceive;
  int status;
  String amount;
  String currency;
  String date;
  String notes;
  String image;

   WidgetTransferBankInformation(
      {super.key, required this.id, required this.refNumber,required this.accountId,
      required this.accountName,
      required this.userId,
      required this.userName,
      required this.nameReceive,
      required this.status,
      required this.amount,
      required this.currency,
      required this.notes,
      required this.date,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
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
        color: status==2?AppColors.primaryColor:AppColors.secondaryColor,
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
              SizedBox(
                height: ScreenUtilNew.height(16),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        right: ScreenUtilNew.width(8),
                        top: ScreenUtilNew.height(8)),
                    child: ColumnDataWidgetProcessDetails(
                      title: AppStrings.allTransaction4,
                      subTitle: status==2?"مكتملة":"غير مكتملة",
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        right: ScreenUtilNew.width(8),
                        top: ScreenUtilNew.height(8)),
                    child: ColumnDataWidgetProcessDetails(
                      title: AppStrings.allTransaction3,
                      subTitle: refNumber,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: ScreenUtilNew.height(8),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        right: ScreenUtilNew.width(8),
                        top: ScreenUtilNew.height(8)),
                    child: ColumnDataWidgetProcessDetails(
                      title: AppStrings.allTransaction6,
                      subTitle: userName,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        right: ScreenUtilNew.width(8),
                        top: ScreenUtilNew.height(8)),
                    child: ColumnDataWidgetProcessDetails(
                      title: AppStrings.allTransaction5,
                      subTitle: accountName,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: ScreenUtilNew.height(8),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        right: ScreenUtilNew.width(8),
                        top: ScreenUtilNew.height(8)),
                    child: ColumnDataWidgetProcessDetails(
                      title: AppStrings.allTransaction8,
                      subTitle: date,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        right: ScreenUtilNew.width(8),
                        top: ScreenUtilNew.height(8)),
                    child: ColumnDataWidgetProcessDetails(
                      title: AppStrings.allTransaction7,
                      subTitle: nameReceive,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: ScreenUtilNew.height(16),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                height: ScreenUtilNew.height(16),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: ScreenUtilNew.height(8), left: ScreenUtilNew.width(8)),
                child: Container(
                  height: ScreenUtilNew.height(67),
                  width: ScreenUtilNew.width(155),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.r),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          const Expanded(child: SizedBox()),
                          CostProcessWidget(
                            title: "مبلغ العملية",
                            subTitle: amount,
                            status: status,
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
                            title: "العملة",
                            subTitle: currency,
                            status: status,
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
                subTitle: notes,
              ),
              SizedBox(
                height: ScreenUtilNew.height(16),
              ),
            ],
          )
        ],
      ),
    );
  }
}
