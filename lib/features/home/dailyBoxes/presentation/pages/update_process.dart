import 'package:exchange/core/utils/app_colors.dart';
import 'package:exchange/core/utils/context_extension.dart';
import 'package:exchange/core/utils/screen_util_new.dart';
import 'package:exchange/features/home/dailyBoxes/presentation/pages/details_box_screen.dart';
import 'package:exchange/features/home/dailyBoxes/presentation/widgets/drop_down_widget_text_field.dart';
import 'package:exchange/features/home/dailyBoxes/presentation/widgets/text_field_cusomized_box_screen_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_animation_transition/animations/rotate_animation_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';
import 'package:provider/provider.dart';

import '../../../../../core/utils/app_strings.dart';
import '../../../bankTransfers/presentation/widgets/widget_when_wating_data_drop_down_menu.dart';
import '../../../profile/presentation/widgets/elevated_button_custom_data_and_password_updated.dart';
import '../../data/models/get_sources_controller.dart';
import '../../data/models/setting_model.dart';
import '../../data/models/show_transaction_model.dart';
import '../../domain/use_cases/get_sources.dart';
import '../../domain/use_cases/update_controller.dart';
import '../manager/providers/commision_controller_in_update_screen_provider.dart';
import '../manager/providers/is_loading_in_update_screen.dart';
import '../manager/providers/name_service_controller.dart';
import '../manager/providers/types_operation.dart';
import '../widgets/drop_down_select_source.dart';

class UpdateProcess extends StatefulWidget {
  int idBox;
  String boxName;
  String numberProcess;
  String serviceName;
  int sourceId;
  String commission;
  String amount;
  String increaseAmount;
  String total;
  String notes;
  int id;
  String typeName;
  int typeId;

  UpdateProcess(
      {super.key,
      required this.numberProcess,
      required this.sourceId,
      required this.commission,
      required this.amount,
      required this.increaseAmount,
      required this.total,
      required this.notes,
      required this.idBox,
      required this.serviceName,
      required this.id,
      required this.typeName,
      required this.typeId,
      required this.boxName});

  @override
  State<UpdateProcess> createState() => _UpdateProcessState();
}

class _UpdateProcessState extends State<UpdateProcess> {
  // Future<void> _fetchSettingsData() async {
  //   try {
  //     List<SettingData> settings = await _settingController.fetchSettings();
  //     final commissionSetting = settings.firstWhere(
  //           (setting) => setting.key == 'commission_limit',
  //       orElse: () => SettingData(key: 'commission_limit', value: '0'),
  //     );
  //     setState(() {
  //       commissionLimit = commissionSetting.value!;
  //     });
  //   } catch (e) {
  //     context.showSnackBar(message: "$e", erorr: true);
  //   }
  // }
  late TextEditingController numberProcessTextEditingController;
  late TextEditingController percentTextEditingController;
  late TextEditingController amountMoneyTextEditingController;
  late TextEditingController sumAmountMoneyTextEditingController;
  late TextEditingController amountAfterCalculateTextEditingController;
  late TextEditingController notesTextEditingController;
  int typeId1 = 0;
  bool isLoading = false;
  int sourceId1=0;
  int commissionId1=0;
  int serviceId1=0;



  late String nameService1;
  List<TypeOperation> typesOperation = [];

  @override
  void initState() {
    // TODO: implement initState
    nameService1 = widget.serviceName;
    numberProcessTextEditingController = TextEditingController();
    percentTextEditingController = TextEditingController();
    numberProcessTextEditingController = TextEditingController();
    amountMoneyTextEditingController = TextEditingController();
    sumAmountMoneyTextEditingController = TextEditingController();
    amountAfterCalculateTextEditingController = TextEditingController();
    notesTextEditingController = TextEditingController();
    percentTextEditingController.text = widget.commission;
    Provider.of<TypesOperationProvider>(context, listen: false)
        .changeTypesOperation = [
      TypeOperation(id: "${widget.typeId}", name: widget.typeName)
    ];
    amountMoneyTextEditingController.text=widget.amount;
    sumAmountMoneyTextEditingController.text=widget.increaseAmount;
    amountAfterCalculateTextEditingController.text=widget.total;
    super.initState();
  }
  void _updateResult(String valueAmount, String valueSum, String valuePercent) {
    double? amountBefore = double.tryParse(valueAmount);
    double? sumAmount = double.tryParse(valueSum);
    double? percent = double.tryParse(valuePercent);

    if (amountBefore != null && sumAmount != null && percent != null) {
      double discountedAmount = amountBefore - (amountBefore * percent / 100);
      double after = discountedAmount + sumAmount;

      amountAfterCalculateTextEditingController.text = after.toString();
      // print("Amount After: $after");
    } else if (percentTextEditingController.text.isEmpty &&
        amountBefore != null &&
        sumAmount != null) {
      double after = sumAmount + amountBefore;
      amountAfterCalculateTextEditingController.text = after.toString();
    } else {
      amountAfterCalculateTextEditingController.text = '';
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    numberProcessTextEditingController.dispose();
    percentTextEditingController.dispose();
    numberProcessTextEditingController.dispose();
    amountMoneyTextEditingController.dispose();
    amountAfterCalculateTextEditingController.dispose();
    sumAmountMoneyTextEditingController.dispose();
    notesTextEditingController.dispose();
    super.dispose();
  }

  void sendUpdateTransactionData(
      int idProcess,
    int sourceId,
    int commissionId,
    int serviceId,
    int type,
    double commission,
    double increaseAmount,
    double amount,
    String notes,
  ) async {
    UpdateController apiController = UpdateController();

    Provider.of<IsLoadingInUpdateScreen>(context,listen: false).newValueIsLoading=true;

    // استدعاء دالة التحديث
    DailyFundTransactionResponse? response = await apiController.updateProcess(
      idProcess: idProcess,
      context: context,
      sourceId: sourceId,
      commissionId: commissionId,
      serviceId: serviceId,
      type: type,
      commission: commission,
      commissionType: 2,
      // استخدم القيمة المناسبة لنوع العمولة
      increaseAmount: increaseAmount,
      amount: amount,
      notes: notes,
    );

    Provider.of<IsLoadingInUpdateScreen>(context,listen: false).newValueIsLoading=false;

    // هنا يمكنك التعامل مع الاستجابة
    if (response != null) {
      // نجاح التحديث
      print("Transaction updated successfully: $response");
      // يمكنك إضافة أي إجراء بعد التحديث الناجح، مثل عرض رسالة
    } else {
      // فشل التحديث
      print("Failed to update transaction");
      // يمكنك إضافة رسالة خطأ أو إجراء آخر هنا
    }
  }

  @override
  Widget build(BuildContext context) {
    final nameServiceControllerProvider =
        Provider.of<NameServiceController>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(PageAnimationTransition(page: DetailsBoxScreen(idBox: widget.idBox, nameBox: widget.boxName), pageAnimationType: RotationAnimationTransition()));
              },
              icon: const Icon(Icons.arrow_forward))
        ],
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          AppStrings.updateProcess1,
          style: GoogleFonts.cairo(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(right: ScreenUtilNew.width(16)),
              child: Align(
                alignment: Alignment.topRight,
                child: Text(
                  AppStrings.updateProcess2,
                  style: GoogleFonts.cairo(
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: ScreenUtilNew.height(8),
            ),
            GestureDetector(
              onTap: () {
                context.showSnackBar(
                    message: "لا يمكن تغيير رقم العملية", erorr: true);
              },
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: ScreenUtilNew.width(16)),
                child: Container(
                  height: ScreenUtilNew.height(52),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: const Color(0XFFEDEDED),
                      borderRadius: BorderRadius.circular(5.r)),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: ScreenUtilNew.width(8)),
                      child: Text(
                        "${widget.id}",
                        style: GoogleFonts.cairo(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: ScreenUtilNew.height(8),
            ),

            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: ScreenUtilNew.width(16)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Consumer<NameServiceController>(
                      builder: (context, provider, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "إسم الخدمة",
                          style: GoogleFonts.cairo(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                        ),
                        SizedBox(height: ScreenUtilNew.height(8)),
                        GestureDetector(
                          onTap: () {
                            context.showSnackBar(
                                message: "لا يمكن تغيير إسم الخدمة",
                                erorr: true);
                          },
                          child: Container(
                            height: ScreenUtilNew.height(52),
                            width: ScreenUtilNew.width(160),
                            decoration: BoxDecoration(
                                color: AppColors.primaryColor.withOpacity(0.08),
                                borderRadius: BorderRadius.circular(5.r)),
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: ScreenUtilNew.width(8)),
                                  child: const Icon(
                                    Icons.keyboard_arrow_down,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                const Expanded(child: SizedBox()),
                                Text(
                                  nameServiceControllerProvider.nameService,
                                  style: GoogleFonts.cairo(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                SizedBox(
                                  width: ScreenUtilNew.width(8),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                  FutureBuilder(
                      future: ApiControllerSourcesBox().fetchData(widget.idBox),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return WidgetWhenWatingDataDropDownMenu(
                              textTitle: "المصدر أو المستفيد",
                              width: ScreenUtilNew.width(160));
                        } else if (snapshot.hasError) {
                          // في حالة حدوث خطأ
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          // إذا لم توجد بيانات
                          return WidgetWhenWatingDataDropDownMenu(
                            width: ScreenUtilNew.width(160),
                            textTitle: "المصدر أو المستفيد",
                          );
                        } else {
                          List<DataSources> options = snapshot.data!;
                          return SizedBox(
                            width: ScreenUtilNew.width(160),
                            child: DropDownSelectSource(
                              options: options,
                              textTitle: "المصدر أو المستفيد",
                              selectedValueString: "",
                              onChanged: (selectedAccount) {
                                _updateResult(
                                    amountMoneyTextEditingController.text,
                                    sumAmountMoneyTextEditingController.text,
                                    percentTextEditingController.text);
                                print(
                                    "Commission${selectedAccount!.commissionValue}");
                                percentTextEditingController.text =
                                    selectedAccount.commissionValue == ""
                                        ? "0.00"
                                        : selectedAccount.commissionValue!;
                                Provider.of<NameServiceController>(context,
                                            listen: false)
                                        .nameServiceNew =
                                    (selectedAccount.serviceName == ""
                                        ? "لا يوجد"
                                        : selectedAccount.serviceName)!;
                                _updateResult(
                                    amountMoneyTextEditingController.text,
                                    sumAmountMoneyTextEditingController.text,
                                    percentTextEditingController.text);
                                Provider.of<TypesOperationProvider>(context,
                                            listen: false)
                                        .changeTypesOperation =
                                    selectedAccount.typeOperation!;
                                Provider.of<CommissionControllerInUpdateScreenProvider>(
                                            context,
                                            listen: false)
                                        .newCommission =
                                    percentTextEditingController.text;
                                sourceId1=selectedAccount.accountId!;
                                commissionId1=selectedAccount.commissionId!;
                                serviceId1=selectedAccount.serviceId!;
                                print("sourceId${sourceId1}");
                                print("sourceName${selectedAccount.serviceName}");
                                // int typeId1 = 0;
                                // bool isLoading = false;
                                // int sourceId1=0;
                                // int commissionId1=0;
                                // int serviceId1=0;
                                _updateResult(
                                    amountMoneyTextEditingController.text,
                                    sumAmountMoneyTextEditingController.text,
                                    percentTextEditingController.text);
                              },
                              selectDefaultValue: widget.sourceId,
                            ),
                          );
                        }
                      }),
                ],
              ),
            ),

            SizedBox(
              height: ScreenUtilNew.height(8),
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: ScreenUtilNew.width(16)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        AppStrings.updateProcess6,
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
                        hintText: "0.0",
                        iconData: Icons.percent_rounded,
                        textEditingController: amountMoneyTextEditingController,
                        textFiledDiscount: false,
                        width: ScreenUtilNew.width(160),
                        minLines: 1,
                        maxLines: 2,
                        onChanged: (value) {
                          _updateResult(
                              amountMoneyTextEditingController.text,
                              sumAmountMoneyTextEditingController.text,
                              percentTextEditingController.text);
                        },
                        enabled: true,
                        filledColor: AppColors.primaryColor.withOpacity(0.08),
                        styleHintText: GoogleFonts.cairo(
                          fontWeight: FontWeight.w400,
                          color: AppColors.primaryColor,
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
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
                        hintText: "0.0",
                        iconData: Icons.percent_rounded,
                        textEditingController: percentTextEditingController,
                        textFiledDiscount: true,
                        width: ScreenUtilNew.width(160),
                        minLines: 1,
                        maxLines: 2,
                        enabled: true,
                        filledColor: AppColors.primaryColor.withOpacity(0.08),
                        styleHintText: GoogleFonts.cairo(
                          fontWeight: FontWeight.w400,
                          color: AppColors.primaryColor,
                          fontSize: 16.sp,
                        ),
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
              padding:
                  EdgeInsets.symmetric(horizontal: ScreenUtilNew.width(16)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        AppStrings.updateProcess8,
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
                        hintText: "0.00",
                        iconData: Icons.percent_rounded,
                        textEditingController:
                            amountAfterCalculateTextEditingController,
                        textFiledDiscount: false,
                        width: ScreenUtilNew.width(160),
                        minLines: 1,
                        maxLines: 2,
                        enabled: false,
                        onChanged: (value) {
                          _updateResult(
                              amountMoneyTextEditingController.text,
                              sumAmountMoneyTextEditingController.text,
                              percentTextEditingController.text);
                        },
                        filledColor: AppColors.secondaryColor,
                        styleHintText: GoogleFonts.cairo(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 16.sp,
                        ),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        AppStrings.updateProcess7,
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
                        hintText: "0.00",
                        iconData: Icons.percent_rounded,
                        textEditingController:
                            sumAmountMoneyTextEditingController,
                        textFiledDiscount: false,
                        onChanged: (value) {
                          _updateResult(
                              amountMoneyTextEditingController.text,
                              sumAmountMoneyTextEditingController.text,
                              percentTextEditingController.text);
                        },
                        width: ScreenUtilNew.width(160),
                        minLines: 1,
                        maxLines: 2,
                        enabled: true,
                        filledColor: AppColors.primaryColor.withOpacity(0.08),
                        styleHintText: GoogleFonts.cairo(
                          fontWeight: FontWeight.w400,
                          color: AppColors.primaryColor,
                          fontSize: 16.sp,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: ScreenUtilNew.height(8),
            ),
            Padding(
              padding: EdgeInsets.only(right: ScreenUtilNew.width(16)),
              child: Align(
                alignment: Alignment.topRight,
                child: Text(
                  AppStrings.updateProcess9,
                  style: GoogleFonts.cairo(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            widget.typeId != 4
                ? Consumer<TypesOperationProvider>(
                    builder: (context, provider, child) {
                      return SizedBox(
                        height: provider.typesOperation.length *
                            ScreenUtilNew.height(40),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: ScreenUtilNew.width(16)),
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: provider.typesOperation.length,
                            itemBuilder: (context, index) {
                              final typeOperation =
                                  provider.typesOperation[index];
                              return Directionality(
                                textDirection: TextDirection.rtl,
                                child: RadioListTile<String>(
                                  contentPadding: EdgeInsets.zero,
                                  activeColor: AppColors.primaryColor,
                                  title: Text(
                                    typeOperation.name!,
                                    style:
                                        GoogleFonts.cairo(color: Colors.black),
                                  ),
                                  value: typeOperation.id!,
                                  groupValue: provider.selectedId,
                                  onChanged: (value) {
                                    // typeId=va;
                                    typeId1 =
                                        int.tryParse("${typeOperation.id}")!;
                                    // typeId = int.tryParse("${typeOperation.id}")!;
                                    if (typeOperation.id == "2" ||
                                        typeOperation.id == "3") {
                                      percentTextEditingController.text = "0.0";
                                      _updateResult(
                                          amountMoneyTextEditingController.text,
                                          sumAmountMoneyTextEditingController
                                              .text,
                                          percentTextEditingController.text);
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                        provider.changeSelectedId(value!);
                                      });
                                    } else {
                                      percentTextEditingController
                                          .text = Provider.of<
                                                  CommissionControllerInUpdateScreenProvider>(
                                              context,
                                              listen: false)
                                          .commission;
                                      _updateResult(
                                          amountMoneyTextEditingController.text,
                                          sumAmountMoneyTextEditingController
                                              .text,
                                          percentTextEditingController.text);
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                        provider.changeSelectedId(value!);
                                      });
                                    }

                                    // print(provider.selectedId);
                                  },
                                  visualDensity: VisualDensity
                                      .compact, // تقليل المسافات العمودية
                                ),
                              );
                            },
                            addAutomaticKeepAlives: true,
                          ),
                        ),
                      );
                    },
                  )
                : Padding(
              padding: EdgeInsets.only(right: ScreenUtilNew.width(16)),
                  child: Align(
                                alignment: Alignment.topRight,
                    child: Text(
                        "عملية غير مرحلة يمكنك تأكيدها ومن ثم تغيير النوع",
                        style: GoogleFonts.cairo(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.black.withOpacity(0.4),
                        ),
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.right,
                      ),
                  ),
                ),
            SizedBox(
              height: ScreenUtilNew.height(8),
            ),
            Padding(
              padding: EdgeInsets.only(right: ScreenUtilNew.width(16)),
              child: Align(
                alignment: Alignment.topRight,
                child: Text(
                  AppStrings.updateProcess10,
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
                padding:
                    EdgeInsets.symmetric(horizontal: ScreenUtilNew.width(16)),
                child: TextFieldCusomizedBoxScreenWidget(
                  textInputType: TextInputType.text,
                  hintText: "قم بكتابة ملاحظاتك....",
                  iconData: Icons.percent_rounded,
                  textEditingController: notesTextEditingController,
                  textFiledDiscount: false,
                  width: double.infinity,
                  minLines: 3,
                  maxLines: 4,
                  enabled: true,
                  filledColor: AppColors.primaryColor.withOpacity(0.08),
                  styleHintText: GoogleFonts.cairo(
                    fontWeight: FontWeight.w400,
                    color: AppColors.primaryColor,
                    fontSize: 16.sp,
                  ),
                )),
            SizedBox(
              height: ScreenUtilNew.height(32),
            ),
            Consumer<IsLoadingInUpdateScreen>(builder: (context,provider,child){
              return provider.isLoading
                  ? const CircularProgressIndicator(
                backgroundColor: AppColors.secondaryColor,
                color: AppColors.primaryColor,
              )
                  : ElevatedButtonCustomDataAndPasswordUpdated(
                  onTap: isLoading
                      ? null
                      : () async {
                    double increase2 = double.tryParse(
                        sumAmountMoneyTextEditingController.text) ??
                        0;
                    double amount2 =
                        double.tryParse(amountMoneyTextEditingController.text) ?? 0;
                    double commisstion2 = 0;
                    double commisstion3 = 0;
                    if (typeId1 == 3 || typeId1 == 2) {
                      commisstion2 = 0;
                    } else {
                      commisstion2 = double.tryParse(
                          percentTextEditingController.text) ??
                          0;
                      commisstion3 = (commisstion2 / 100) * amount2;
                    }
                    print("Type Id:$typeId1");
                    sendUpdateTransactionData(
                        widget.id,
                        sourceId1,
                        commissionId1,
                        serviceId1,
                        typeId1,
                        commisstion3,
                        increase2,
                        amount2,
                        notesTextEditingController.text
                    );
                    Future.delayed(Duration(milliseconds: 1300),(){
                      Navigator.of(context).push(PageAnimationTransition(page: DetailsBoxScreen(idBox: widget.idBox, nameBox: widget.boxName), pageAnimationType: RotationAnimationTransition()));
                    });
                  },
                  title: "تعديل البيانات");
                }),
            SizedBox(
              height: ScreenUtilNew.height(16),
            ),
          ],
        ),
      ),
    );
  }
}
