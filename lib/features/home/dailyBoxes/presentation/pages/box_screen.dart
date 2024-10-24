import 'package:exchange/core/utils/assets_manger.dart';
import 'package:exchange/core/utils/context_extension.dart';
import 'package:exchange/core/utils/screen_util_new.dart';
import 'package:exchange/features/home/dailyBoxes/data/models/box.dart';
import 'package:exchange/features/home/dailyBoxes/domain/use_cases/box_controller.dart';
import 'package:exchange/features/home/dailyBoxes/presentation/manager/providers/controller_selected_sourse.dart';
import 'package:exchange/features/home/dailyBoxes/presentation/widgets/box_widget.dart';
import 'package:exchange/features/home/dailyBoxes/presentation/widgets/container_scan_qr.dart';
import 'package:exchange/features/home/profile/presentation/widgets/elevated_button_custom_data_and_password_updated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../config/routes/app_routes.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../data/models/get_sources_controller.dart';
import '../../domain/use_cases/get_sources.dart';
import '../../domain/use_cases/get_sourse_one.dart';
import '../../domain/use_cases/transaction_controller_store.dart';
import '../widgets/drop_down_select_source.dart';
import '../widgets/drop_down_widget_text_field.dart';
import '../widgets/text_field_cusomized_box_screen_widget.dart';

class BoxScreen extends StatefulWidget {
  int idBox;
  String nameBox;

  BoxScreen({super.key, required this.idBox, required this.nameBox});

  @override
  State<BoxScreen> createState() => _BoxScreenState();
}

class _BoxScreenState extends State<BoxScreen> {
  PageController pageController = PageController(
    initialPage: 0,
  );
  int idBoxSelected = 0;
  int sourceId = 0;
  String sourceName = "";
  int commissionId = 0;
  int serviceId = 0;
  String typeTransication = "";
  int typeId = 0;
  List<TypeOperation> typesTransaction = [
    TypeOperation(id: "1", name: "بنكي"),
  ];
  int commission = 0;
  int commissionType = 0;
  double increaseAmount = 0;
  double amount = 0;
  String notes = "";
  String selectedSours = "";
  String nameServices = "";
  String commissionValue = "";
  int idSelectedSource = 16;
  String serviceName = "لا يوجد";

  // // دالة لحساب النتيجة
  // void _updateResult(String valueAmount, String valueSum, String valuePercent) {
  //   // تحويل القيم من النصوص إلى double
  //   double? amountBefore = double.tryParse(valueAmount);
  //   double? sumAmount = double.tryParse(valueSum);
  //   double? percent = double.tryParse(valuePercent);
  //
  //   // التحقق من أن القيم ليست null وأن النسبة المئوية صالحة
  //   if (amountBefore != null && sumAmount != null && percent != null) {
  //     // حساب القيمة بعد تطبيق النسبة المئوية
  //     double after = amountBefore + (amountBefore * percent / 100) + sumAmount;
  //
  //     // تعيين النتيجة النهائية في `amountAfterCalculateTextEditingController`
  //     amountAfterCalculateTextEditingController.text = after.toString();
  //     print("Amount After: $after");
  //   } else {
  //     // إذا كانت المدخلات غير صالحة، يمكن تعيين قيمة افتراضية أو ترك الحقل فارغًا
  //     amountAfterCalculateTextEditingController.text = '';
  //   }
  // }
// دالة لحساب النتيجة
  void _updateResult(String valueAmount, String valueSum, String valuePercent) {
    // تحويل القيم من النصوص إلى double
    double? amountBefore = double.tryParse(valueAmount);
    double? sumAmount = double.tryParse(valueSum);
    double? percent = double.tryParse(valuePercent);

    // التحقق من أن القيم ليست null وأن النسبة المئوية صالحة
    if (amountBefore != null && sumAmount != null && percent != null) {
      // حساب القيمة بعد خصم النسبة المئوية
      double discountedAmount = amountBefore - (amountBefore * percent / 100);

      // إضافة قيمة sum
      double after = discountedAmount + sumAmount;

      // تعيين النتيجة النهائية في `amountAfterCalculateTextEditingController`
      amountAfterCalculateTextEditingController.text = after.toString();
      print("Amount After: $after");
    } else
    if (percentTextEditingController.text.isEmpty && amountBefore != null &&
        sumAmount != null) {
      double after = sumAmount + amountBefore;
      amountAfterCalculateTextEditingController.text = after.toString();
      // إذا كانت المدخلات غير صالحة، يمكن تعيين قيمة افتراضية أو ترك الحقل فارغًا
    } else {
      amountAfterCalculateTextEditingController.text = '';
    }
  }


  void _onSourceChanged(String newValue) {
    setState(() {
      selectedSours = newValue; // تحديث اللغة المختارة
    });
  }

  void _onNameServiceChanged(String newValue) {
    setState(() {
      nameServices = newValue; // تحديث اللغة المختارة
    });
  }

  String valueRadioButton = "إيداع";

  List detailsBox = [
    "أجمالي الصندوق",
    "إجمالي المتبقي",
    "إجمالي الإيداع",
    "إجمالي السحب"
  ];
  List<String> typesProcess = ["إيداع", "سحب"];
  late TextEditingController numberProcessTextEditingController;
  late TextEditingController percentTextEditingController;
  late TextEditingController amountMoneyTextEditingController;
  late TextEditingController sumAmountMoneyTextEditingController;
  late TextEditingController amountAfterCalculateTextEditingController;
  late TextEditingController notesTextEditingController;

  @override
  void initState() {
    // TODO: implement initState
    numberProcessTextEditingController = TextEditingController();
    percentTextEditingController = TextEditingController();
    numberProcessTextEditingController = TextEditingController();
    amountMoneyTextEditingController = TextEditingController();
    sumAmountMoneyTextEditingController = TextEditingController();
    amountAfterCalculateTextEditingController = TextEditingController();
    notesTextEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    numberProcessTextEditingController.dispose();
    percentTextEditingController.dispose();
    numberProcessTextEditingController.dispose();
    amountMoneyTextEditingController.dispose();
    amountAfterCalculateTextEditingController.dispose();
    notesTextEditingController.dispose();
    sumAmountMoneyTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double amountAfterCalculate = 0;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: ScreenUtilNew.height(48),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.update,
                          color: Colors.red,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.detailsBoxScreen);
                        },
                        icon: const Icon(
                          Icons.filter_list_rounded,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                  const Expanded(child: SizedBox()),
                  Text(
                    widget.nameBox,
                    style: GoogleFonts.cairo(
                      fontSize: 16.sp,
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Expanded(child: SizedBox()),
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
              ),
              SizedBox(height: ScreenUtilNew.height(16)),
              FutureBuilder<DataBox?>(
                future: ApiBoxController().fetchData(widget.idBox),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SizedBox(
                      height: ScreenUtilNew.height(140),
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                          backgroundColor: AppColors.secondaryColor,
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    DataBox? data = snapshot.data;
                    List<String?> dataBox = [
                      (data?.balance ?? '0'),
                      (data?.reminder ?? '0'),
                      (data?.transactionSumDeposit ?? '0'),
                      (data?.transactionSumWithdraw ?? '0')
                    ];
                    if (data == null) {
                      return SizedBox(
                        height: 200, // Set an appropriate height
                        child: Center(
                          child: Text(
                            'لا يوجد تفاصيل لعرضها حاليا',
                            style: GoogleFonts.cairo(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                              color: AppColors.secondaryColor,
                            ),
                          ),
                        ),
                      );
                    }
                    return SizedBox(
                      height: ScreenUtilNew.height(140),
                      child: PageView.builder(
                        controller: pageController,
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return BoxWidget(
                            nameBoxContain: detailsBox[index],
                            balance: dataBox[index]!,
                          );
                        },
                      ),
                    );
                  } else {
                    return const SizedBox(
                      height: 200,
                      // Set a suitable height for the widget
                      child: Center(child: Text('لا يوجد بيانات لعرضها')),
                    );
                  }
                },
              ),
              SizedBox(
                height: ScreenUtilNew.height(8),
              ),
              SmoothPageIndicator(
                controller: pageController,
                count: 4,
                effect: ExpandingDotsEffect(
                  activeDotColor: AppColors.primaryColor,
                  dotHeight: ScreenUtilNew.height(8),
                  dotWidth: ScreenUtilNew.width(8),
                ),
                onDotClicked: (index) {},
              ),
              Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: ScreenUtilNew.width(16)),
                      child: Text(
                        AppStrings.boxScreen1,
                        style: GoogleFonts.cairo(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtilNew.height(8),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtilNew.width(16)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ContainerScanQr(onTap: () {}),
                        TextFieldCusomizedBoxScreenWidget(
                          textInputType: TextInputType.number,
                          hintText: AppStrings.boxScreen2,
                          iconData: Icons.discount,
                          textEditingController:
                          numberProcessTextEditingController,
                          textFiledDiscount: false,
                          width: ScreenUtilNew.width(283),
                          minLines: 1,
                          maxLines: 3,
                          enabled: true,
                          filledColor: AppColors.primaryColor.withOpacity(0.08),
                          styleHintText: GoogleFonts.cairo(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.primaryColor),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtilNew.width(16)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.done,
                            color: Colors.black,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            numberProcessTextEditingController.clear();
                          },
                          icon: const Icon(
                            Icons.refresh,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                  FutureBuilder<List<DataSources>?>(
                      future: ApiControllerSourcesBox().fetchData(widget.idBox),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator(
                            color: AppColors.primaryColor,
                            backgroundColor: AppColors.secondaryColor,
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (snapshot.hasData) {
                          List<DataSources> dataTransaction = snapshot.data!;
                          Set<String> dataSours =
                          {}; // استخدام Set لضمان عدم تكرار القيم
                          for (int i = 0; i < dataTransaction.length; i++) {
                            dataSours.add(dataTransaction[i].name ?? 'No Name');
                          }
                          List<String> dataSoursList = dataSours.toList();
                          return Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: ScreenUtilNew.width(16)),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    DropDownWidgetTextField(
                                      textTitle: AppStrings.boxScreen4,
                                      options: [
                                        serviceName == ""
                                            ? "لا يوجد"
                                            : serviceName
                                      ],
                                      onChanged: _onNameServiceChanged,
                                    ),
                                    DropDownSelectSource(
                                      textTitle: AppStrings.boxScreen3,
                                      selectedValueString: sourceName,
                                      options: dataTransaction,
                                      onChanged: (selectedSource) {
                                        if (selectedSource != null) {
                                          setState(() {
                                            sourceName = selectedSource.name!;
                                            idBoxSelected = widget.idBox;
                                            idSelectedSource =
                                            selectedSource.id!;
                                            sourceId = selectedSource.id!;
                                            serviceName =
                                            selectedSource.serviceName!;
                                            commissionId =
                                            selectedSource.commissionId!;
                                            serviceId =
                                            selectedSource.serviceId!;
                                            typesTransaction =
                                            selectedSource.typeOperation!;
                                            commissionType =
                                            selectedSource.commissionType!;
                                            percentTextEditingController.text =
                                            selectedSource.commissionValue
                                                ?.isNotEmpty == true
                                                ? selectedSource
                                                .commissionValue!
                                                : "0";
                                            _updateResult(
                                                amountMoneyTextEditingController
                                                    .text,
                                                sumAmountMoneyTextEditingController
                                                    .text,
                                                percentTextEditingController
                                                    .text);
                                          });
                                        }
                                      },
                                    ),
//                                     FutureBuilder<List<DataSources>?>(
//                                         future: ApiControllerSourcesBox()
//                                             .fetchData(widget.idBox),
//                                         builder: (context, snapshot) {
//                                           if (snapshot.connectionState ==
//                                               ConnectionState.waiting) {
//                                             return DropDownWidgetTextField(
//                                               textTitle: AppStrings.boxScreen3,
//                                               options: [""],
//                                               onChanged: _onSourceChanged,
//                                             );
//                                           } else if (snapshot.hasError) {
//                                             return Center(
//                                                 child: Text(
//                                                     'Error: ${snapshot.error}'));
//                                           } else if (snapshot.hasData) {
//                                             List<DataSources> dataTransaction =
//                                                 snapshot.data!;
//                                             Set<String> dataSours =
//                                                 {}; // استخدام Set لضمان عدم تكرار القيم
//                                             for (int i = 0;
//                                                 i < dataTransaction.length;
//                                                 i++) {
//                                               dataSours.add(
//                                                   dataTransaction[i].name ??
//                                                       'No Name');
//                                             }
//                                             List<String> dataSoursList =
//                                                 dataSours.toList();
//                                             return DropDownSelectSource(
//                                               textTitle:
//                                                   AppStrings.boxScreen3,
//                                               options: dataTransaction,
//                                               onChanged: (selectedSource) {
//                                                 if (selectedSource !=
//                                                     null) {
//                                                   print(
//                                                       "تم اختيار: ${selectedSource.name} مع ID: ${selectedSource.id}");
//                                                   idSelectedSource =
//                                                       selectedSource.id!;
//                                                   setState(() {
//                                                     idBoxSelected =
//                                                         widget.idBox;
//                                                     sourceId =
//                                                         selectedSource.id!;
//                                                     commissionId =
//                                                         selectedSource
//                                                             .commissionId!;
//                                                     serviceId =
//                                                         selectedSource
//                                                             .serviceId!;
//                                                     // typeTransication="";
//                                                     typesTransaction =
//                                                         selectedSource
//                                                             .typeOperation!;
//                                                     commissionType =
//                                                         selectedSource
//                                                             .commissionType!;
//                                                     serviceName =
//                                                         selectedSource
//                                                             .serviceName!;
//                                                   });
//                                                 }
//                                               },
//                                             );
//                                           } else {
//                                             return DropDownWidgetTextField(
//                                               textTitle: AppStrings.boxScreen3,
//                                               options: [""],
// // خيار افتراضي في حالة عدم وجود بيانات
//                                               onChanged: _onSourceChanged,
//                                             );
//                                           }
//                                         }),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtilNew.height(8),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: ScreenUtilNew.width(16)),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          AppStrings.boxScreen6,
                                          style: GoogleFonts.cairo(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(
                                          height: ScreenUtilNew.height(8),
                                        ),
                                        TextFieldCusomizedBoxScreenWidget(
                                          textInputType: TextInputType.number,
                                          hintText: "0",
                                          iconData: Icons.percent_rounded,
                                          textEditingController:
                                          amountMoneyTextEditingController,
                                          textFiledDiscount: false,
                                          width: ScreenUtilNew.width(160),
                                          minLines: 1,
                                          maxLines: 2,
                                          enabled: true,
                                          onChanged: (value) {
                                            _updateResult(
                                                amountMoneyTextEditingController
                                                    .text,
                                                sumAmountMoneyTextEditingController
                                                    .text,
                                                percentTextEditingController
                                                    .text);
                                            // double.tryParse(value);
                                            // double valueNumber = double.tryParse(value) ?? 0.0;
                                            // double percentNumber = double.tryParse(percentTextEditingController.text) ?? 0.0;
                                            // if (valueNumber != null && percentNumber != null) {
                                            //   // تنفيذ العملية الحسابية
                                            //   double result = valueNumber - (valueNumber * percentNumber / 100);
                                            //   amountAfterCalculateTextEditingController.text = result.toString(); // تحويل النتيجة إلى نص وتعيينها
                                            // } else {
                                            //   amountAfterCalculateTextEditingController.text = 'Invalid input'; // في حالة الإدخال غير صالح
                                            // }
                                            //
                                            // print(double.tryParse(value));
                                          },
                                          filledColor: AppColors.primaryColor
                                              .withOpacity(0.08),
                                          styleHintText: GoogleFonts.cairo(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.primaryColor),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          AppStrings.boxScreen5,
                                          style: GoogleFonts.cairo(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(
                                          height: ScreenUtilNew.height(8),
                                        ),
                                        TextFieldCusomizedBoxScreenWidget(
                                          textInputType: TextInputType.number,
                                          hintText: percentTextEditingController
                                              .text,
                                          iconData: Icons.percent_rounded,
                                          textEditingController:
                                          percentTextEditingController,
                                          textFiledDiscount: true,
                                          width: ScreenUtilNew.width(160),
                                          minLines: 1,
                                          maxLines: 2,
                                          onChanged: (value) {
                                            print(value);
                                          },
                                          enabled: false,
                                          filledColor: AppColors.primaryColor
                                              .withOpacity(0.08),
                                          styleHintText: GoogleFonts.cairo(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.primaryColor),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtilNew.height(8),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: ScreenUtilNew.width(16)),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          AppStrings.boxScreen8,
                                          style: GoogleFonts.cairo(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(
                                          height: ScreenUtilNew.height(8),
                                        ),
                                        TextFieldCusomizedBoxScreenWidget(
                                          textInputType: TextInputType.number,
                                          hintText: "0",
                                          iconData: Icons.percent_rounded,
                                          textEditingController:
                                          amountAfterCalculateTextEditingController,
                                          textFiledDiscount: false,
                                          width: ScreenUtilNew.width(160),
                                          minLines: 1,
                                          maxLines: 2,
                                          enabled: false,
                                          filledColor: AppColors.secondaryColor,
                                          styleHintText: GoogleFonts.cairo(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          AppStrings.boxScreen7,
                                          style: GoogleFonts.cairo(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(
                                          height: ScreenUtilNew.height(8),
                                        ),
                                        TextFieldCusomizedBoxScreenWidget(
                                          textInputType: TextInputType.number,
                                          hintText: "0",
                                          iconData: Icons.percent_rounded,
                                          textEditingController:
                                          sumAmountMoneyTextEditingController,
                                          textFiledDiscount: false,
                                          width: ScreenUtilNew.width(160),
                                          minLines: 1,
                                          maxLines: 2,
                                          onChanged: (value) {
                                            _updateResult(
                                                amountMoneyTextEditingController
                                                    .text,
                                                sumAmountMoneyTextEditingController
                                                    .text,
                                                percentTextEditingController
                                                    .text);
                                            // double? amountAfter = double.tryParse(amountAfterCalculateTextEditingController.text);
                                            // double? sumAmount = double.tryParse(sumAmountMoneyTextEditingController.text);
                                            // print(sumAmount);
                                            // if (amountAfter != null && sumAmount != null&&sumAmount!=0) {
                                            //   // تنفيذ عملية الجمع
                                            //   double result = amountAfter + sumAmount;
                                            //   amountAfterCalculateTextEditingController.text = result.toString();
                                            // } else if(sumAmountMoneyTextEditingController.text.isEmpty){
                                            //   // التعامل مع الإدخال غير الصالح
                                            //   // amountAfterCalculateTextEditingController.text = 'Invalid input';
                                            // }
                                          },
                                          enabled: true,
                                          filledColor: AppColors.primaryColor
                                              .withOpacity(0.08),
                                          styleHintText: GoogleFonts.cairo(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.primaryColor),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtilNew.height(8),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    right: ScreenUtilNew.width(16)),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    AppStrings.boxScreen9,
                                    style: GoogleFonts.cairo(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: typesTransaction.length *
                                    ScreenUtilNew.height(40),
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: typesTransaction.length,
                                  itemBuilder: (context, index) {
                                    return Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: RadioListTile<String>(
                                        activeColor: AppColors.primaryColor,
                                        title: Text(
                                          typesTransaction[index].name!,
                                          style: GoogleFonts.cairo(
                                            fontWeight: FontWeight.w600,
                                            color: typesTransaction[index]
                                                .name ==
                                                valueRadioButton
                                                ? AppColors.primaryColor
                                                : Colors.black,
                                            fontSize: 14.sp,
                                          ),
                                        ),
                                        visualDensity: const VisualDensity(
                                            vertical:
                                            VisualDensity.minimumDensity,
                                            horizontal:
                                            VisualDensity.minimumDensity),
                                        value: typeTransication,
                                        groupValue: typesTransaction[index]
                                            .name!,
                                        onChanged: (value) {
                                          setState(
                                                () {
                                              typeTransication =
                                              typesTransaction[index].name!;
                                              typeId = typesTransaction[index]
                                                  .id! as int;
                                              print(typeId);
                                            },
                                          );
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    right: ScreenUtilNew.width(16)),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    AppStrings.boxScreen10,
                                    style: GoogleFonts.cairo(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtilNew.height(8),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: ScreenUtilNew.width(16)),
                                child: TextFieldCusomizedBoxScreenWidget(
                                  textInputType: TextInputType.text,
                                  hintText: "قم بكتابة الملاحظات ",
                                  iconData: Icons.percent_rounded,
                                  textEditingController:
                                  notesTextEditingController,
                                  textFiledDiscount: false,
                                  width: double.infinity,
                                  minLines: 3,
                                  maxLines: 5,
                                  enabled: true,
                                  filledColor:
                                  AppColors.primaryColor.withOpacity(0.08),
                                  styleHintText: GoogleFonts.cairo(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtilNew.height(24),
                              ),
                              ElevatedButtonCustomDataAndPasswordUpdated(
                                  onTap: () {
                                    // showDialog(
                                    //     context: context,
                                    //     builder: (context) =>
                                    //         CustomDialogWidget(
                                    //           dailyFundId: widget.idBox,
                                    //           sourceId: idSelectedSource,
                                    //           commissionId: commissionId,
                                    //           serviceId: serviceId,
                                    //           type: typeId,
                                    //           amount: amount,
                                    //           commissionValue
                                    //           :,
                                    //
                                    //         ));
                                  },
                                  title: "حفظ البيانات"),
                              SizedBox(
                                height: ScreenUtilNew.height(16),
                              ),
                            ],
                          );
                        } else {
                          return Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: ScreenUtilNew.width(16)),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    DropDownWidgetTextField(
                                      textTitle: AppStrings.boxScreen4,
                                      options: [""],
                                      onChanged: _onNameServiceChanged,
                                    ),
                                    DropDownWidgetTextField(
                                      textTitle: AppStrings.boxScreen3,
                                      options: [""],
                                      onChanged: _onSourceChanged,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtilNew.height(8),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: ScreenUtilNew.width(16)),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          AppStrings.boxScreen6,
                                          style: GoogleFonts.cairo(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(
                                          height: ScreenUtilNew.height(8),
                                        ),
                                        TextFieldCusomizedBoxScreenWidget(
                                          textInputType: TextInputType.number,
                                          hintText: "1200",
                                          iconData: Icons.percent_rounded,
                                          textEditingController:
                                          amountMoneyTextEditingController,
                                          textFiledDiscount: false,
                                          width: ScreenUtilNew.width(160),
                                          minLines: 1,
                                          maxLines: 2,
                                          enabled: true,
                                          filledColor: AppColors.primaryColor
                                              .withOpacity(0.08),
                                          styleHintText: GoogleFonts.cairo(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.primaryColor),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          AppStrings.boxScreen5,
                                          style: GoogleFonts.cairo(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(
                                          height: ScreenUtilNew.height(8),
                                        ),
                                        TextFieldCusomizedBoxScreenWidget(
                                          textInputType: TextInputType.number,
                                          hintText: "19",
                                          iconData: Icons.percent_rounded,
                                          textEditingController:
                                          percentTextEditingController,
                                          textFiledDiscount: true,
                                          width: ScreenUtilNew.width(160),
                                          minLines: 1,
                                          maxLines: 2,
                                          enabled: true,
                                          filledColor: AppColors.primaryColor
                                              .withOpacity(0.08),
                                          styleHintText: GoogleFonts.cairo(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.primaryColor),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtilNew.height(8),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: ScreenUtilNew.width(16)),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          AppStrings.boxScreen8,
                                          style: GoogleFonts.cairo(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(
                                          height: ScreenUtilNew.height(8),
                                        ),
                                        TextFieldCusomizedBoxScreenWidget(
                                          textInputType: TextInputType.number,
                                          hintText: "50",
                                          iconData: Icons.percent_rounded,
                                          textEditingController:
                                          amountAfterCalculateTextEditingController,
                                          textFiledDiscount: false,
                                          width: ScreenUtilNew.width(160),
                                          minLines: 1,
                                          maxLines: 2,
                                          enabled: false,
                                          filledColor: AppColors.secondaryColor,
                                          styleHintText: GoogleFonts.cairo(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          AppStrings.boxScreen7,
                                          style: GoogleFonts.cairo(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(
                                          height: ScreenUtilNew.height(8),
                                        ),
                                        TextFieldCusomizedBoxScreenWidget(
                                          textInputType: TextInputType.number,
                                          hintText: "50",
                                          iconData: Icons.percent_rounded,
                                          textEditingController:
                                          sumAmountMoneyTextEditingController,
                                          textFiledDiscount: false,
                                          width: ScreenUtilNew.width(160),
                                          minLines: 1,
                                          maxLines: 2,
                                          enabled: true,
                                          filledColor: AppColors.primaryColor
                                              .withOpacity(0.08),
                                          styleHintText: GoogleFonts.cairo(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.primaryColor),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtilNew.height(8),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    right: ScreenUtilNew.width(16)),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    AppStrings.boxScreen9,
                                    style: GoogleFonts.cairo(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtilNew.height(80),
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: typesProcess.length,
                                  itemBuilder: (context, index) {
                                    return Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: RadioListTile<String>(
                                        activeColor: AppColors.primaryColor,
// fillColor:
//     const WidgetStatePropertyAll(AppColors.primaryColor),
                                        title: Text(
                                          typesProcess[index],
                                          style: GoogleFonts.cairo(
                                            fontWeight: FontWeight.w600,
                                            color: typesProcess[index] ==
                                                valueRadioButton
                                                ? AppColors.primaryColor
                                                : Colors.black,
                                            fontSize: 14.sp,
                                          ),
                                        ),
                                        visualDensity: const VisualDensity(
                                            vertical:
                                            VisualDensity.minimumDensity,
                                            horizontal:
                                            VisualDensity.minimumDensity),
                                        value: typesProcess[index],
                                        groupValue: valueRadioButton,
                                        onChanged: (value) {
                                          setState(
                                                () {
                                              valueRadioButton =
                                              typesProcess[index];
                                            },
                                          );
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    right: ScreenUtilNew.width(16)),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    AppStrings.boxScreen10,
                                    style: GoogleFonts.cairo(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtilNew.height(8),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: ScreenUtilNew.width(16)),
                                child: TextFieldCusomizedBoxScreenWidget(
                                  textInputType: TextInputType.text,
                                  hintText: "قم بكتابة الملاحظات ",
                                  iconData: Icons.percent_rounded,
                                  textEditingController:
                                  notesTextEditingController,
                                  textFiledDiscount: false,
                                  width: double.infinity,
                                  minLines: 3,
                                  maxLines: 5,
                                  enabled: true,
                                  filledColor:
                                  AppColors.primaryColor.withOpacity(0.08),
                                  styleHintText: GoogleFonts.cairo(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtilNew.height(24),
                              ),
                              ElevatedButtonCustomDataAndPasswordUpdated(
                                  onTap: () {
                                    context.showSnackBar(
                                        message: "حاول مرة أخرى");
                                  },
                                  title: "حفظ البيانات"),
                              SizedBox(
                                height: ScreenUtilNew.height(16),
                              ),
                            ],
                          );
                        }
                      }),
                ],
              ),
            ],
          ),
        ));
  }
}

class CustomDialogWidget extends StatelessWidget {
  final int dailyFundId;
  final int sourceId;
  final int commissionId;
  final int serviceId;
  final int type;
  final int commission; // 1 for ratio, 2 for fixed
  final int commissionType;
  final double increaseAmount;
  final double amount; // Total amount for the transaction
  final String notes; // Notes for the transaction

  const CustomDialogWidget({super.key,
    required this.dailyFundId,
    required this.serviceId,
    required this.commissionId,
    required this.type,
    required this.commission,
    required this.commissionType,
    required this.increaseAmount,
    required this.amount,
    required this.sourceId,
    required this.notes});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      child: Container(
        height: ScreenUtilNew.height(195),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.r)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "تأكيد إتمام العملية",
              style: GoogleFonts.cairo(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 20.sp),
            ),
            Padding(
              padding:
              EdgeInsets.symmetric(horizontal: ScreenUtilNew.width(16)),
              child: Text(
                "هل تريد إتمام العملية بشكل كامل أو جعل العملية في قسم العمليات الغير مرحلة ",
                style: GoogleFonts.cairo(
                    color: const Color(0XFF8C9191),
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp),
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              height: ScreenUtilNew.height(16),
            ),
            Row(
              children: [
                SizedBox(
                  width: ScreenUtilNew.width(16),
                ),
                Expanded(
                  child: Container(
                    height: ScreenUtilNew.height(47),
                    // width: ScreenUtilNew.width(148),
                    decoration: BoxDecoration(
                      color: const Color(0XFFFFE2E2),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Center(
                      child: Text(
                        "عملية غير مرحلة",
                        style: GoogleFonts.cairo(
                          fontSize: 14.sp,
                          color: const Color(0XFFFF0000),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: ScreenUtilNew.width(8),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);

                      Future.delayed(const Duration(seconds: 2), () {
                        Navigator.pushNamed(
                            context, Routes.addTransactionNewScreen);
                      });
                      _settingModalBottomSheet(context);
                    },
                    child: Container(
                      height: ScreenUtilNew.height(47),
                      // width: ScreenUtilNew.width(148),
                      decoration: BoxDecoration(
                        color: AppColors.secondaryColor,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Center(
                        child: Text(
                          "تاكيد كامل",
                          style: GoogleFonts.cairo(
                            fontSize: 14.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: ScreenUtilNew.width(16),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50.r), topRight: Radius.circular(50.r)),
      ),
      builder: (BuildContext bc) {
        return SizedBox(
          // height: ScreenUtilNew.height(400),
          width: ScreenUtilNew.width(375),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: ScreenUtilNew.height(8)),
              Image.asset(
                AssetsManger.successImage,
                height: ScreenUtilNew.height(107),
                width: ScreenUtilNew.width(107),
                fit: BoxFit.contain,
              ),
              SizedBox(height: ScreenUtilNew.height(16)),
              Text(
                "لقد تم إتمام العملية بنجاح",
                style: GoogleFonts.cairo(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: ScreenUtilNew.height(8)),
              Padding(
                padding:
                EdgeInsets.symmetric(horizontal: ScreenUtilNew.width(40)),
                child: Text(
                  "لقد تم اضافة العملية انها متتمة بشكل كامل الى قائمة العمليات المتممة بشكل كامل ",
                  style: GoogleFonts.cairo(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0XFF9C9C9C)),
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                ),
              ),
              SizedBox(
                height: ScreenUtilNew.height(16),
              ),
            ],
          ),
        );
      },
    );
  }

  // void storeData(BuildContext context, int idType) async {
  //   // Your data to be sent in the POST request
  //   final response = await ApiControllerDailyFundTransaction().postData(
  //     dailyFundId: dailyFundId, // replace with actual data
  //     sourceId: sourceId, // replace with actual data
  //     commissionId: commissionId, // replace with actual data
  //     serviceId: serviceId, // replace with actual data
  //     type: idType.toString(), // replace with actual data
  //     commission: (idType == 2 || idType == 3) ? 0 : yourValueHere, // replace with actual value
  //     commissionType: commissionType, // replace with actual data, set this based on your logic
  //     increaseAmount: increaseAmount, // replace with actual data
  //     amount: amount, // replace with actual data
  //     notes: notes, // replace with actual data
  //   );
  //
  //   if (response != null && response.status == 200) {
  //     // Show success message or navigate to another screen
  //     _settingModalBottomSheet(context);
  //   } else {
  //     // Handle error
  //     context.showSnackBar(message: response!.message.toString());
  //   }
  // }

}

