import 'package:exchange/core/sevices/firebase/firebase_notification.dart';
import 'package:exchange/core/utils/app_colors.dart';
import 'package:exchange/core/utils/assets_manger.dart';
import 'package:exchange/core/utils/context_extension.dart';
import 'package:exchange/core/utils/screen_util_new.dart';
import 'package:exchange/features/home/dailyBoxes/domain/use_cases/confirm_api_process_controller.dart';
import 'package:exchange/features/home/dailyBoxes/presentation/pages/box_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_animation_transition/animations/top_to_bottom_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';

import '../../../profile/presentation/widgets/elevated_button_custom_data_and_password_updated.dart';
import '../../data/models/show_transaction_model.dart';
import '../../domain/use_cases/show_transaction_by_number.dart';
import '../widgets/column_data_widget_process_details.dart';

class ConfirmProcess extends StatefulWidget {
  int idBox;
  String boxName;
  int numberId;

  ConfirmProcess({super.key, required this.numberId,required this.idBox,
  required this.boxName});

  @override
  State<ConfirmProcess> createState() => _ConfirmProcessState();
}

class _ConfirmProcessState extends State<ConfirmProcess> {
  ConfirmApiProcessController confirmApiProcessController =
      ConfirmApiProcessController();

  bool isLoading = false;

  void confirmNewTransaction(int numberProcess) async {
    setState(() {
      isLoading = true; // بدء التحميل
    });

    bool success = await confirmApiProcessController.confirmTransaction(
        "$numberProcess", "1");

    setState(() {
      isLoading = false; // انتهاء التحميل
    });

    if (success) {
      context.showSnackBar(message: "تم تأكيد العملية بنجاح", erorr: false);
      Navigator.of(context).push(PageAnimationTransition(page: BoxScreen(idBox: widget.idBox, nameBox: widget.boxName), pageAnimationType: TopToBottomTransition()));
      print("Transaction confirmed successfully.");
      // يمكنك إضافة منبه أو تغيير الشاشة هنا
    } else {
      context.showSnackBar(message: "لم تتم عملية التأكيد", erorr: true);
      print("Failed to confirm transaction.");
      // يمكنك إضافة منبه أو إظهار رسالة خطأ هنا
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_forward_ios,
              color: AppColors.primaryColor,
            ),
          )
        ],
        title: Text(
          "حالة العملية",
          style: GoogleFonts.cairo(
              fontSize: 16.sp,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(right: ScreenUtilNew.width(16)),
            child: Align(
              alignment: Alignment.topRight,
              child: Text(
                "بيانات العملية",
                style: GoogleFonts.cairo(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          SizedBox(
            height: ScreenUtilNew.height(16),
          ),
          FutureBuilder<DailyFundTransactionResponse>(
            future: ShowTransactionByNumber().fetchData(widget.numberId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                  backgroundColor: AppColors.secondaryColor,
                ));
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData) {
                return const Center(child: Text('No data available'));
              } else {
                DailyFundTransactionResponse data = snapshot.data!;
                if (data.status == 404) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtilNew.width(16)),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtilNew.width(16),
                          vertical: ScreenUtilNew.height(24)),
                      decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(5.r)),
                      width: double.infinity,
                      child: Center(
                          child: Text(
                        data.message,
                        style: GoogleFonts.cairo(color: Colors.white),
                      )),
                    ),
                  ); // عرض الرسالة عند الخطأ
                }
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtilNew.width(16)),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          child: Stack(
                            children: [
                              Image.asset(AssetsManger.backgroundBoxDaily),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(height: ScreenUtilNew.height(16)),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: ScreenUtilNew.width(32)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ColumnDataWidgetProcessDetails(
                                          title: "رقم العملية",
                                          subTitle: data.data?.number ?? "0",
                                          maxLines: 1,
                                        ),
                                        // استخدم `transaction` هنا
                                        ColumnDataWidgetProcessDetails(
                                          title: "حالة العملية",
                                          subTitle: data.data?.typeName ?? "0",
                                          maxLines: 1,
                                        ),
                                        ColumnDataWidgetProcessDetails(
                                          title: "تاريخ العملية",
                                          subTitle:
                                              data.data?.date ?? "لا يوجد",
                                          maxLines: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: ScreenUtilNew.height(16)),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: ScreenUtilNew.width(32)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ColumnDataWidgetProcessDetails(
                                          title: "العمولة",
                                          subTitle:
                                              "${data.data?.commissionValue ?? "لا يوجد"}%",
                                          maxLines: 1,
                                        ),
                                        ColumnDataWidgetProcessDetails(
                                          title: "إسم الخدمة",
                                          subTitle: data.data?.serviceName ??
                                              "لا يوجد",
                                          maxLines: 1,
                                        ),
                                        ColumnDataWidgetProcessDetails(
                                          title: "إسم المصدر",
                                          subTitle: data.data?.sourceName ??
                                              "لا يوجد",
                                          maxLines: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: ScreenUtilNew.height(16)),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: ScreenUtilNew.width(32)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ColumnDataWidgetProcessDetails(
                                          title: "المبلغ المتبقي",
                                          subTitle:
                                              "${data.data?.total ?? "0"}%",
                                          maxLines: 1,
                                        ),
                                        ColumnDataWidgetProcessDetails(
                                          title: "المبلغ",
                                          subTitle: data.data?.amount ?? '',
                                          maxLines: 1,
                                        ),
                                        ColumnDataWidgetProcessDetails(
                                          title: "مبلغ الزيادة",
                                          subTitle:
                                              data.data!.increaseAmount ?? "",
                                          maxLines: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: ScreenUtilNew.height(16)),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        right: ScreenUtilNew.width(32)),
                                    child: ColumnDataWidgetProcessDetails(
                                      title: "الملاحظات",
                                      subTitle: data.data?.notes ?? "لا يوجد",
                                      maxLines: 3,
                                    ),
                                  ),
                                  SizedBox(height: ScreenUtilNew.height(16)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtilNew.height(16),
                      ),
                      GestureDetector(
                        onTap: isLoading?null:() => confirmNewTransaction(widget.numberId),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: ScreenUtilNew.width(16)),
                          child: Container(
                            height: ScreenUtilNew.height(52),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.r),
                                color: AppColors.primaryColor),
                            child: Center(
                              child: isLoading
                                  ? const CircularProgressIndicator(
                                  color: Colors.white) // يظهر دائرة تحميل
                                  : Text('تأكيد العملية',style: GoogleFonts.cairo(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white
                              ),),
                            ),
                          ),
                        ),
                      ),
                      // ElevatedButtonCustomDataAndPasswordUpdated(onTap: isLoading?null:() => confirmNewTransaction(widget.numberId), title: isLoading?CircularProgressIndicator(color: Colors.white,):"",)
                      // Center(
                      //   child: Padding(
                      //     padding:EdgeInsets.symmetric(
                      //       horizontal: ScreenUtilNew.width(16)
                      //     ),
                      //     child: ElevatedButton(
                      //       style: ElevatedButton.styleFrom(
                      //         minimumSize: Size(double.infinity, ScreenUtilNew.height(52)),
                      //         backgroundColor: AppColors.primaryColor,
                      //         shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(5.r)
                      //         )
                      //       ),
                      //       onPressed: isLoading
                      //           ? null
                      //           : () => confirmNewTransaction(widget.numberId),
                      //       // قم بتغيير 123 بالرقم المطلوب
                      //       child: isLoading
                      //           ? const CircularProgressIndicator(
                      //               color: Colors.white) // يظهر دائرة تحميل
                      //           : Text('تأكيد العملية',style: GoogleFonts.cairo(
                      //         fontSize: 16.sp,
                      //         fontWeight: FontWeight.w600,
                      //         color: Colors.white
                      //       ),),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                );
                //   Column(
                //   children: [
                //     Text('Status: ${data.status}'),
                //     Text('Message: ${data.message}'),
                //     data.data != null
                //         ? Column(
                //             children: [
                //               Text('Transaction Number: ${data.data!.number}'),
                //               Text('Amount: ${data.data!.amount}'),
                //               // إضافة المزيد من المعلومات حسب الحاجة
                //             ],
                //           )
                //         : Text('No transaction data available'),
                //   ],
                // );
              }
            },
          ),
        ],
      ),
    );
  }
}
