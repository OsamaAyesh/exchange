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
import 'package:page_animation_transition/animations/bottom_to_top_faded_transition.dart';
import 'package:page_animation_transition/animations/bottom_to_top_transition.dart';
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
import '../../domain/use_cases/setting_controller.dart';
import '../../domain/use_cases/update_controller.dart';
import '../manager/providers/commision_controller_in_update_screen_provider.dart';
import '../manager/providers/enabled_text_fileds_or_not_provider.dart';
import '../manager/providers/fill_color_commision_controller_provider.dart';
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
  int? commissionid;
  String amount;
  String increaseAmount;
  String total;
  String notes;
  int id;
  String typeName;
  int typeId;

  UpdateProcess({
    super.key,
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
    required this.boxName,
    required this.commissionid,
  });

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
  final SettingController _settingController = SettingController();

  int typeId1 = 0;
  String commissionLimit = "17";
  bool isLoading = false;
  int sourceId1 = 0;
  String? commissionId1;
  String? serviceId1;

  late String nameService1;
  List<TypeOperation> typesOperation = [];

  @override
  void initState() {
    super.initState();
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
    amountMoneyTextEditingController.text = widget.amount;
    sumAmountMoneyTextEditingController.text = widget.increaseAmount;
    amountAfterCalculateTextEditingController.text = widget.total;
    notesTextEditingController.text = widget.notes;
    typeId1 = widget.typeId;
    sourceId1 = widget.sourceId;
    // fetchAndSetServiceIdByBox(widget.idBox,widget.serviceName);
    _initializeServiceId();
    commissionId1 = widget.commissionid == null ? "" : "${widget.commissionid}";
    print(commissionId1);
    double? testColor = double.tryParse(widget.commission);
    if (testColor == 0 || testColor == null) {
      Provider.of<FillColorCommissionControllerProvider>(context, listen: false)
          .newColorCommission = Color(0XFFDCD9D9);
      Provider.of<EnabledTextFiledsOrNotProvider>(context, listen: false)
          .newValue = false;
    } else {
      Provider.of<FillColorCommissionControllerProvider>(context, listen: false)
          .newColorCommission = AppColors.primaryColor.withOpacity(0.08);
      Provider.of<EnabledTextFiledsOrNotProvider>(context, listen: false)
          .newValue = true;
    }
    // Provider.of<EnabledTextFiledsOrNotProvider>(context,listen: false).newValue=false;
    // Provider.of<FillColorCommissionControllerProvider>(context,listen: false).newColorCommission=const Color(0XFFDCD9D9);
    _fetchSettingsData();
  }

  Future<void> _fetchSettingsData() async {
    try {
      List<SettingData> settings = await _settingController.fetchSettings();
      final commissionSetting = settings.firstWhere(
        (setting) => setting.key == 'commission_limit',
        orElse: () => SettingData(key: 'commission_limit', value: '0'),
      );
      setState(() {
        commissionLimit = commissionSetting.value!;
      });
    } catch (e) {
      context.showSnackBar(message: "$e", erorr: true);
    }
  }

  Future<String?> fetchAndSetServiceIdByBox(
      int idBox, String serviceName) async {
    // Create an instance of the API controller
    ApiControllerSourcesBox apiController = ApiControllerSourcesBox();

    List<DataSources>? sources = await apiController.fetchData(idBox);

    if (sources != null) {
      for (int i = 0; i < sources.length; i++) {
        if (sources[i].serviceName == serviceName) {
          return "${sources[i].serviceId}";
        }
      }
      return null;
      // DataSources? matchedSource = sources.firstWhere(
      //       (source) => source.serviceName == serviceName,
      //   orElse: () => null,
      // );

      // تعيين قيمة idService إلى serviceId1 إذا وجد تطابق
      // if (matchedSource != null) {
      //   int serviceId1 = matchedSource.idService;
      //   print('Service ID found: $serviceId1');
      //
      //   // قم باستخدام serviceId1 حسب الحاجة
      // } else {
      //   print('No matching service name found.');
      // }
    } else {
      return null;
    }
  }

  Future<void> _initializeServiceId() async {
    final fetchedServiceId =
        await fetchAndSetServiceIdByBox(widget.idBox, widget.serviceName);
    if (fetchedServiceId != null) {
      setState(() {
        serviceId1 = fetchedServiceId; // تحديث القيمة في حالة الـ State
      });
      print("${widget.serviceName}${serviceId1}");
    } else {
      serviceId1 = "";
      print('Failed to fetch service ID.');
    }
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
    String? commissionId,
    String? serviceId,
    int type,
    double commission,
    double increaseAmount,
    double amount,
    String notes,
  ) async {
    UpdateController apiController = UpdateController();

    Provider.of<IsLoadingInUpdateScreen>(context, listen: false)
        .newValueIsLoading = true;

    DailyFundTransactionResponse? response = await apiController.updateProcess(
      idBox: widget.idBox,
      boxName: widget.boxName,
      idProcess: idProcess,
      context: context,
      sourceId: sourceId,
      commissionId: commissionId,
      serviceId: serviceId,
      type: type,
      commission: commission,
      commissionType: 1,
      // استخدم القيمة المناسبة لنوع العمولة
      increaseAmount: increaseAmount,
      amount: amount,
      notes: notes,
    );

    Provider.of<IsLoadingInUpdateScreen>(context, listen: false)
        .newValueIsLoading = false;
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
                // Navigator.pop(context);
                Navigator.of(context).push(PageAnimationTransition(
                    page: DetailsBoxScreen(
                        idBox: widget.idBox, nameBox: widget.boxName),
                    pageAnimationType: BottomToTopFadedTransition()));
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

                // context.showSnackBar(
                //     message: "لا يمكن تغيير رقم العملية", erorr: true);
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
                        widget.numberProcess,
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
                        // Text(
                        //   "إسم الخدمة",
                        //   style: GoogleFonts.cairo(
                        //     fontSize: 14.sp,
                        //     fontWeight: FontWeight.w600,
                        //     color: Colors.black,
                        //   ),
                        //   textAlign: TextAlign.right,
                        //   textDirection: TextDirection.rtl,
                        // ),
                        // SizedBox(height: ScreenUtilNew.height(8)),
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
                                  // context.showSnackBar(
                                  //     message: "لا يمكن تغيير إسم الخدمة",
                                  //     erorr: true);
                                },
                                child: Container(
                                  height: ScreenUtilNew.height(52),
                                  width: ScreenUtilNew.width(160),
                                  decoration: BoxDecoration(
                                      color: Color(0XFFDCD9D9),
                                      borderRadius: BorderRadius.circular(5.r)),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: ScreenUtilNew.width(8)),
                                        child: const Icon(
                                          Icons.keyboard_arrow_down,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const Expanded(child: SizedBox()),
                                      Text(
                                        provider.nameService,
                                        style: GoogleFonts.cairo(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
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

                        // GestureDetector(
                        //   onTap: () {
                        //     // context.showSnackBar(
                        //     //     message: "لا يمكن تغيير إسم الخدمة",
                        //     //     erorr: true);
                        //   },
                        //   child: Container(
                        //     height: ScreenUtilNew.height(52),
                        //     width: ScreenUtilNew.width(160),
                        //     decoration: BoxDecoration(
                        //         color: AppColors.primaryColor.withOpacity(0.08),
                        //         borderRadius: BorderRadius.circular(5.r)),
                        //     child: Row(
                        //       children: [
                        //         Padding(
                        //           padding: EdgeInsets.only(
                        //               left: ScreenUtilNew.width(8)),
                        //           child: const Icon(
                        //             Icons.keyboard_arrow_down,
                        //             color: Colors.black,
                        //           ),
                        //         ),
                        //         const Expanded(child: SizedBox()),
                        //         Text(
                        //           nameServiceControllerProvider.nameService,
                        //           style: GoogleFonts.cairo(
                        //             fontSize: 14.sp,
                        //             fontWeight: FontWeight.w400,
                        //             color: Colors.black,
                        //           ),
                        //         ),
                        //         SizedBox(
                        //           width: ScreenUtilNew.width(8),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
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
                          List<DataSources> options = [
                            DataSources(id: 0, name: "اختر المصدر...")
                          ];
                          options.addAll(snapshot.data!);
                          return SizedBox(
                            width: ScreenUtilNew.width(160),
                            child: DropDownSelectSource(
                              options: options,
                              textTitle: "المصدر أو المستفيد",
                              selectedValueString: "",
                              onChanged: (selectedAccount) {
                                if (selectedAccount!.id != 0) {
                                  print(selectedAccount!.id);
                                  _updateResult(
                                      amountMoneyTextEditingController.text,
                                      sumAmountMoneyTextEditingController.text,
                                      percentTextEditingController.text);
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
                                  sourceId1 = 3;
                                  Provider.of<CommissionControllerInUpdateScreenProvider>(
                                              context,
                                              listen: false)
                                          .newCommission =
                                      percentTextEditingController.text;
                                  print("sourse id$sourceId1");
                                  //////////////////
                                  if (selectedAccount.commissionValue == "") {
                                    percentTextEditingController.text = "0";
                                  } else {
                                    double? value1 = double.tryParse(
                                        selectedAccount.commissionValue!);
                                    double? valueLimit =
                                        double.tryParse(commissionLimit);
                                    if (value1! >= valueLimit!) {
                                      _updateResult(
                                          amountMoneyTextEditingController.text,
                                          sumAmountMoneyTextEditingController
                                              .text,
                                          percentTextEditingController.text);
                                      percentTextEditingController.text =
                                          selectedAccount.commissionValue!;
                                    } else {
                                      percentTextEditingController.text =
                                          commissionLimit;
                                    }
                                  }
                                  // percentTextEditingController.text =
                                  //     selectedAccount.commissionValue == ""
                                  //         ? "0"
                                  //         : selectedAccount.commissionValue!;
                                  Provider.of<CommissionControllerInUpdateScreenProvider>(
                                              context,
                                              listen: false)
                                          .newCommission =
                                      percentTextEditingController.text;
                                  double? testColor = double.tryParse(
                                      percentTextEditingController.text);
                                  print(testColor);
                                  if (testColor == 0 || testColor == null) {
                                    Provider.of<FillColorCommissionControllerProvider>(
                                            context,
                                            listen: false)
                                        .newColorCommission = Color(0XFFDCD9D9);
                                    Provider.of<EnabledTextFiledsOrNotProvider>(
                                            context,
                                            listen: false)
                                        .newValue = false;
                                  } else {
                                    Provider.of<FillColorCommissionControllerProvider>(
                                                context,
                                                listen: false)
                                            .newColorCommission =
                                        AppColors.primaryColor
                                            .withOpacity(0.08);
                                    Provider.of<EnabledTextFiledsOrNotProvider>(
                                            context,
                                            listen: false)
                                        .newValue = true;
                                  }
                                  Provider.of<CommissionControllerInUpdateScreenProvider>(
                                          context,
                                          listen: false)
                                      .commission;

                                  sourceId1 = selectedAccount.id!;
                                  commissionId1 =
                                      selectedAccount.commissionId == null
                                          ? ""
                                          : "${selectedAccount.commissionId}";
                                  serviceId1 = selectedAccount.serviceId == null
                                      ? ""
                                      : "${selectedAccount.serviceId}";
                                  print("sreviceId${serviceId1}");
                                  print("sourceName${commissionId1}");
                                  // int typeId1 = 0;
                                  // bool isLoading = false;
                                  // int sourceId1=0;
                                  // int commissionId1=0;
                                  // int serviceId1=0;
                                  _updateResult(
                                      amountMoneyTextEditingController.text,
                                      sumAmountMoneyTextEditingController.text,
                                      percentTextEditingController.text);
                                } else {
                                  sourceId1 = 0;
                                  // context.showSnackBar(
                                  //     message: "قم باختيار المصدر..",
                                  //     erorr: true);
                                }
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
                          color: Colors.black,
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
                      Consumer2<FillColorCommissionControllerProvider,
                              EnabledTextFiledsOrNotProvider>(
                          builder: (context, provider, provider2, child) {
                        return TextFieldCusomizedBoxScreenWidget(
                          textInputType: TextInputType.number,
                          hintText: "0.0",
                          iconData: Icons.percent_rounded,
                          textEditingController: percentTextEditingController,
                          textFiledDiscount: true,
                          width: ScreenUtilNew.width(160),
                          minLines: 1,
                          maxLines: 2,
                          onChanged: (value) {
                            _updateResult(
                                amountMoneyTextEditingController.text,
                                sumAmountMoneyTextEditingController.text,
                                percentTextEditingController.text);
                            double? commissionValue = double.tryParse(value);
                            if (commissionValue! > 100) {
                              percentTextEditingController.text = "100";
                            } else if (commissionValue < 0) {
                              percentTextEditingController.text = "0";
                            }
                            _updateResult(
                                amountMoneyTextEditingController.text,
                                sumAmountMoneyTextEditingController.text,
                                percentTextEditingController.text);
                          },
                          enabled: provider2.enabledOrNot,
                          filledColor: provider.colorCommission,
                          styleHintText: GoogleFonts.cairo(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        );
                      })

                      // TextFieldCusomizedBoxScreenWidget(
                      //   textInputType: TextInputType.number,
                      //   hintText: "0.0",
                      //   onChanged: (value){
                      //     _updateResult(
                      //         amountMoneyTextEditingController.text,
                      //         sumAmountMoneyTextEditingController.text,
                      //         percentTextEditingController.text);
                      //   },
                      //   iconData: Icons.percent_rounded,
                      //   textEditingController: percentTextEditingController,
                      //   textFiledDiscount: true,
                      //   width: ScreenUtilNew.width(160),
                      //   minLines: 1,
                      //   maxLines: 2,
                      //   enabled: true,
                      //   filledColor: AppColors.primaryColor.withOpacity(0.08),
                      //   styleHintText: GoogleFonts.cairo(
                      //     fontWeight: FontWeight.w400,
                      //     color: Colors.black,
                      //     fontSize: 16.sp,
                      //   ),
                      // ),
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
                          color: Colors.black,
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
            // widget.typeId != 4
            //     ? Consumer<TypesOperationProvider>(
            //         builder: (context, provider, child) {
            //           return SizedBox(
            //             height: provider.typesOperation.length *
            //                 ScreenUtilNew.height(40),
            //             child: Padding(
            //               padding: EdgeInsets.symmetric(
            //                   horizontal: ScreenUtilNew.width(16)),
            //               child: ListView.builder(
            //                 padding: EdgeInsets.zero,
            //                 itemCount: provider.typesOperation.length,
            //                 itemBuilder: (context, index) {
            //                   final typeOperation =
            //                       provider.typesOperation[index];
            //                   return Directionality(
            //                     textDirection: TextDirection.rtl,
            //                     child: RadioListTile<String>(
            //                       contentPadding: EdgeInsets.zero,
            //                       activeColor: AppColors.primaryColor,
            //                       title: Text(
            //                         typeOperation.name!,
            //                         style:
            //                             GoogleFonts.cairo(color: Colors.black),
            //                       ),
            //                       value: typeOperation.id!,
            //                       groupValue: provider.selectedId,
            //                       onChanged: (value) {
            //                         // typeId=va;
            //                         typeId1 =
            //                             int.tryParse("${typeOperation.id}")!;
            //                         // typeId = int.tryParse("${typeOperation.id}")!;
            //                         if (typeOperation.id == "2" ||
            //                             typeOperation.id == "3") {
            //                           percentTextEditingController.text = "0.0";
            //                           Provider.of<EnabledTextFiledsOrNotProvider>(
            //                                   context,
            //                                   listen: false)
            //                               .newValue = false;
            //                           Provider.of<FillColorCommissionControllerProvider>(
            //                                       context,
            //                                       listen: false)
            //                                   .newColorCommission =
            //                               const Color(0XFFDCD9D9);
            //                           _updateResult(
            //                               amountMoneyTextEditingController.text,
            //                               sumAmountMoneyTextEditingController
            //                                   .text,
            //                               percentTextEditingController.text);
            //                           WidgetsBinding.instance
            //                               .addPostFrameCallback((_) {
            //                             provider.changeSelectedId(value!);
            //                           });
            //                         } else {
            //                           Provider.of<EnabledTextFiledsOrNotProvider>(
            //                                   context,
            //                                   listen: false)
            //                               .newValue = true;
            //                           Provider.of<FillColorCommissionControllerProvider>(
            //                                       context,
            //                                       listen: false)
            //                                   .newColorCommission =
            //                               AppColors.primaryColor
            //                                   .withOpacity(0.08);
            //                           percentTextEditingController
            //                               .text = Provider.of<
            //                                       CommissionControllerInUpdateScreenProvider>(
            //                                   context,
            //                                   listen: false)
            //                               .commission;
            //                           _updateResult(
            //                               amountMoneyTextEditingController.text,
            //                               sumAmountMoneyTextEditingController
            //                                   .text,
            //                               percentTextEditingController.text);
            //                           WidgetsBinding.instance
            //                               .addPostFrameCallback((_) {
            //                             provider.changeSelectedId(value!);
            //                           });
            //                         }
            //
            //                         // print(provider.selectedId);
            //                       },
            //                       visualDensity: VisualDensity
            //                           .compact, // تقليل المسافات العمودية
            //                     ),
            //                   );
            //                 },
            //                 addAutomaticKeepAlives: true,
            //               ),
            //             ),
            //           );
            //         },
            //       )
            //     :
            Padding(
              padding: EdgeInsets.only(right: ScreenUtilNew.width(8)),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: RadioListTile<String>(
                  contentPadding: EdgeInsets.zero,
                  activeColor: AppColors.primaryColor,
                  title: Text(
                    "غير مرحلة",
                    style: GoogleFonts.cairo(color: Colors.black),
                  ),
                  value: "0",
                  // قيمة الخيار
                  groupValue: "0",
                  // القيمة الحالية للمجموعة
                  onChanged: (value) {
                    setState(() {
                      // selectedValue = value; // تحديث القيمة عند التغيير
                    });
                    print("Selected value: $value");
                  },
                  visualDensity:
                      VisualDensity.compact, // تقليل المسافات العمودية
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
                    color: Colors.black,
                    fontSize: 16.sp,
                  ),
                )),
            SizedBox(
              height: ScreenUtilNew.height(32),
            ),
            Consumer<IsLoadingInUpdateScreen>(
                builder: (context, provider, child) {
              return provider.isLoading
                  ? const CircularProgressIndicator(
                      backgroundColor: AppColors.secondaryColor,
                      color: AppColors.primaryColor,
                    )
                  : ElevatedButtonCustomDataAndPasswordUpdated(
                      onTap: isLoading
                          ? null
                          : () async {
                              double? valueCommissionLimit =
                                  double.tryParse(commissionLimit);
                              double? valueCommission = double.tryParse(
                                  percentTextEditingController.text);
                              if (valueCommission! < valueCommissionLimit! &&
                                  Provider.of<FillColorCommissionControllerProvider>(
                                              context,
                                              listen: false)
                                          .colorCommission ==
                                      AppColors.primaryColor
                                          .withOpacity(0.08)) {
                                context.showSnackBar(
                                    message:
                                        "لا يمكن إكمال العملية يجب أن تكون قيمة العمولة أعلى او $commissionLimit",
                                    erorr: true);
                                // print("Status : ${Provider.of<TransactionsTrue>(context).transactionTrue}");
                              } else if (amountMoneyTextEditingController.text != "0" &&
                                  amountMoneyTextEditingController.text != "" &&
                                  sourceId1 != 0) {
                                double amountTest = double.tryParse(
                                        amountMoneyTextEditingController
                                            .text) ??
                                    0;
                                if (sourceId1 != 0 && amountTest != 0) {
                                  double increase2 = double.tryParse(
                                          sumAmountMoneyTextEditingController
                                              .text) ??
                                      0;
                                  double amount2 = double.tryParse(
                                          amountMoneyTextEditingController
                                              .text) ??
                                      0;
                                  double commisstion2 = 0;
                                  double commisstion3 = 0;
                                  if (typeId1 == 3 || typeId1 == 2) {
                                    commisstion2 = 0;
                                  } else {
                                    commisstion2 = double.tryParse(
                                            percentTextEditingController
                                                .text) ??
                                        0;
                                    commisstion3 =
                                        (commisstion2 / 100) * amount2;
                                  }
                                  // print("Type Id:$typeId1");
                                  // print("Id Process: ${widget.id}");
                                  // print("sourceId1 Process: $sourceId1");
                                  // print("commissionId1 Process:$commissionId1");
                                  // print("commissionId1 Process:$serviceId1");
                                  //
                                  // print("typeId1 Process: $typeId1");
                                  // print("commisstion2 Process:$commisstion2");
                                  // print("increase2 Process: $increase2");
                                  // print("amount2 Process: $amount2");
                                  // print("notesTextEditingController Process : ${notesTextEditingController.text}");
                                  sendUpdateTransactionData(
                                      widget.id,
                                      sourceId1,
                                      commissionId1 == "0" ? "" : commissionId1,
                                      serviceId1 == "0" ? "" : serviceId1,
                                      typeId1,
                                      commisstion2,
                                      increase2,
                                      amount2,
                                      notesTextEditingController.text);
                                } else {
                                  context.showSnackBar(
                                      message: "أكمل البيانات", erorr: true);
                                }
                              }else{
                                context.showSnackBar(
                                    message: "أكمل البيانات", erorr: true);
                              }
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
