import 'package:exchange/core/utils/assets_manger.dart';
import 'package:exchange/core/utils/context_extension.dart';
import 'package:exchange/core/utils/screen_util_new.dart';
import 'package:exchange/features/home/dailyBoxes/data/models/box.dart';
import 'package:exchange/features/home/dailyBoxes/data/models/daily_boxes.dart';
import 'package:exchange/features/home/dailyBoxes/domain/use_cases/box_controller.dart';
import 'package:exchange/features/home/dailyBoxes/presentation/manager/providers/controller_selected_sourse.dart';
import 'package:exchange/features/home/dailyBoxes/presentation/manager/providers/fill_color_commision_controller_provider.dart';
import 'package:exchange/features/home/dailyBoxes/presentation/manager/providers/name_service_controller.dart';
import 'package:exchange/features/home/dailyBoxes/presentation/pages/confirm_process.dart';
import 'package:exchange/features/home/dailyBoxes/presentation/pages/details_box_screen.dart';
import 'package:exchange/features/home/dailyBoxes/presentation/widgets/box_widget.dart';
import 'package:exchange/features/home/dailyBoxes/presentation/widgets/container_scan_qr.dart';
import 'package:exchange/features/home/dailyBoxes/presentation/widgets/text_field_cusomized_box_screen_widget.dart';
import 'package:exchange/features/home/dailyBoxes/presentation/widgets/widget_when_wating_data_drop_down_menu.dart';
import 'package:exchange/features/home/profile/presentation/widgets/elevated_button_custom_data_and_password_updated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_animation_transition/animations/bottom_to_top_transition.dart';
import 'package:page_animation_transition/animations/right_to_left_transition.dart';
import 'package:page_animation_transition/animations/top_to_bottom_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../config/routes/app_routes.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../data/models/get_sources_controller.dart';
import '../../data/models/setting_model.dart';
import '../../data/models/transaction_model_response.dart';
import '../../domain/use_cases/get_sources.dart';
import '../../domain/use_cases/get_sourse_one.dart';
import '../../domain/use_cases/setting_controller.dart';
import '../../domain/use_cases/transaction_controller_store.dart';
import '../manager/providers/commision_controller_in_update_screen_provider.dart';
import '../manager/providers/enabled_text_fileds_or_not_provider.dart';
import '../manager/providers/transactions_true.dart';
import '../manager/providers/types_operation.dart';
import '../widgets/drop_down_select_source.dart';
import '../widgets/drop_down_widget_text_field.dart';
import 'boxes_daily.dart';
// import '../widgets/text_field_cusomized_box_screen_widget.dart';

class BoxScreen extends StatefulWidget {
  int idBox;
  String nameBox;

  BoxScreen({super.key, required this.idBox, required this.nameBox});

  @override
  State<BoxScreen> createState() => _BoxScreenState();
}

class _BoxScreenState extends State<BoxScreen> {
  PageController pageController = PageController(
    initialPage: 1,
  );

  List detailsBox = [
    "أجمالي الصندوق",
    "إجمالي المتبقي",
    "إجمالي الإيداع",
    "إجمالي السحب"
  ];

  //posted data
  int idBoxSelected = 0;
  int sourceId = 0;
  String commissionId = "";
  String serviceId = "";
  int typeId = 0;
  double commission = 0; //if 2-3 =0
  int commissionType = 2;
  double increaseAmount1 = 0;
  double amount = 0;
  bool transactionTrue = false;

  TextEditingController numberProcessController = TextEditingController();
  TextEditingController increaseAmountController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  TextEditingController amountAfterController = TextEditingController();
  final SettingController _settingController = SettingController();
  final TypesOperationProvider typesOperationProvider =
      TypesOperationProvider();
  String commissionLimit = "17";

  // void checkCommission(String commissionLimit,String value){
  //   double? value1 = double.tryParse(value); // القيمة المدخلة من المستخدم
  //   double? valueLimit = double.tryParse(commissionLimit); // الحد الأدنى للعمولة
  //
  //   if (value1 != null && valueLimit != null) {
  //     if (value1 < valueLimit) {
  //       // إذا كانت القيمة أقل من الحد الأدنى
  //       setState(() {
  //         commissionController.text = commissionLimit;
  //       });
  //     } else if (value1 > 100) {
  //       // إذا كانت القيمة أعلى من الحد الأقصى (100)
  //       setState(() {
  //         commissionController.text = "100";
  //       });
  //     } else {
  //       // إذا كانت القيمة ضمن النطاق المسموح به
  //       _updateResult(
  //           amountController.text,
  //           increaseAmountController.text,
  //           commissionController.text);
  //     }
  //   } else {
  //     // إذا لم تكن القيمة المدخلة صحيحة (ليست رقمًا)
  //     setState(() {
  //       commissionController.text = commissionLimit;
  //     });
  //   }
  // }
  bool isKeyboardOpen(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom > 0;
  }

  //show data
  String serviceName = "لا يوجد";
  TextEditingController commissionController = TextEditingController();
  List<TypeOperation> typesTransaction = [
    TypeOperation(id: "1", name: "بنكي"),
  ];
  String valueRadioButton = ""; // Initial value, adjust as needed
  String typeTransication = ""; // Initial value, adjust as needed
  bool isLoading = false;
  bool chooseFromDialog = false;
  int currentIndexInformationBox = 1;
  List<Color> colorsBox = [
    const Color(0XFF005CE9),
    const Color(0XFFF66C2E),
    const Color(0XFF15A879),
    const Color(0XFFF85570),
  ];

  void sendTransactionData(
    int dailyFundId1,
    int sourceId1,
    String commissionId1,
    String serviceId1,
    int type1,
    double commission1,
    double increaseAmount1,
    double amount1,
    String notes1,
  ) async {
    ApiControllerDailyFundTransaction apiController =
        ApiControllerDailyFundTransaction();
    setState(() {
      isLoading = true;
    });

    DailyFundTransactionResponse? response = await apiController.postProcess(
      context: context,
      dailyFundId: dailyFundId1,
      sourceId: sourceId1,
      commissionId: commissionId1,
      serviceId: serviceId1,
      type: type1,
      commission: commission1,
      commissionType: 1,
      increaseAmount: increaseAmount1,
      amount: amount1,
      notes: notes1,
    );
    setState(() {
      isLoading = false;
    });
    setState(() {
      Provider.of<TypesOperationProvider>(context, listen: false)
          .changeSelectedId("0");
      transactionTrue =
          Provider.of<TransactionsTrue>(context, listen: false).transactionTrue;
    });
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

  void _updateResult(String valueAmount, String valueSum, String valuePercent) {
    double? amountBefore = double.tryParse(valueAmount);
    double? sumAmount = double.tryParse(valueSum);
    double? percent = double.tryParse(valuePercent);
    // increaseAmountController.text=="";
    if (amountBefore != null && percent != null) {
      if (sumAmount != null) {
        double discountedAmount = amountBefore - (amountBefore * percent / 100);
        double after = discountedAmount + sumAmount;
        amountAfterController.text = after.toString();
      } else {
        sumAmount = 0;
        // increaseAmountController.text="0";
        double discountedAmount = amountBefore - (amountBefore * percent / 100);
        double after = discountedAmount + sumAmount;
        amountAfterController.text = after.toString();
      }
      // print("Amount After: $after");
    } else if (commissionController.text.isEmpty &&
        amountBefore != null &&
        sumAmount != null) {
      double after = sumAmount + amountBefore;
      amountAfterController.text = after.toString();
    } else {
      amountAfterController.text = '';
    }
  }

  // void _updateResult(String valueAmount, String valueSum, String valuePercent) {
  //   double? amountBefore = double.tryParse(valueAmount);
  //   double? sumAmount = double.tryParse(valueSum);
  //   double percent = double.tryParse(valuePercent) ?? 0.0; // إذا كانت فارغة أو غير صالحة، اجعلها صفرًا.
  //
  //   if (amountBefore != null && sumAmount != null) {
  //     double discountedAmount = amountBefore - (amountBefore * percent / 100);
  //     double after = discountedAmount + sumAmount;
  //
  //     amountAfterController.text = after.toString();
  //   } else if (commissionController.text.isEmpty && amountBefore != null && sumAmount != null) {
  //     double after = sumAmount + amountBefore;
  //     amountAfterController.text = after.toString();
  //   } else {
  //     amountAfterController.text = '';
  //   }
  // }

  List<String> typesProcess = ["إيداع", "سحب"];

  // @override
  // void initState() {
  //   super.initState();
  //   idBoxSelected = widget.idBox;
  //   Provider.of<TransactionsTrue>(context).newValueTransactionTrue=false;
  //   Provider.of<TypesOperationProvider>(context, listen: false)
  //       .changeSelectedId("0");
  //   increaseAmountController.text = "0";
  //   commissionController.text = "0";
  //   Provider.of<NameServiceController>(context, listen: false).nameServiceNew =
  //       "لم تحدد...";
  //   Provider.of<EnabledTextFiledsOrNotProvider>(context, listen: false)
  //       .newValue = false;
  //   Provider.of<FillColorCommissionControllerProvider>(context, listen: false)
  //       .newColorCommission = const Color(0XFFDCD9D9);
  //   _fetchSettingsData();
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     Provider.of<TypesOperationProvider>(context, listen: false)
  //         .changeTypesOperation = [];
  //   });
  // }
  //
  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   numberProcessController.dispose();
  //   increaseAmountController.dispose();
  //   amountController.dispose();
  //   notesController.dispose();
  //   super.dispose();
  // }
  @override
  void initState() {
    super.initState();

    idBoxSelected = widget.idBox;

    // Avoid accessing context-dependent values directly here
    increaseAmountController.text = "0";
    commissionController.text = "0";

    _fetchSettingsData();

    // Use WidgetsBinding.instance.addPostFrameCallback for context-dependent operations
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Provider.of<TransactionsTrue>(context, listen: false).newValueTransactionTrue = false;
      Provider.of<TypesOperationProvider>(context, listen: false)
          .changeSelectedId("0");
      Provider.of<NameServiceController>(context, listen: false)
          .nameServiceNew = "لم تحدد...";
      Provider.of<EnabledTextFiledsOrNotProvider>(context, listen: false)
          .newValue = false;
      Provider.of<FillColorCommissionControllerProvider>(context, listen: false)
          .newColorCommission = const Color(0XFFDCD9D9);
      Provider.of<TypesOperationProvider>(context, listen: false)
          .changeTypesOperation = [];
    });
  }

  @override
  void dispose() {
    numberProcessController.dispose();
    increaseAmountController.dispose();
    amountController.dispose();
    notesController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Provider.of<TransactionsTrue>(context, listen: false).newValueTransactionTrue = false;
    Provider.of<TypesOperationProvider>(context, listen: false)
        .changeSelectedId("0");
    Provider.of<NameServiceController>(context, listen: false).nameServiceNew =
        "لم تحدد...";
    Provider.of<EnabledTextFiledsOrNotProvider>(context, listen: false)
        .newValue = false;
    Provider.of<FillColorCommissionControllerProvider>(context, listen: false)
        .newColorCommission = const Color(0XFFDCD9D9);
    Provider.of<TypesOperationProvider>(context, listen: false)
        .changeTypesOperation = [];
  }

  @override
  Widget build(BuildContext context) {
    final nameServiceControllerProvider =
        Provider.of<NameServiceController>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: ScreenUtilNew.height(48),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(PageAnimationTransition(
                            page: DetailsBoxScreen(
                              idBox: widget.idBox,
                              nameBox: widget.nameBox,
                            ),
                            pageAnimationType: TopToBottomTransition()));
                      },
                      icon: const Icon(
                        Icons.filter_list_rounded,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          Provider.of<TypesOperationProvider>(context,
                                  listen: false)
                              .changeSelectedId("0");
                          sourceId = 0;
                          Provider.of<NameServiceController>(context,
                                  listen: false)
                              .nameServiceNew = "لم تحدد...";
                          commissionController.text = "0";
                          double? testColor =
                              double.tryParse(commissionController.text);
                          if (testColor == 0 || testColor == null) {
                            Provider.of<FillColorCommissionControllerProvider>(
                                    context,
                                    listen: false)
                                .newColorCommission = Color(0XFFDCD9D9);
                          } else {
                            Provider.of<FillColorCommissionControllerProvider>(
                                        context,
                                        listen: false)
                                    .newColorCommission =
                                AppColors.primaryColor.withOpacity(0.08);
                          }
                          amountController.text = "0";
                          increaseAmountController.text = "0";
                          notesController.text = "";
                          _updateResult(
                              amountController.text,
                              increaseAmountController.text,
                              commissionController.text);
                        });
                        _fetchSettingsData();
                      },
                      icon: const Icon(
                        Icons.update,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                Text(
                  widget.nameBox,
                  style: GoogleFonts.cairo(
                    fontSize: 16.sp,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(PageAnimationTransition(
                        page: const BoxesDailyScreen(),
                        pageAnimationType: RightToLeftTransition()));
                    // Navigator.pop(context);
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
                          backgroundColor: colorsBox[index],
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
                activeDotColor: Colors.black,
                dotHeight: ScreenUtilNew.height(8),
                dotWidth: ScreenUtilNew.width(8),
              ),
              onDotClicked: (index) {
                setState(() {
                  currentIndexInformationBox = index;
                });
              },
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
                  padding:
                      EdgeInsets.symmetric(horizontal: ScreenUtilNew.width(16)),
                  child: TextFieldCusomizedBoxScreenWidget(
                    textInputType: TextInputType.number,
                    hintText: AppStrings.boxScreen2,
                    iconData: Icons.discount,
                    textEditingController: numberProcessController,
                    textFiledDiscount: false,
                    width: double.infinity,
                    minLines: 1,
                    maxLines: 3,
                    enabled: true,
                    filledColor: AppColors.primaryColor.withOpacity(0.08),
                    styleHintText: GoogleFonts.cairo(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: ScreenUtilNew.width(16)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          int number =
                              int.tryParse(numberProcessController.text) ?? 0;
                          if (number != 0) {
                            Navigator.of(context).push(PageAnimationTransition(
                                page: ConfirmProcess(
                                  numberId: number,
                                  idBox: widget.idBox,
                                  boxName: widget.nameBox,
                                ),
                                pageAnimationType: BottomToTopTransition()));
                            numberProcessController.clear();
                          } else {
                            context.showSnackBar(
                                message: "يجب كتابة رقم العملية", erorr: true);
                          }
                        },
                        icon: const Icon(
                          Icons.done,
                          color: Colors.black,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          numberProcessController.clear();
                        },
                        icon: const Icon(
                          Icons.refresh,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
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
                      FutureBuilder(
                          future:
                              ApiControllerSourcesBox().fetchData(widget.idBox),
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
                                      print(selectedAccount.commissionValue);
                                      if (selectedAccount.commissionValue ==
                                              0 ||
                                          selectedAccount.commissionValue ==
                                              "") {
                                        Provider.of<EnabledTextFiledsOrNotProvider>(
                                                context,
                                                listen: false)
                                            .newValue = false;
                                      } else {
                                        Provider.of<EnabledTextFiledsOrNotProvider>(
                                                context,
                                                listen: false)
                                            .newValue = true;
                                      }
                                      // Provider.of<TypesOperationProvider>(context,listen: false).changeTypesOperation=selectedAccount.typeOperation![0].id;
                                      _updateResult(
                                          amountController.text,
                                          increaseAmountController.text,
                                          selectedAccount.commissionValue!);
                                      idBoxSelected = widget.idBox;
                                      sourceId = selectedAccount.id!;
                                      commissionId =
                                          "${selectedAccount.commissionId}" ==
                                                  "null"
                                              ? ""
                                              : "${selectedAccount.commissionId}";
                                      commissionId = commissionId == "0"
                                          ? ""
                                          : commissionId;
                                      serviceId =
                                          "${selectedAccount.serviceId}" ==
                                                  "null"
                                              ? ""
                                              : "${selectedAccount.serviceId}";
                                      serviceId =
                                          serviceId == "0" ? "" : serviceId;
                                      typesTransaction =
                                          selectedAccount.typeOperation!;
                                      serviceName =
                                          selectedAccount.serviceName!;
                                      nameServiceControllerProvider
                                              .nameServiceNew =
                                          selectedAccount.serviceName == ""
                                              ? "لا يوجد"
                                              : selectedAccount.serviceName!;
                                      typesTransaction =
                                          selectedAccount.typeOperation!;
                                      // commissionController.text =
                                      //     selectedAccount.commissionValue == ""
                                      //         ? "0"
                                      //         : selectedAccount
                                      //             .commissionValue!;
                                      if (selectedAccount.commissionValue ==
                                          "") {
                                        commissionController.text = "0";
                                      } else {
                                        double? value1 = double.tryParse(
                                            selectedAccount.commissionValue!);
                                        double? valueLimit =
                                            double.tryParse(commissionLimit);
                                        if (value1! >= valueLimit!) {
                                          _updateResult(
                                              amountController.text,
                                              increaseAmountController.text,
                                              commissionController.text);
                                          commissionController.text =
                                              selectedAccount.commissionValue!;
                                        } else {
                                          commissionController.text =
                                              commissionLimit;
                                        }
                                      }
                                      // double? value1 = double.tryParse(selectedAccount.commissionValue!);
                                      // double? valueLimit =
                                      // double.tryParse(commissionLimit);
                                      // if (value1! >= valueLimit!) {
                                      //   _updateResult(
                                      //       amountController.text,
                                      //       increaseAmountController.text,
                                      //       commissionController.text);
                                      // } else {
                                      //   if(selectedAccount.commissionValue!=""){
                                      //     commissionController.text = commissionLimit;
                                      //   }else{
                                      //     commissionController.text=selectedAccount.commissionValue!;
                                      //   }
                                      // }
                                      _updateResult(
                                          amountController.text,
                                          increaseAmountController.text,
                                          commissionController.text);
                                      Provider.of<CommissionControllerInUpdateScreenProvider>(
                                                  context,
                                                  listen: false)
                                              .newCommission =
                                          commissionController.text;
                                      double? testColor = double.tryParse(
                                          commissionController.text);
                                      print(testColor);
                                      if (testColor == 0 || testColor == null) {
                                        Provider.of<FillColorCommissionControllerProvider>(
                                                    context,
                                                    listen: false)
                                                .newColorCommission =
                                            Color(0XFFDCD9D9);
                                      } else {
                                        Provider.of<FillColorCommissionControllerProvider>(
                                                    context,
                                                    listen: false)
                                                .newColorCommission =
                                            AppColors.primaryColor
                                                .withOpacity(0.08);
                                      }
                                      Provider.of<CommissionControllerInUpdateScreenProvider>(
                                              context,
                                              listen: false)
                                          .commission;
                                      _updateResult(
                                          amountController.text,
                                          increaseAmountController.text,
                                          commissionController.text);
                                      print(selectedAccount.commissionValue);
                                      // _updateResult(
                                      //     amountController.text,
                                      //     increaseAmountController.text,
                                      //     selectedAccount.commissionValue!);
                                      Provider.of<TypesOperationProvider>(
                                                  context,
                                                  listen: false)
                                              .changeTypesOperation =
                                          selectedAccount.typeOperation!;
                                    } else {
                                      Provider.of<TypesOperationProvider>(
                                              context,
                                              listen: false)
                                          .changeSelectedId("0");
                                      Provider.of<TypesOperationProvider>(
                                              context,
                                              listen: false)
                                          .changeTypesOperation = [];
                                      sourceId = 0;
                                      commissionId == "0";
                                      Provider.of<NameServiceController>(
                                              context,
                                              listen: false)
                                          .nameServiceNew = "لم تحدد...";
                                      commissionController.text = "0";
                                      double? testColor = double.tryParse(
                                          commissionController.text);
                                      print(testColor);
                                      if (testColor == 0 || testColor == null) {
                                        Provider.of<FillColorCommissionControllerProvider>(
                                                    context,
                                                    listen: false)
                                                .newColorCommission =
                                            Color(0XFFDCD9D9);
                                      } else {
                                        Provider.of<FillColorCommissionControllerProvider>(
                                                    context,
                                                    listen: false)
                                                .newColorCommission =
                                            AppColors.primaryColor
                                                .withOpacity(0.08);
                                      }
                                      amountController.text = "0";
                                      increaseAmountController.text = "0";
                                      notesController.text = "";
                                      _updateResult(
                                          amountController.text,
                                          increaseAmountController.text,
                                          commissionController.text);
                                    }
                                  },
                                  selectDefaultValue: 0,
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
                            hintText: "0.0",
                            iconData: Icons.percent_rounded,
                            textEditingController: amountController,
                            textFiledDiscount: false,
                            width: ScreenUtilNew.width(160),
                            minLines: 1,
                            maxLines: 2,
                            onChanged: (value) {
                              // (String valueAmount, String valueSum, String valuePercent)
                              _updateResult(
                                  amountController.text,
                                  increaseAmountController.text,
                                  commissionController.text);
                            },
                            enabled: true,
                            filledColor:
                                AppColors.primaryColor.withOpacity(0.08),
                            styleHintText: GoogleFonts.cairo(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
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
                              textEditingController: commissionController,
                              textFiledDiscount: true,
                              width: ScreenUtilNew.width(160),
                              minLines: 1,
                              maxLines: 2,
                              onChanged: (value) {
                                _updateResult(
                                    amountController.text,
                                    increaseAmountController.text,
                                    commissionController.text);
                                Provider.of<
                                    CommissionControllerInUpdateScreenProvider>(
                                    context,
                                    listen: false)
                                    .newCommission=value;
                                double? commissionValue=double.tryParse(value);
                                if(commissionValue!>100){
                                  commissionController.text="100";
                                }else if(commissionValue<0){
                                  commissionController.text="0";
                                }
                                _updateResult(
                                    amountController.text,
                                    increaseAmountController.text,
                                    commissionController.text);

                                // double? value1 = double.tryParse(commissionController.text); // القيمة المدخلة من المستخدم
                                // double? valueLimit = double.tryParse(commissionLimit);
                                // if(value1!<=valueLimit!&&isKeyboardOpen(context)){
                                //   commissionController.text=commissionLimit;
                                // }
                                // checkCommission(commissionLimit,value);
                              },
                              enabled: provider2.enabledOrNot,
                              filledColor: provider.colorCommission,
                              styleHintText: GoogleFonts.cairo(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                            );
                          })
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
                            hintText: "0.0",
                            iconData: Icons.percent_rounded,
                            textEditingController: amountAfterController,
                            textFiledDiscount: false,
                            width: ScreenUtilNew.width(160),
                            minLines: 1,
                            maxLines: 2,
                            onChanged: (value) {},
                            enabled: false,
                            filledColor: AppColors.secondaryColor,
                            styleHintText: GoogleFonts.cairo(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
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
                            hintText: "0.0",
                            iconData: Icons.percent_rounded,
                            textEditingController: increaseAmountController,
                            textFiledDiscount: false,
                            width: ScreenUtilNew.width(160),
                            minLines: 1,
                            maxLines: 2,
                            onChanged: (value) {
                              _updateResult(
                                  amountController.text,
                                  increaseAmountController.text,
                                  commissionController.text);
                            },
                            enabled: true,
                            filledColor:
                                AppColors.primaryColor.withOpacity(0.08),
                            styleHintText: GoogleFonts.cairo(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
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
                  padding: EdgeInsets.only(right: ScreenUtilNew.width(16)),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      "نوع العملية",
                      style: GoogleFonts.cairo(
                          fontSize: 14.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Consumer<TypesOperationProvider>(
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
                                  style: GoogleFonts.cairo(color: Colors.black),
                                ),
                                value: typeOperation.id!,
                                groupValue: provider.selectedId,
                                onChanged: (value) {
                                  typeId = int.tryParse("${typeOperation.id}")!;
                                  if (typeOperation.id == "2" ||
                                      typeOperation.id == "3") {
                                    commissionController.text = "0.0";
                                    Provider.of<EnabledTextFiledsOrNotProvider>(
                                            context,
                                            listen: false)
                                        .newValue = false;
                                    Provider.of<FillColorCommissionControllerProvider>(
                                                context,
                                                listen: false)
                                            .newColorCommission =
                                        const Color(0XFFDCD9D9);
                                    _updateResult(
                                        amountController.text,
                                        increaseAmountController.text,
                                        commissionController.text);
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                      provider.changeSelectedId(value!);
                                    });
                                  } else {
                                    Provider.of<EnabledTextFiledsOrNotProvider>(
                                            context,
                                            listen: false)
                                        .newValue = true;
                                    Provider.of<FillColorCommissionControllerProvider>(
                                                context,
                                                listen: false)
                                            .newColorCommission =
                                        AppColors.primaryColor
                                            .withOpacity(0.08);
                                    commissionController.text = Provider.of<
                                                CommissionControllerInUpdateScreenProvider>(
                                            context,
                                            listen: false)
                                        .commission;
                                    _updateResult(
                                        amountController.text,
                                        increaseAmountController.text,
                                        commissionController.text);
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                      provider.changeSelectedId(value!);
                                    });
                                  }

                                  // typeId = int.tryParse("${typeOperation.id}")!;
                                  // WidgetsBinding.instance
                                  //     .addPostFrameCallback((_) {
                                  //   provider.changeSelectedId(value!);
                                  // });
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
                ),
                SizedBox(
                  height: ScreenUtilNew.height(8),
                ),
                Padding(
                  padding: EdgeInsets.only(right: ScreenUtilNew.width(16)),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      "ملاحظات",
                      style: GoogleFonts.cairo(
                          fontSize: 14.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
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
                      hintText: "قم بكتابة ملاحظاتك....",
                      iconData: Icons.abc_rounded,
                      textEditingController: notesController,
                      textFiledDiscount: false,
                      width: double.infinity,
                      minLines: 2,
                      maxLines: 4,
                      enabled: true,
                      filledColor: AppColors.primaryColor.withOpacity(0.08),
                      styleHintText: GoogleFonts.cairo(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                      textInputType: TextInputType.text),
                ),
                SizedBox(
                  height: ScreenUtilNew.height(16),
                ),
                isLoading
                    ? const CircularProgressIndicator(
                        backgroundColor: AppColors.secondaryColor,
                        color: AppColors.primaryColor,
                      )
                    : ElevatedButtonCustomDataAndPasswordUpdated(
                        onTap: isLoading
                            ? null
                            : () async {
                                // if (amountController.text != "0" &&
                                //     amountController.text != "" &&
                                //     sourceId != 0 &&
                                //     Provider.of<TypesOperationProvider>(context,listen: false).selectedId != "0") {
                                //   await showDialogCustomize(context);
                                //   // Check if widget is still mounted
                                //   if (!mounted) return;
                                //
                                //   if (chooseFromDialog) {
                                //     double increase2 = double.tryParse(increaseAmountController.text) ?? 0;
                                //     double amount2 = double.tryParse(amountController.text) ?? 0;
                                //     double commisstion2 = 0;
                                //     String commisstion3 = "";
                                //
                                //     if (typeId == 3 || typeId == 2) {
                                //       commisstion2 = 0;
                                //       commisstion3 = "";
                                //     } else {
                                //       commisstion2 = double.tryParse(commissionController.text) ?? 0;
                                //       commisstion3 = "$commisstion2";
                                //     }
                                //
                                //     // Send transaction data
                                //     sendTransactionData(
                                //       idBoxSelected,
                                //       sourceId,
                                //       commissionId,
                                //       serviceId,
                                //       typeId,
                                //       commisstion2,
                                //       increase2,
                                //       amount2,
                                //       notesController.text,
                                //     );
                                //     print("ooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo$transactionTrue");
                                //     setState(() {
                                //       if (transactionTrue==true) {
                                //         // Reset UI elements
                                //         Provider.of<TypesOperationProvider>(context, listen: false).changeSelectedId("0");
                                //         sourceId = 0;
                                //         Provider.of<NameServiceController>(context, listen: false).nameServiceNew = "لم تحدد...";
                                //         commissionController.text = "0";
                                //         double? testColor = double.tryParse(commissionController.text);
                                //         if (testColor == 0 || testColor == null) {
                                //           Provider.of<FillColorCommissionControllerProvider>(context, listen: false)
                                //               .newColorCommission = const Color(0XFFDCD9D9);
                                //         } else {
                                //           Provider.of<FillColorCommissionControllerProvider>(context, listen: false)
                                //               .newColorCommission = AppColors.primaryColor.withOpacity(0.08);
                                //         }
                                //         amountController.text = "0";
                                //         increaseAmountController.text = "0";
                                //         notesController.text = "";
                                //         _updateResult(amountController.text, increaseAmountController.text, commissionController.text);
                                //       }
                                //     });
                                //   }
                                // } else {
                                //   context.showSnackBar(
                                //       message: "قم بتعبئة جميع القيم",
                                //       erorr: true);
                                // }
                                double? valueCommissionLimit =
                                    double.tryParse(commissionLimit);
                                double? valueCommission =
                                    double.tryParse(commissionController.text);
                                if (valueCommission! <
                                    valueCommissionLimit!&&Provider.of<FillColorCommissionControllerProvider>(context,listen: false).colorCommission==AppColors.primaryColor.withOpacity(0.08)) {
                                  context.showSnackBar(
                                      message:
                                      "لا يمكن إكمال العملية يجب أن تكون قيمة العمولة أعلى او $commissionLimit",
                                      erorr: true);
                                  // print("Status : ${Provider.of<TransactionsTrue>(context).transactionTrue}");
                                } else if (amountController.text != "0" &&
                                    amountController.text != "" &&
                                    sourceId != 0 &&
                                    Provider.of<TypesOperationProvider>(context,
                                        listen: false)
                                        .selectedId !=
                                        "0") {
                          // &&
                          // valueCommission! >= valueCommissionLimit!
                                  await showDialogCustomize(context);
                                  if (chooseFromDialog) {
                                    double increase2 = double.tryParse(
                                        increaseAmountController.text) ??
                                        0;
                                    double amount2 = double.tryParse(
                                        amountController.text) ??
                                        0;
                                    double commisstion2 = 0;
                                    String commisstion3 = "";
                                    if (typeId == 3 || typeId == 2) {
                                      commisstion2 = 0;
                                      commisstion3 = "";
                                    } else {
                                      commisstion2 = double.tryParse(
                                          commissionController.text) ??
                                          0;
                                      commisstion3 = "$commisstion2";
                                      // commisstion3 = (commisstion2 / 100) * amount2;
                                    }
                                    print("Type Id:$typeId");
                                    print("commissionId:$commissionId");
                                    print("service id:$serviceId");
                                    sendTransactionData(
                                      idBoxSelected,
                                      sourceId,
                                      commissionId,
                                      serviceId,
                                      typeId,
                                      commisstion2,
                                      increase2,
                                      amount2,
                                      notesController.text,
                                    );
                                    if (Provider.of<TransactionsTrue>(context,
                                        listen: false)
                                        .transactionTrue ==
                                        true) {
                                      Provider.of<TypesOperationProvider>(
                                          context,
                                          listen: false)
                                          .changeSelectedId("0");
                                      sourceId = 0;
                                      Provider.of<NameServiceController>(
                                          context,
                                          listen: false)
                                          .nameServiceNew = "لم تحدد...";
                                      commissionController.text = "0";
                                      double? testColor = double.tryParse(
                                          commissionController.text);
                                      if (testColor == 0 || testColor == null) {
                                        Provider.of<FillColorCommissionControllerProvider>(
                                            context,
                                            listen: false)
                                            .newColorCommission =
                                            Color(0XFFDCD9D9);
                                      } else {
                                        Provider.of<FillColorCommissionControllerProvider>(
                                            context,
                                            listen: false)
                                            .newColorCommission =
                                            AppColors.primaryColor
                                                .withOpacity(0.08);
                                      }
                                      amountController.text = "0";
                                      increaseAmountController.text = "0";
                                      notesController.text = "";
                                      _updateResult(
                                          amountController.text,
                                          increaseAmountController.text,
                                          commissionController.text);
                                    }
                                  }

                                } else {
                                  context.showSnackBar(
                                      message: "يجب إكمال تعبئة بيانات العملية",
                                      erorr: true);
                                }
                              },
                        title: "حفظ البيانات"),
                SizedBox(
                  height: ScreenUtilNew.height(16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> showDialogCustomize(BuildContext context) async {
    chooseFromDialog = false;
    return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return buildCustomDialogWidget(
          () {
            if (typeId == 4) {
              typeId = int.tryParse(Provider.of<TypesOperationProvider>(context)
                      .selectedId!) ??
                  0;
              print("Type Id New :$typeId");
            }
            chooseFromDialog = true;
            Navigator.pop(context);
          },
          () {
            typeId = 4;
            chooseFromDialog = true;
            Navigator.pop(context);
          },
        );
      },
    );
  }

  Widget buildCustomDialogWidget(
      VoidCallback onConfirm, VoidCallback onCancel) {
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
                fontSize: 20.sp,
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: ScreenUtilNew.width(16)),
              child: Text(
                "هل تريد إتمام العملية بشكل كامل أو جعل العملية في قسم العمليات الغير مرحلة",
                style: GoogleFonts.cairo(
                  color: const Color(0XFF8C9191),
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                ),
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
                SizedBox(width: ScreenUtilNew.width(16)),
                Expanded(
                  child: GestureDetector(
                    onTap: onCancel,
                    child: Container(
                      height: ScreenUtilNew.height(47),
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
                ),
                SizedBox(width: ScreenUtilNew.width(8)),
                Expanded(
                  child: GestureDetector(
                    onTap: onConfirm,
                    child: Container(
                      height: ScreenUtilNew.height(47),
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
                SizedBox(width: ScreenUtilNew.width(16)),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// class CustomDialogWidget extends StatelessWidget {
//   int typeId;
//    CustomDialogWidget(
//       {super.key, required this.typeId});
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       backgroundColor: Colors.white,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
//       child: Container(
//         height: ScreenUtilNew.height(195),
//         decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.r)),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               "تأكيد إتمام العملية",
//               style: GoogleFonts.cairo(
//                   color: AppColors.primaryColor,
//                   fontWeight: FontWeight.w600,
//                   fontSize: 20.sp),
//             ),
//             Padding(
//               padding:
//               EdgeInsets.symmetric(horizontal: ScreenUtilNew.width(16)),
//               child: Text(
//                 "هل تريد إتمام العملية بشكل كامل أو جعل العملية في قسم العمليات الغير مرحلة ",
//                 style: GoogleFonts.cairo(
//                     color: const Color(0XFF8C9191),
//                     fontWeight: FontWeight.w400,
//                     fontSize: 14.sp),
//                 textAlign: TextAlign.center,
//                 maxLines: 3,
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//             SizedBox(
//               height: ScreenUtilNew.height(16),
//             ),
//             Row(
//               children: [
//                 SizedBox(
//                   width: ScreenUtilNew.width(16),
//                 ),
//                 Expanded(
//                   child: GestureDetector(
//                     onTap: () {
//                       // type
//                     },
//                     child: Container(
//                       height: ScreenUtilNew.height(47),
//                       decoration: BoxDecoration(
//                         color: const Color(0XFFFFE2E2),
//                         borderRadius: BorderRadius.circular(8.r),
//                       ),
//                       child: Center(
//                         child: Text(
//                           "عملية غير مرحلة",
//                           style: GoogleFonts.cairo(
//                             fontSize: 14.sp,
//                             color: const Color(0XFFFF0000),
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   width: ScreenUtilNew.width(8),
//                 ),
//                 Expanded(
//                   child: GestureDetector(
//                     onTap: () {
//                       Navigator.pop(context);
//                       Future.delayed(const Duration(seconds: 2), () {
//                         Navigator.pushNamed(
//                             context, Routes.addTransactionNewScreen);
//                       });
//                       _settingModalBottomSheet(context);
//                     },
//                     child: Container(
//                       height: ScreenUtilNew.height(47),
//                       // width: ScreenUtilNew.width(148),
//                       decoration: BoxDecoration(
//                         color: AppColors.secondaryColor,
//                         borderRadius: BorderRadius.circular(8.r),
//                       ),
//                       child: Center(
//                         child: Text(
//                           "تاكيد كامل",
//                           style: GoogleFonts.cairo(
//                             fontSize: 14.sp,
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   width: ScreenUtilNew.width(16),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
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
//
// // void storeData(BuildContext context, int idType) async {
// //   // Your data to be sent in the POST request
// //   final response = await ApiControllerDailyFundTransaction().postData(
// //     dailyFundId: dailyFundId, // replace with actual data
// //     sourceId: sourceId, // replace with actual data
// //     commissionId: commissionId, // replace with actual data
// //     serviceId: serviceId, // replace with actual data
// //     type: idType.toString(), // replace with actual data
// //     commission: (idType == 2 || idType == 3) ? 0 : yourValueHere, // replace with actual value
// //     commissionType: commissionType, // replace with actual data, set this based on your logic
// //     increaseAmount: increaseAmount, // replace with actual data
// //     amount: amount, // replace with actual data
// //     notes: notes, // replace with actual data
// //   );
// //
// //   if (response != null && response.status == 200) {
// //     // Show success message or navigate to another screen
// //     _settingModalBottomSheet(context);
// //   } else {
// //     // Handle error
// //     context.showSnackBar(message: response!.message.toString());
// //   }
// // }
// }
