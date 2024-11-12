// import 'package:exchange/core/utils/app_colors.dart';
// import 'package:exchange/features/home/bankTransfers/data/models/bank_transfer_model.dart';
// import 'package:exchange/features/home/bankTransfers/presentation/pages/update_transaction_bank.dart';
// import 'package:fast_cached_network_image/fast_cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:page_animation_transition/animations/bottom_to_top_transition.dart';
// import 'package:page_animation_transition/animations/left_to_right_transition.dart';
// import 'package:page_animation_transition/page_animation_transition.dart';
//
// import '../../../../../config/routes/app_routes.dart';
// import '../../../../../core/utils/app_strings.dart';
// import '../../../../../core/utils/assets_manger.dart';
// import '../../../../../core/utils/screen_util_new.dart';
// import '../../domain/use_cases/bank_transfer_controller.dart';
// import '../widgets/widgte_transfer_bank_information.dart';
//
// class AllTransactionsScreen extends StatefulWidget {
//   const AllTransactionsScreen({super.key});
//
//   @override
//   State<AllTransactionsScreen> createState() => _AllTransactionsScreenState();
// }
//
// class _AllTransactionsScreenState extends State<AllTransactionsScreen> {
//   final ScrollController scrollController = ScrollController();
//   List<BankTransferModel> bankTransfer = [];
//   int page = 1;
//   bool isLoading = false;
//   bool isLoadMore = false;
//   bool allDataLoaded = false; // للتحقق من ما إذا تم تحميل كل البيانات
//
//   @override
//   void initState() {
//     super.initState();
//     scrollController.addListener(_scrollListener);
//     _fetchData(page);
//   }
//
//   @override
//   void dispose() {
//     scrollController.dispose();
//     super.dispose();
//   }
//
//   Future<void> _scrollListener() async {
//     if (scrollController.position.pixels ==
//         scrollController.position.maxScrollExtent &&
//         !isLoadMore &&
//         !allDataLoaded) {
//       // تحميل المزيد من البيانات عند الوصول لنهاية القائمة
//       setState(() {
//         isLoadMore = true;
//       });
//       await _fetchData(page + 1);
//       setState(() {
//         isLoadMore = false;
//       });
//     }
//   }
//
//   Future<void> _fetchData(int pageNumber) async {
//     if (isLoading || allDataLoaded) return;
//
//     setState(() {
//       isLoading = true;
//     });
//
//     List<BankTransferModel>? newItems =
//     await BankTransferController().fetchDataBankTransfer(pageNumber);
//
//     if (newItems != null && newItems.isNotEmpty) {
//       setState(() {
//         page = pageNumber;
//         bankTransfer.addAll(newItems);
//       });
//     } else {
//       setState(() {
//         allDataLoaded = true; // لا توجد المزيد من البيانات للتحميل
//       });
//     }
//
//     setState(() {
//       isLoading = false;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.pushNamed(context, Routes.addTransactionNewScreen);
//         },
//         backgroundColor: Colors.white,
//         elevation: 10,
//         child: const Icon(
//           Icons.add,
//           color: AppColors.secondaryColor,
//         ),
//       ),
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         automaticallyImplyLeading: false,
//         centerTitle: true,
//         leading: IconButton(
//           onPressed: () {},
//           icon: const Icon(
//             Icons.filter_list_rounded,
//             color: AppColors.primaryColor,
//           ),
//         ),
//         actions: [
//           IconButton(
//             onPressed: () {
//               Navigator.pushReplacementNamed(context, Routes.homeScreen);
//             },
//             icon: const Icon(
//               Icons.arrow_forward,
//               color: Colors.black,
//             ),
//           ),
//         ],
//         title: Text(
//           AppStrings.allTransaction1,
//           style: GoogleFonts.cairo(
//             fontSize: 16.sp,
//             fontWeight: FontWeight.bold,
//             color: AppColors.primaryColor,
//           ),
//         ),
//       ),
//       body: Column(
//         children: [
//           SizedBox(height: ScreenUtilNew.height(8)),
//           Padding(
//             padding: EdgeInsets.only(right: ScreenUtilNew.width(16)),
//             child: Align(
//               alignment: Alignment.topRight,
//               child: Text(
//                 AppStrings.allTransaction2,
//                 style: GoogleFonts.cairo(
//                     fontSize: 14.sp,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.black),
//               ),
//             ),
//           ),
//           SizedBox(height: ScreenUtilNew.height(8)),
//           Expanded(
//             child: bankTransfer.isEmpty && isLoading
//                 ? const Center(
//                 child: CircularProgressIndicator(
//                   color: AppColors.primaryColor,
//                   backgroundColor: AppColors.secondaryColor,
//                 ))
//                 : ListView.builder(
//               controller: scrollController,
//               itemCount: bankTransfer.length + (isLoadMore ? 1 : 0),
//               itemBuilder: (context, index) {
//                 if (index < bankTransfer.length) {
//                   return Column(
//                     children: [
//                       SizedBox(
//                         height: ScreenUtilNew.height(16),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.symmetric(
//                             horizontal: ScreenUtilNew.width(16)),
//                         child: Slidable(
//                           startActionPane: ActionPane(
//                             motion: const ScrollMotion(),
//                             // A pane can dismiss the Slidable.
//                             // dismissible: DismissiblePane(onDismissed: () {}),
//                             // All actions are defined in the children parameter.
//                             children: [
//                               // A SlidableAction can have an icon and/or a label.
//                               // SlidableAction(
//                               //   onPressed: (value){},
//                               //   backgroundColor: Color(0xFFFE4A49),
//                               //   foregroundColor: Colors.white,
//                               //   icon: Icons.delete,
//                               //   label: 'Delete',
//                               // ),
//                               SlidableAction(
//                                 onPressed: (value) {
//                                   _settingModalBottomSheet(context,bankTransfer[index].image!);
//                                 },
//                                 backgroundColor:
//                                 AppColors.primaryColor.withOpacity(0.08),
//                                 foregroundColor: AppColors.secondaryColor,
//                                 icon: Icons.remove_red_eye,
//                                 borderRadius: BorderRadius.only(
//                                     topRight: Radius.circular(5.r),
//                                     bottomRight: Radius.circular(5.r)),
//                                 label: 'View transfer',
//                               ),
//                               // SlidableAction(
//                               //   onPressed: (value){},
//                               //   backgroundColor: Color(0xFF21B7CA),
//                               //   foregroundColor: Colors.white,
//                               //   icon: Icons.share,
//                               //   label: 'Share',
//                               // ),
//                             ],
//                           ),
//
//                           // The end action pane is the one at the right or the bottom side.
//                           endActionPane: ActionPane(
//                             motion: ScrollMotion(),
//                             children: [
//                               SlidableAction(
//                                 onPressed: (value) {
//                                   Navigator.of(context).push(PageAnimationTransition(page: UpdateTransactionBank(
//                                     refNumberController: bankTransfer[index].refNumber!,
//                                     accountIdController:bankTransfer[index].accountId!,
//                                     userIdController: bankTransfer[index].userId!,
//                                     nameReceiveController: bankTransfer[index].nameReceive!,
//                                     dateController: bankTransfer[index].date!,
//                                     amountController: bankTransfer[index].amount!,
//                                     currencyController: bankTransfer[index].currency!,
//                                     notesController: bankTransfer[index].notes!,
//                                     imagePath: bankTransfer[index].image!, id: '',
//                                   ), pageAnimationType: LeftToRightTransition()));
//
//                                 },
//                                 backgroundColor:
//                                 AppColors.primaryColor.withOpacity(0.08),
//                                 foregroundColor: AppColors.secondaryColor,
//                                 icon: Icons.mode_edit,
//                                 borderRadius: BorderRadius.only(
//                                     topRight: Radius.circular(5.r),
//                                     bottomRight: Radius.circular(5.r)),
//                                 label: 'Update Transfer',
//                               ),
//                             ],
//                           ),
//                           // The child of the Slidable is what the user sees when the
//                           // component is not dragged.
//                           child: WidgetTransferBankInformation(
//                             id: bankTransfer[index].id!,
//                             amount: bankTransfer[index].amount!,
//                             accountId: bankTransfer[index].accountId!,
//                             accountName: bankTransfer[index].accountName!,
//                             currency: bankTransfer[index].currency!,
//                             date: bankTransfer[index].date!,
//                             image: bankTransfer[index].image!,
//                             nameReceive:  bankTransfer[index].nameReceive!,
//                             notes:  bankTransfer[index].notes!,
//                             refNumber:  bankTransfer[index].refNumber!,
//                             status:  bankTransfer[index].status!,
//                             userId:  bankTransfer[index].userId!,
//                             userName:  bankTransfer[index].userName!,
//                           ),
//                         ),
//                       ),
//                     ],
//                   );
//                 } else {
//                   return const SizedBox
//                       .shrink(); // لا تعرض شيئًا إذا لم يكن هناك تحميل
//                 }
//               },
//             ),
//           ),
//           if (isLoadMore) // Show CircularProgressIndicator when loading more data
//             Padding(
//               padding: EdgeInsets.symmetric(vertical: 16.h),
//               child: CircularProgressIndicator(
//                 color: AppColors.primaryColor,
//                 backgroundColor: AppColors.secondaryColor,
//               ),
//             ),
//         ],
//       ),
//     );
//   }
//   // void _settingModalBottomSheet(context,String imagePath) {
//   //   showModalBottomSheet(
//   //     context: context,
//   //     isDismissible: false,
//   //     shape: RoundedRectangleBorder(
//   //       borderRadius: BorderRadius.only(
//   //           topLeft: Radius.circular(16.r), topRight: Radius.circular(16.r)),
//   //     ),
//   //     builder: (BuildContext bc) {
//   //       return SizedBox(
//   //         // height: ScreenUtilNew.height(400),
//   //         width: ScreenUtilNew.width(375),
//   //         child: SingleChildScrollView(
//   //           child: Column(
//   //             mainAxisSize: MainAxisSize.min,
//   //             children: [
//   //               SizedBox(height: ScreenUtilNew.height(24)),
//   //               // Image.network(imagePath,  height: ScreenUtilNew.height(350),
//   //               //   width: ScreenUtilNew.width(274),
//   //               // fit: BoxFit.contain,),
//   //               FastCachedImage(
//   //                 url: imagePath, // رابط الصورة
//   //                 fit: BoxFit.cover, // تناسب الصورة مع الحاوية
//   //                 fadeInDuration: const Duration(seconds: 1), // تأثير التلاشي عند التحميل
//   //                 errorBuilder: (context, exception, stacktrace) {
//   //                   // يتم عرض هذا عند حدوث خطأ أثناء التحميل
//   //                   return const Icon(Icons.error); // رمز الخطأ الافتراضي أو يمكنك إضافة صورة افتراضية
//   //                 },
//   //                 loadingBuilder: (context, progress) {
//   //                   // يتم عرض هذا عند التحميل
//   //                   return const Center(
//   //                     child: CircularProgressIndicator(), // عرض مؤشر التحميل أثناء التحميل
//   //                   );
//   //                 },
//   //               ),
//   //
//   //               // Image.asset(
//   //               //   AssetsManger.transferImage,
//   //               //   height: ScreenUtilNew.height(350),
//   //               //   width: ScreenUtilNew.width(274),
//   //               //   fit: BoxFit.contain,
//   //               // ),
//   //               SizedBox(height: ScreenUtilNew.height(24)),
//   //             ],
//   //           ),
//   //         ),
//   //       );
//   //     },
//   //   );
//   // }
//   void _settingModalBottomSheet(context,String imagePath) {
//     showModalBottomSheet(
//       context: context,
//       isDismissible: true,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(16.r), topRight: Radius.circular(16.r)),
//       ),
//       builder: (BuildContext bc) {
//         return SizedBox(
//           width: ScreenUtilNew.width(375),
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 SizedBox(height: ScreenUtilNew.height(24)),
//                 FastCachedImage(
//                   url: imagePath,
//                   fit: BoxFit.contain,
//                   width: ScreenUtilNew.width(340),
//                   fadeInDuration: const Duration(seconds: 1),
//                   errorBuilder: (context, exception, stacktrace) {
//                     return const Icon(Icons.error);
//                   },
//                   loadingBuilder: (context, progress) {
//                     return const Center(
//                       child: CircularProgressIndicator(
//                         color: AppColors.primaryColor,
//                         backgroundColor: AppColors.secondaryColor,
//                       ),
//                     );
//                   },
//                 ),
//                 SizedBox(height: ScreenUtilNew.height(24)),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
// }
//
//
//

import 'package:exchange/core/utils/app_colors.dart';
import 'package:exchange/features/home/bankTransfers/data/models/bank_transfer_model.dart';
import 'package:exchange/features/home/bankTransfers/domain/use_cases/get_accounts.dart';
import 'package:exchange/features/home/bankTransfers/presentation/manager/is_load_more_in_all_transactions.dart';
import 'package:exchange/features/home/bankTransfers/presentation/pages/update_transaction_bank.dart';
import 'package:exchange/features/home/bankTransfers/presentation/widgets/drop_down_get_users_filter.dart';
import 'package:exchange/features/home/home_screen.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:page_animation_transition/animations/bottom_to_top_transition.dart';
import 'package:page_animation_transition/animations/left_to_right_transition.dart';
import 'package:page_animation_transition/animations/right_to_left_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;
import '../../../../../config/routes/app_routes.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/assets_manger.dart';
import '../../../../../core/utils/screen_util_new.dart';
import '../../../dailyBoxes/presentation/widgets/widget_when_wating_data_drop_down_menu.dart';
import '../../data/models/account_model.dart';
import '../../data/models/beneficiarie_model.dart';
import '../../domain/use_cases/bank_transfer_controller.dart';
import '../../domain/use_cases/get_beneficiaries.dart';
import '../manager/filterd_or_not.dart';
import '../manager/is_loading_data_not_load_more.dart';
import '../widgets/drop_down_get_accounts_filter.dart';
import '../widgets/filterdialog_in_all_transactions.dart';
import '../widgets/widgte_transfer_bank_information.dart';

class AllTransactionsScreen extends StatefulWidget {
  const AllTransactionsScreen({super.key});

  @override
  State<AllTransactionsScreen> createState() => _AllTransactionsScreenState();
}

class _AllTransactionsScreenState extends State<AllTransactionsScreen> {
  final BankTransferController _controller = BankTransferController();
  List<BankTransferModel> bankTransfers = [];
  late ScrollController _scrollController;
  bool isLoadMore = false; // Define isLoadMore to manage the loading state
  String? currentStartDate;
  String? currentEndDate;
  String? currentSearch;
  String? currentAccountId;
  String? currentUserId;
  int page = 1;

  // bool filtred = false;

  @override
  void initState() {
    super.initState();
    Provider.of<FilterdOrNot>(context, listen: false).newValueIsFilter = false;
    Provider.of<IsLoadMoreInAllTransactions>(context, listen: false)
        .newValeIsLoadMore = false;
    _scrollController = ScrollController();
    _scrollController.addListener(
        _scrollListener); // Add a listener to the scroll controller
    _fetchInitialData(); // Fetch initial data when the screen loads
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget dialogFilter() {
    currentStartDate = null;
    currentEndDate = null;
    currentSearch = null;
    currentAccountId = null;
    currentUserId = null;
    final TextEditingController _startDateController = TextEditingController();
    final TextEditingController _endDateController = TextEditingController();
    final TextEditingController _searchController = TextEditingController();

    // This Part Date
    DateTime? selectedStartDate;
    DateTime? selectedEndDate;
    final ValueNotifier<String> _startDateTextValue =
        ValueNotifier<String>("قم باختيار تاريخ البدء");
    final ValueNotifier<String> _endDateTextValue =
        ValueNotifier<String>("قم باختيار تاريخ الانتهاء");

    Future<void> _selectStartDate(BuildContext context) async {
      final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
      );
      if (pickedDate != null && pickedDate != selectedStartDate) {
        selectedStartDate = pickedDate;
        _startDateTextValue.value =
            DateFormat('dd-MM-yyyy').format(selectedStartDate!);
        _startDateController.text = _startDateTextValue.value;
        print(_startDateController.text);
        currentStartDate = _startDateTextValue.value;
      }
    }

    Future<void> _selectEndDate(BuildContext context) async {
      final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
      );
      if (pickedDate != null && pickedDate != selectedEndDate) {
        selectedEndDate = pickedDate;
        _endDateTextValue.value =
            DateFormat('dd-MM-yyyy').format(selectedEndDate!);
        _endDateController.text =
            _endDateTextValue.value; // تحويل التاريخ إلى نص
        currentEndDate = _endDateTextValue.value;
      }
    }

    Widget _buildInputField({
      required String labelText,
      required TextEditingController controller,
      VoidCallback? onTap,
      ValueNotifier<String>? textValueNotifier,
    }) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          height: ScreenUtilNew.height(52),
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(0.08),
            borderRadius: BorderRadius.circular(5.r),
          ),
          child: Row(
            children: [
              SizedBox(width: ScreenUtilNew.width(8)),
              const Icon(Icons.date_range, color: AppColors.primaryColor),
              const Expanded(child: SizedBox()),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: ScreenUtilNew.width(8)),
                  child: ValueListenableBuilder<String>(
                    valueListenable: textValueNotifier!,
                    builder: (context, value, child) {
                      return Text(
                        value, // عرض القيمة الحالية للنص
                        style: GoogleFonts.cairo(
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp,
                          color: AppColors.primaryColor,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return AlertDialog(
      title: Center(
        child: Text(
          "فلترة البيانات",
          style: GoogleFonts.cairo(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            // Add input fields for start date, end date, search, account ID, and user ID
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Start Date Input Field
                _buildInputField(
                  labelText: "Start Date",
                  controller: _startDateController,
                  onTap: () {
                    _selectStartDate(context);
                  },
                  textValueNotifier: _startDateTextValue,
                ),
                SizedBox(
                  height: ScreenUtilNew.height(16),
                ),
                // End Date Input Field
                _buildInputField(
                  labelText: "End Date",
                  controller: _endDateController,
                  onTap: () {
                    _selectEndDate(context);
                    // selectedEndDate=_endDateController.text;
                    print(selectedEndDate);
                  },
                  textValueNotifier: _endDateTextValue,
                ),
                SizedBox(
                  height: ScreenUtilNew.height(16),
                ),
                // Search Input Field
                Container(
                  height: ScreenUtilNew.height(52),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  child: TextField(
                    controller: _searchController,
                    textDirection: ui.TextDirection.rtl,
                    onChanged: (value) => currentSearch = value,
                    decoration: InputDecoration(
                      hintTextDirection: ui.TextDirection.rtl,
                      hintText: "البحث",
                      hintStyle: GoogleFonts.cairo(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                        color: AppColors.primaryColor,
                      ),
                      contentPadding: EdgeInsets.only(
                          left: ScreenUtilNew.width(8),
                          right: ScreenUtilNew.width(8)),
                      border: InputBorder.none,
                    ),
                    style: GoogleFonts.cairo(
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            // TextField(
            //   decoration: InputDecoration(labelText: 'Start Date (YYYY-MM-DD)'),
            //   onChanged: (value) => currentStartDate = value,
            // ),
            // TextField(
            //   decoration: InputDecoration(labelText: 'End Date (YYYY-MM-DD)'),
            //   onChanged: (value) => currentEndDate = value,
            // ),
            // TextField(
            //   decoration: InputDecoration(labelText: 'Search'),
            //   onChanged: (value) => currentSearch = value,
            // ),
            // TextField(
            //   decoration: InputDecoration(labelText: 'Account ID'),
            //   onChanged: (value) => currentAccountId = value,
            // ),
            SizedBox(
              height: ScreenUtilNew.height(8),
            ),
            FutureBuilder<List<AccountModel>>(
                future: GetAccounts().fetchAccount(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      height: ScreenUtilNew.height(52),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: ScreenUtilNew.width(16),
                          ),
                          const Icon(
                            Icons.keyboard_arrow_down_outlined,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: ScreenUtilNew.width(16),
                          ),
                        ],
                      ),
                    );
                  } else if (snapshot.hasError) {
                    // في حالة حدوث خطأ
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Container(
                      height: ScreenUtilNew.height(52),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: ScreenUtilNew.width(8),
                          ),
                          const Icon(
                            Icons.keyboard_arrow_down_outlined,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: ScreenUtilNew.width(16),
                          ),
                        ],
                      ),
                    );
                  } else {
                    List<AccountModel> options = snapshot.data!;
                    return SizedBox(
                      width: double.infinity,
                      child: DropDownGetAccountsFilter(
                        options: options,
                        textTitle: "المصدر أو المستفيد",
                        selectedValueString: "",
                        onChanged: (selectedAccount) {
                          currentAccountId = "${selectedAccount!.id}";
                        },
                        selectDefaultValue: 0,
                      ),
                    );
                  }
                }),
            SizedBox(
              height: ScreenUtilNew.height(8),
            ),
            FutureBuilder<List<BeneficiarieModel>>(
              future: GetBeneficiaries().fetchData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    height: ScreenUtilNew.height(52),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: ScreenUtilNew.width(8),
                        ),
                        const Icon(
                          Icons.keyboard_arrow_down_outlined,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: ScreenUtilNew.width(16),
                        ),
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return DropDownWidgetGetUsersFilter(
                    defaultValueId: 0,
                    options: [
                      BeneficiarieModel(
                        id: 1,
                        name: "",
                      ),
                    ],
                    textTitle: AppStrings.addNewTransication7,
                    selectedValueString: '',
                    onChanged: (selectedAccount) {},
                    width: ScreenUtilNew.width(160),
                  );
                } else {
                  List<BeneficiarieModel> options = snapshot.data!;
                  return DropDownWidgetGetUsersFilter(
                    width: double.infinity,
                    options: options,
                    textTitle: AppStrings.addNewTransication7,
                    selectedValueString: '',
                    onChanged: (selectedAccount) {
                      currentUserId = "${selectedAccount!.id}";
                    },
                    defaultValueId: 0,
                  );
                }
              },
            ),

            // TextField(
            //   decoration: InputDecoration(labelText: 'User ID'),
            //   onChanged: (value) => currentUserId = value,
            // ),
          ],
        ),
      ),
      actions: [
        Row(
          children: [
            Flexible(
              child: GestureDetector(
                onTap: () {
                  // widget.onApply(startDate, endDate, search, accountId, userId);
                  _applyFilter(currentStartDate, currentEndDate, currentSearch,
                      currentAccountId, currentUserId);
                  Provider.of<FilterdOrNot>(context, listen: false)
                      .newValueIsFilter = true;
                  Navigator.of(context).pop();
                },
                child: Container(
                  height: ScreenUtilNew.height(47),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryColor,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Center(
                    child: Text(
                      "تطبيق",
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
            SizedBox(width: ScreenUtilNew.width(8)),
            // Add space between buttons
            Flexible(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    currentStartDate = null;
                    currentEndDate = null;
                    currentSearch = null;
                    currentAccountId = null;
                    currentUserId = null;
                  });
                  Navigator.pop(context);
                },
                child: Container(
                  height: ScreenUtilNew.height(47),
                  decoration: BoxDecoration(
                    color: const Color(0XFFFFE2E2),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Center(
                    child: Text(
                      "إلغاء",
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
          ],
        ),
        // TextButton(
        //   onPressed: () {
        //     // widget.onApply(startDate, endDate, search, accountId, userId);
        //     _applyFilter(currentStartDate, currentEndDate, currentSearch, currentAccountId, currentUserId);
        //     Provider.of<FilterdOrNot>(context, listen: false)
        //         .newValueIsFilter = true;
        //     Navigator.of(context).pop();
        //   },
        //   child: Text('Apply'),
        // ),
        // TextButton(
        //   onPressed: () {
        //     Navigator.of(context).pop();
        //   },
        //   child: Text('Cancel'),
        // ),
      ],
    );
  }

  void _fetchInitialData() async {
    Provider.of<IsLoadingDataNotLoadMore>(context, listen: false)
        .newValueLoading = true;
    List<BankTransferModel>? initialTransfers =
        await _controller.fetchDataBankTransfer(1);
    setState(() {
      bankTransfers = initialTransfers ?? [];
    });
    Provider.of<IsLoadingDataNotLoadMore>(context, listen: false)
        .newValueLoading = false;
  }

  void _loadMoreData() async {
    if (Provider.of<FilterdOrNot>(context, listen: false).isFilter) {
      _loadMoreDataWithFilter();
    } else {
      _loadMoreWithOutFilter();
    }
  }

  void _loadMoreWithOutFilter() async {
    page++;
    setState(() {
      Provider.of<IsLoadMoreInAllTransactions>(context, listen: false)
          .newValeIsLoadMore = true;
    });
    List<BankTransferModel>? moreTransfers =
        await _controller.fetchDataBankTransfer(
      page,
    );
    setState(() {
      if (moreTransfers != null) {
        bankTransfers
            .addAll(moreTransfers); // Add new items to the existing list
      }
      Provider.of<IsLoadMoreInAllTransactions>(context, listen: false)
          .newValeIsLoadMore = false;
    });
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      final filterdOrNot = Provider.of<FilterdOrNot>(context,
          listen: false); // Use listen: false here
      if (filterdOrNot.isFilter) {
        _loadMoreDataWithFilter();
        setState(() {});
        // _applyFilter(currentStartDate, currentEndDate, currentSearch, currentAccountId, currentUserId);
      } else {
        _loadMoreData();
        setState(() {});
      }
    }
  }

  // void _applyFilter(String? startDate, String? endDate, String? search,String? accountId, String? userId)async{
  //   List<BankTransferModel>? filteredTransfers =
  //       await _controller.fetchDataBankTransfer(
  //     page, // Use the calculated current page
  //     startDate: startDate,
  //     endDate: endDate,
  //     search: "api",
  //     accountId: accountId,
  //     userId: userId,
  //   );
  //   if(page==1&&filteredTransfers==null){
  //     setState(() {
  //       bankTransfers=filteredTransfers!;
  //
  //     });
  //   }else{
  //     setState(() {
  //       bankTransfers.addAll(filteredTransfers!);
  //     });
  //   }
  // }
  //
  // void _loadMoreData() async {
  //   if (!isLoadMore) {
  //     setState(() {
  //       isLoadMore = true;
  //     });
  //
  //     // Fetch more data based on the filters
  //     List<BankTransferModel>? moreTransfers =
  //         await _controller.fetchDataBankTransfer(
  //           bankTransfers.length ~/ 10 + 1,
  //       startDate: currentStartDate,
  //       endDate: currentEndDate,
  //       // Use the current end date
  //       search: currentSearch,
  //       // Use the current search term
  //       accountId: currentAccountId,
  //       // Use the current account ID
  //       userId: currentUserId, // Use the current user ID
  //     );
  //     // page=bankTransfers.length ~/ 10 + 1;
  //
  //     setState(() {
  //       if (moreTransfers != null) {
  //         // page = bankTransfers.length ~/ 10 + 1;
  //         bankTransfers.addAll(moreTransfers); // Add new items to the existing list
  //       }
  //       isLoadMore = false;
  //     });
  //   }
  // }

  void _loadMoreDataWithFilter() async {
    page++;
    setState(() {
      Provider.of<IsLoadMoreInAllTransactions>(context, listen: false)
          .newValeIsLoadMore = true;
    });
    List<BankTransferModel>? moreTransfers =
        await _controller.fetchDataBankTransfer(
      page,
      startDate: currentStartDate,
      endDate: currentEndDate,
      search: currentSearch,
      accountId: currentAccountId,
      userId: currentUserId,
    );
    setState(() {
      if (moreTransfers != null) {
        bankTransfers
            .addAll(moreTransfers); // Add new items to the existing list
      }
      Provider.of<IsLoadMoreInAllTransactions>(context, listen: false)
          .newValeIsLoadMore = false;
    });
  }

  void _applyFilter(String? startDate, String? endDate, String? search,
      String? accountId, String? userId) async {
    // Calculate the current page based on the number of existing transfers
    // int currentPage = (bankTransfers.length ~/ 10) + 1;
    setState(() {
      Provider.of<IsLoadingDataNotLoadMore>(context, listen: false)
          .newValueLoading = true;
    });
    // Fetch the filtered data
    List<BankTransferModel>? filteredTransfers =
        await _controller.fetchDataBankTransfer(
      page, // Use the calculated current page
      startDate: startDate,
      endDate: endDate,
      search: search,
      accountId: accountId,
      userId: userId,
    );

    setState(() {
      Provider.of<IsLoadingDataNotLoadMore>(context, listen: false)
          .newValueLoading = false;
      bankTransfers =
          filteredTransfers ?? []; // Reset list with filtered results
    });
  }

  void _clearFilters() {
    setState(() {
      currentStartDate = null; // Reset to null or default value
      currentEndDate = null; // Reset to null or default value
      currentSearch = null; // Reset to null or default value
      currentAccountId = null; // Reset to null or default value
      currentUserId = null; // Reset to null or default value
      bankTransfers = []; // Optionally reset the transfers list if needed
      Provider.of<FilterdOrNot>(context, listen: false).newValueIsFilter =
          false;
      _fetchInitialData(); // Re-fetch initial data
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Routes.addTransactionNewScreen);
        },
        backgroundColor: Colors.white,
        elevation: 10,
        child: const Icon(
          Icons.add,
          color: AppColors.secondaryColor,
        ),
      ),
      body: Column(
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
                      _clearFilters();
                    },
                    icon: const Icon(
                      Icons.update,
                      color: Colors.red,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      page = 1;
                      // print("${Provider.of<FilterdOrNot>(context,listen: false)
                      //     .isFilter}");
                      showDialog(
                          context: context,
                          builder: (context) => dialogFilter());
                    },
                    icon: const Icon(
                      Icons.filter_list_outlined,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
              Text(
                "جميع الحوالات",
                style: GoogleFonts.cairo(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(PageAnimationTransition(
                      page: HomeScreen(),
                      pageAnimationType: RightToLeftTransition(),
                    ));
                  },
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.primaryColor,
                  ))
            ],
          ),
          Padding(
            padding: EdgeInsets.only(right: ScreenUtilNew.width(16)),
            child: Align(
              alignment: Alignment.topRight,
              child: Text(
                AppStrings.allTransaction2,
                style: GoogleFonts.cairo(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
            ),
          ),
          SizedBox(height: ScreenUtilNew.height(8)),
          Expanded(
            child:
                // bankTransfers.isEmpty &&!isLoadMore
                //     ? const Center(
                //     child: CircularProgressIndicator(
                //       color: AppColors.primaryColor,
                //       backgroundColor: AppColors.secondaryColor,
                //     ))
                //     :
                bankTransfers.isNotEmpty &&
                        Provider.of<IsLoadingDataNotLoadMore>(context,
                                    listen: false)
                                .isLoad ==
                            false
                    ? ListView.builder(
                        padding: EdgeInsets.zero,
                        controller: _scrollController,
                        itemCount: bankTransfers.length + (isLoadMore ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index < bankTransfers.length) {
                            return Column(
                              children: [
                                SizedBox(
                                  height: ScreenUtilNew.height(16),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: ScreenUtilNew.width(16)),
                                  child: Slidable(
                                    startActionPane: ActionPane(
                                      motion: const ScrollMotion(),
                                      children: [
                                        SlidableAction(
                                          onPressed: (value) {
                                            _settingModalBottomSheet(context,
                                                bankTransfers[index].image!);
                                          },
                                          backgroundColor: AppColors
                                              .primaryColor
                                              .withOpacity(0.08),
                                          foregroundColor:
                                              AppColors.secondaryColor,
                                          icon: Icons.remove_red_eye,
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(5.r),
                                              bottomRight:
                                                  Radius.circular(5.r)),
                                          label: 'View transfer',
                                        ),
                                      ],
                                    ),
                                    endActionPane: ActionPane(
                                      motion: ScrollMotion(),
                                      children: [
                                        SlidableAction(
                                          onPressed: (value) {
                                            Navigator.of(context).push(
                                                PageAnimationTransition(
                                                    page: UpdateTransactionBank(
                                                      refNumberController:
                                                          bankTransfers[index]
                                                              .refNumber!,
                                                      accountIdController:
                                                          bankTransfers[index]
                                                              .accountId!,
                                                      userIdController:
                                                          bankTransfers[index]
                                                              .userId!,
                                                      nameReceiveController:
                                                          bankTransfers[index]
                                                              .nameReceive!,
                                                      dateController:
                                                          bankTransfers[index]
                                                              .date!,
                                                      amountController:
                                                          bankTransfers[index]
                                                              .amount!,
                                                      currencyController:
                                                          bankTransfers[index]
                                                              .currency!,
                                                      notesController:
                                                          bankTransfers[index]
                                                              .notes!,
                                                      imagePath:
                                                          bankTransfers[index]
                                                              .image!,
                                                      id: "${bankTransfers[index].id!}",
                                                    ),
                                                    pageAnimationType:
                                                        LeftToRightTransition()));
                                          },
                                          backgroundColor: AppColors
                                              .primaryColor
                                              .withOpacity(0.08),
                                          foregroundColor:
                                              AppColors.secondaryColor,
                                          icon: Icons.mode_edit,
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(5.r),
                                              bottomRight:
                                                  Radius.circular(5.r)),
                                          label: 'Update Transfer',
                                        ),
                                      ],
                                    ),
                                    child: WidgetTransferBankInformation(
                                      id: bankTransfers[index].id!,
                                      amount: bankTransfers[index].amount!,
                                      accountId:
                                          bankTransfers[index].accountId!,
                                      accountName:
                                          bankTransfers[index].accountName!,
                                      currency: bankTransfers[index].currency!,
                                      date: bankTransfers[index].date!,
                                      image: bankTransfers[index].image!,
                                      nameReceive:
                                          bankTransfers[index].nameReceive!,
                                      notes: bankTransfers[index].notes!,
                                      refNumber:
                                          bankTransfers[index].refNumber!,
                                      status: bankTransfers[index].status!,
                                      userId: bankTransfers[index].userId!,
                                      userName: bankTransfers[index].userName!,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                          // else{
                          //   return const Center(
                          //     child: CircularProgressIndicator(
                          //       color: AppColors.primaryColor,
                          //       backgroundColor: AppColors.secondaryColor,
                          //     ),
                          //   );
                          // }
                        },
                      )
                    : bankTransfers.isEmpty &&
                            Provider.of<IsLoadingDataNotLoadMore>(context)
                                    .isLoad ==
                                false
                        ? Center(
                            child: Text(
                            "لا يوجد بيانات لعرضها",
                            style: GoogleFonts.cairo(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.secondaryColor),
                          ))
                        : Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primaryColor,
                              backgroundColor: AppColors.secondaryColor,
                            ),
                          ),
          ),
          Consumer<IsLoadMoreInAllTransactions>(
              builder: (context, provider, child) {
            return provider.isLoadMore
                ? const CircularProgressIndicator(
                    color: AppColors.primaryColor,
                    backgroundColor: AppColors.secondaryColor,
                  )
                : SizedBox(
                    height: ScreenUtilNew.height(8),
                  );
          }),
        ],
      ),
    );
  }

  void _settingModalBottomSheet(context, String imagePath) {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.r), topRight: Radius.circular(16.r)),
      ),
      builder: (BuildContext bc) {
        return SizedBox(
          width: ScreenUtilNew.width(375),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: ScreenUtilNew.height(24)),
                FastCachedImage(
                  url: imagePath,
                  fit: BoxFit.contain,
                  width: ScreenUtilNew.width(340),
                  fadeInDuration: const Duration(seconds: 1),
                  errorBuilder: (context, exception, stacktrace) {
                    return const Icon(Icons.error);
                  },
                  loadingBuilder: (context, progress) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                        backgroundColor: AppColors.secondaryColor,
                      ),
                    );
                  },
                ),
                SizedBox(height: ScreenUtilNew.height(24)),
              ],
            ),
          ),
        );
      },
    );
  }
}

// class _AllTransactionsScreenState extends State<AllTransactionsScreen> {
//   final ScrollController scrollController = ScrollController();
//   List<BankTransferModel> bankTransfer = [];
//   int page = 1;
//   bool isLoading = false;
//   bool isLoadMore = false;
//   bool allDataLoaded = false; // للتحقق من ما إذا تم تحميل كل البيانات
//
//   @override
//   void initState() {
//     super.initState();
//     scrollController.addListener(_scrollListener);
//     _fetchData(page);
//   }
//
//   @override
//   void dispose() {
//     scrollController.dispose();
//     super.dispose();
//   }
//
//   Future<void> _scrollListener() async {
//     if (scrollController.position.pixels ==
//         scrollController.position.maxScrollExtent &&
//         !isLoadMore &&
//         !allDataLoaded) {
//       // تحميل المزيد من البيانات عند الوصول لنهاية القائمة
//       setState(() {
//         isLoadMore = true;
//       });
//       await _fetchData(page + 1);
//       setState(() {
//         isLoadMore = false;
//       });
//     }
//   }
//
//   Future<void> _fetchData(int pageNumber) async {
//     if (isLoading || allDataLoaded) return;
//
//     setState(() {
//       isLoading = true;
//     });
//
//     List<BankTransferModel>? newItems =
//     await BankTransferController().fetchDataBankTransfer(pageNumber);
//
//     if (newItems != null && newItems.isNotEmpty) {
//       setState(() {
//         page = pageNumber;
//         bankTransfer.addAll(newItems);
//       });
//     } else {
//       setState(() {
//         allDataLoaded = true; // لا توجد المزيد من البيانات للتحميل
//       });
//     }
//
//     setState(() {
//       isLoading = false;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.pushNamed(context, Routes.addTransactionNewScreen);
//         },
//         backgroundColor: Colors.white,
//         elevation: 10,
//         child: const Icon(
//           Icons.add,
//           color: AppColors.secondaryColor,
//         ),
//       ),
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         automaticallyImplyLeading: false,
//         centerTitle: true,
//         leading: IconButton(
//           onPressed: () {},
//           icon: const Icon(
//             Icons.filter_list_rounded,
//             color: AppColors.primaryColor,
//           ),
//         ),
//         actions: [
//           IconButton(
//             onPressed: () {
//               Navigator.pushReplacementNamed(context, Routes.homeScreen);
//             },
//             icon: const Icon(
//               Icons.arrow_forward,
//               color: Colors.black,
//             ),
//           ),
//         ],
//         title: Text(
//           AppStrings.allTransaction1,
//           style: GoogleFonts.cairo(
//             fontSize: 16.sp,
//             fontWeight: FontWeight.bold,
//             color: AppColors.primaryColor,
//           ),
//         ),
//       ),
//       body: Column(
//         children: [
//           SizedBox(height: ScreenUtilNew.height(8)),
//           Padding(
//             padding: EdgeInsets.only(right: ScreenUtilNew.width(16)),
//             child: Align(
//               alignment: Alignment.topRight,
//               child: Text(
//                 AppStrings.allTransaction2,
//                 style: GoogleFonts.cairo(
//                     fontSize: 14.sp,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.black),
//               ),
//             ),
//           ),
//           SizedBox(height: ScreenUtilNew.height(8)),
//           Expanded(
//             child: bankTransfer.isEmpty && isLoading
//                 ? const Center(
//                 child: CircularProgressIndicator(
//                   color: AppColors.primaryColor,
//                   backgroundColor: AppColors.secondaryColor,
//                 ))
//                 : ListView.builder(
//               controller: scrollController,
//               itemCount: bankTransfer.length + (isLoadMore ? 1 : 0),
//               itemBuilder: (context, index) {
//                 if (index < bankTransfer.length) {
//                   return Column(
//                     children: [
//                       SizedBox(
//                         height: ScreenUtilNew.height(16),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.symmetric(
//                             horizontal: ScreenUtilNew.width(16)),
//                         child: Slidable(
//                           startActionPane: ActionPane(
//                             motion: const ScrollMotion(),
//                             children: [
//                               SlidableAction(
//                                 onPressed: (value) {
//                                   _settingModalBottomSheet(context,bankTransfer[index].image!);
//                                 },
//                                 backgroundColor:
//                                 AppColors.primaryColor.withOpacity(0.08),
//                                 foregroundColor: AppColors.secondaryColor,
//                                 icon: Icons.remove_red_eye,
//                                 borderRadius: BorderRadius.only(
//                                     topRight: Radius.circular(5.r),
//                                     bottomRight: Radius.circular(5.r)),
//                                 label: 'View transfer',
//                               ),
//
//                             ],
//                           ),
//
//                           // The end action pane is the one at the right or the bottom side.
//                           endActionPane: ActionPane(
//                             motion: ScrollMotion(),
//                             children: [
//                               SlidableAction(
//                                 onPressed: (value) {
//                                   Navigator.of(context).push(PageAnimationTransition(page: UpdateTransactionBank(
//                                     refNumberController: bankTransfer[index].refNumber!,
//                                     accountIdController:bankTransfer[index].accountId!,
//                                     userIdController: bankTransfer[index].userId!,
//                                     nameReceiveController: bankTransfer[index].nameReceive!,
//                                     dateController: bankTransfer[index].date!,
//                                     amountController: bankTransfer[index].amount!,
//                                     currencyController: bankTransfer[index].currency!,
//                                     notesController: bankTransfer[index].notes!,
//                                     imagePath: bankTransfer[index].image!, id:"${bankTransfer[index].id!}" ,
//                                   ), pageAnimationType: LeftToRightTransition()));
//
//                                 },
//                                 backgroundColor:
//                                 AppColors.primaryColor.withOpacity(0.08),
//                                 foregroundColor: AppColors.secondaryColor,
//                                 icon: Icons.mode_edit,
//                                 borderRadius: BorderRadius.only(
//                                     topRight: Radius.circular(5.r),
//                                     bottomRight: Radius.circular(5.r)),
//                                 label: 'Update Transfer',
//                               ),
//                             ],
//                           ),
//
//                           child: WidgetTransferBankInformation(
//                             id: bankTransfer[index].id!,
//                             amount: bankTransfer[index].amount!,
//                             accountId: bankTransfer[index].accountId!,
//                             accountName: bankTransfer[index].accountName!,
//                             currency: bankTransfer[index].currency!,
//                             date: bankTransfer[index].date!,
//                             image: bankTransfer[index].image!,
//                             nameReceive:  bankTransfer[index].nameReceive!,
//                             notes:  bankTransfer[index].notes!,
//                             refNumber:  bankTransfer[index].refNumber!,
//                             status:  bankTransfer[index].status!,
//                             userId:  bankTransfer[index].userId!,
//                             userName:  bankTransfer[index].userName!,
//                           ),
//                         ),
//                       ),
//                     ],
//                   );
//                 } else {
//                   return const SizedBox
//                       .shrink(); // لا تعرض شيئًا إذا لم يكن هناك تحميل
//                 }
//               },
//             ),
//           ),
//           if (isLoadMore) // Show CircularProgressIndicator when loading more data
//             Padding(
//               padding: EdgeInsets.symmetric(vertical: 16.h),
//               child: CircularProgressIndicator(
//                 color: AppColors.primaryColor,
//                 backgroundColor: AppColors.secondaryColor,
//               ),
//             ),
//         ],
//       ),
//     );
//   }
//   // void _settingModalBottomSheet(context,String imagePath) {
//   //   showModalBottomSheet(
//   //     context: context,
//   //     isDismissible: false,
//   //     shape: RoundedRectangleBorder(
//   //       borderRadius: BorderRadius.only(
//   //           topLeft: Radius.circular(16.r), topRight: Radius.circular(16.r)),
//   //     ),
//   //     builder: (BuildContext bc) {
//   //       return SizedBox(
//   //         // height: ScreenUtilNew.height(400),
//   //         width: ScreenUtilNew.width(375),
//   //         child: SingleChildScrollView(
//   //           child: Column(
//   //             mainAxisSize: MainAxisSize.min,
//   //             children: [
//   //               SizedBox(height: ScreenUtilNew.height(24)),
//   //               // Image.network(imagePath,  height: ScreenUtilNew.height(350),
//   //               //   width: ScreenUtilNew.width(274),
//   //               // fit: BoxFit.contain,),
//   //               FastCachedImage(
//   //                 url: imagePath, // رابط الصورة
//   //                 fit: BoxFit.cover, // تناسب الصورة مع الحاوية
//   //                 fadeInDuration: const Duration(seconds: 1), // تأثير التلاشي عند التحميل
//   //                 errorBuilder: (context, exception, stacktrace) {
//   //                   // يتم عرض هذا عند حدوث خطأ أثناء التحميل
//   //                   return const Icon(Icons.error); // رمز الخطأ الافتراضي أو يمكنك إضافة صورة افتراضية
//   //                 },
//   //                 loadingBuilder: (context, progress) {
//   //                   // يتم عرض هذا عند التحميل
//   //                   return const Center(
//   //                     child: CircularProgressIndicator(), // عرض مؤشر التحميل أثناء التحميل
//   //                   );
//   //                 },
//   //               ),
//   //
//   //               // Image.asset(
//   //               //   AssetsManger.transferImage,
//   //               //   height: ScreenUtilNew.height(350),
//   //               //   width: ScreenUtilNew.width(274),
//   //               //   fit: BoxFit.contain,
//   //               // ),
//   //               SizedBox(height: ScreenUtilNew.height(24)),
//   //             ],
//   //           ),
//   //         ),
//   //       );
//   //     },
//   //   );
//   // }
//   void _settingModalBottomSheet(context,String imagePath) {
//     showModalBottomSheet(
//       context: context,
//       isDismissible: true,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(16.r), topRight: Radius.circular(16.r)),
//       ),
//       builder: (BuildContext bc) {
//         return SizedBox(
//           width: ScreenUtilNew.width(375),
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 SizedBox(height: ScreenUtilNew.height(24)),
//                 FastCachedImage(
//                   url: imagePath,
//                   fit: BoxFit.contain,
//                   width: ScreenUtilNew.width(340),
//                   fadeInDuration: const Duration(seconds: 1),
//                   errorBuilder: (context, exception, stacktrace) {
//                     return const Icon(Icons.error);
//                   },
//                   loadingBuilder: (context, progress) {
//                     return const Center(
//                       child: CircularProgressIndicator(
//                         color: AppColors.primaryColor,
//                         backgroundColor: AppColors.secondaryColor,
//                       ),
//                     );
//                   },
//                 ),
//                 SizedBox(height: ScreenUtilNew.height(24)),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
// }
//
//
