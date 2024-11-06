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
import 'package:exchange/features/home/bankTransfers/presentation/manager/is_load_more_in_all_transactions.dart';
import 'package:exchange/features/home/bankTransfers/presentation/pages/update_transaction_bank.dart';
import 'package:exchange/features/home/home_screen.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_animation_transition/animations/bottom_to_top_transition.dart';
import 'package:page_animation_transition/animations/left_to_right_transition.dart';
import 'package:page_animation_transition/animations/right_to_left_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';
import 'package:provider/provider.dart';

import '../../../../../config/routes/app_routes.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/assets_manger.dart';
import '../../../../../core/utils/screen_util_new.dart';
import '../../domain/use_cases/bank_transfer_controller.dart';
import '../manager/filterd_or_not.dart';
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

  void _fetchInitialData() async {
    List<BankTransferModel>? initialTransfers =
        await _controller.fetchDataBankTransfer(page);
    setState(() {
      bankTransfers = initialTransfers ?? [];
    });
  }

  void _loadMoreData()async {
    page++;
    setState(() {
      Provider.of<IsLoadMoreInAllTransactions>(context,listen: false).newValeIsLoadMore=true;
    });
    List<BankTransferModel>? moreTransfers =
        await _controller.fetchDataBankTransfer(
      page,
    );
    setState(() {
      if (moreTransfers != null) {
        bankTransfers.addAll(moreTransfers); // Add new items to the existing list
      }
      Provider.of<IsLoadMoreInAllTransactions>(context,listen: false).newValeIsLoadMore=false;
    });
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      final filterdOrNot = Provider.of<FilterdOrNot>(context, listen: false);  // Use listen: false here
      if (filterdOrNot.isFilter) {
        // _applyFilter(currentStartDate, currentEndDate, currentSearch, currentAccountId, currentUserId);
      } else {
        _loadMoreData();
        setState(() {
        });
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

  // void _applyFilter(String? startDate, String? endDate, String? search,
  //     String? accountId, String? userId) async {
  //   // Calculate the current page based on the number of existing transfers
  //   int currentPage = (bankTransfers.length ~/ 10) + 1;
  //   setState(() {
  //     isLoadMore = true;
  //   });
  //   // Fetch the filtered data
  //   List<BankTransferModel>? filteredTransfers =
  //       await _controller.fetchDataBankTransfer(
  //         page, // Use the calculated current page
  //     startDate: startDate,
  //     endDate: endDate,
  //     search: search,
  //     accountId: accountId,
  //     userId: userId,
  //   );
  //
  //   setState(() {
  //     isLoadMore = true;
  //     bankTransfers =
  //         filteredTransfers ?? []; // Reset list with filtered results
  //   });
  // }

  // void _clearFilters() {
  //   setState(() {
  //     currentStartDate = null; // Reset to null or default value
  //     currentEndDate = null; // Reset to null or default value
  //     currentSearch = null; // Reset to null or default value
  //     currentAccountId = null; // Reset to null or default value
  //     currentUserId = null; // Reset to null or default value
  //     bankTransfers = []; // Optionally reset the transfers list if needed
  //     Provider.of<FilterdOrNot>(context,listen: false).newValueIsFilter=false;
  //     _fetchInitialData(); // Re-fetch initial data
  //   });
  // }

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
                      Provider.of<FilterdOrNot>(context, listen: false)
                          .newValueIsFilter = false;
                    },
                    icon: const Icon(
                      Icons.update,
                      color: Colors.red,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      page=1;
                      Provider.of<FilterdOrNot>(context, listen: false)
                          .newValueIsFilter = true;
                      // showDialog(
                      //   context: context,
                      //   builder: (context) => FilterDialog(
                      //     onApply:
                      //         _applyFilter, // Pass the apply filter function
                      //   ),
                      // );
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
                bankTransfers.isNotEmpty
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
                          } else {
                            // If we are loading more data, show a loading indicator
                            return const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primaryColor,
                                backgroundColor: AppColors.secondaryColor,
                              ),
                            );
                          }
                        },
                      )
                    : const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                          backgroundColor: AppColors.secondaryColor,
                        ),
                      ),
          ),
          Consumer<IsLoadMoreInAllTransactions>(builder: (context,provider,child){
            return provider.isLoadMore?const CircularProgressIndicator(
              color: AppColors.primaryColor,
              backgroundColor: AppColors.secondaryColor,
            ):SizedBox(height: ScreenUtilNew.height(8),);
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
