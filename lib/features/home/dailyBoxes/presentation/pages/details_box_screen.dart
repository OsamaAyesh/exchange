import 'package:exchange/config/routes/app_routes.dart';
import 'package:exchange/core/utils/app_colors.dart';
import 'package:exchange/core/utils/assets_manger.dart';
import 'package:exchange/core/utils/screen_util_new.dart';
import 'package:exchange/features/home/dailyBoxes/data/models/get_transaction_by_id_box.dart';
import 'package:exchange/features/home/dailyBoxes/presentation/pages/box_screen.dart';
import 'package:exchange/features/home/dailyBoxes/presentation/pages/update_process.dart';
import 'package:exchange/features/home/dailyBoxes/presentation/widgets/widget_detalis_box_process.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_animation_transition/animations/right_to_left_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';
import 'package:provider/provider.dart';

import '../../../../../core/utils/app_strings.dart';
import '../../data/models/show_transaction_model.dart';
import '../../domain/use_cases/get_transactions.dart';
import '../manager/providers/name_service_controller.dart';
import '../widgets/column_data_widget_process_details.dart';
import '../widgets/cost_process_widget.dart';

class DetailsBoxScreen extends StatefulWidget {
  DetailsBoxScreen({super.key, required this.idBox, required this.nameBox});

  int idBox;
  String nameBox;

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
          Navigator.of(context).push(PageAnimationTransition(
              page: BoxScreen(idBox: widget.idBox, nameBox: widget.nameBox),
              pageAnimationType: RightToLeftTransition()));
        },
        backgroundColor: Colors.white,
        elevation: 10,
        child: const Icon(
          Icons.add,
          color: AppColors.secondaryColor,
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_forward))
        ],
        centerTitle: true,
        title: Text(
          widget.nameBox,
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
            child: FutureBuilder<List<TransactionDataByIdBox>>(
              future: GetTransactions().fetchTransactions(widget.idBox),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                    backgroundColor: AppColors.secondaryColor,
                  )); // يظهر مؤشر التحميل أثناء الانتظار
                } else if (snapshot.hasError) {
                  return Center(
                      child:
                          Text('Error: ${snapshot.error}')); // يعرض خطأ إذا حدث
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                      child: Text(
                          'No transactions found.')); // يظهر إذا لم توجد بيانات
                }

                List<TransactionDataByIdBox> data = snapshot.data!;

                List<TransactionDataByIdBox> completedTransactions = data
                    .where((transaction) => transaction.type != 4)
                    .toList(); // العمليات المكتملة
                List<TransactionDataByIdBox> otherTransactions = data
                    .where((transaction) => transaction.type == 4)
                    .toList(); // العمليات الغير المكتملة
                print(completedTransactions.length);
                print(otherTransactions.length);

                return TabBarView(
                  controller: _tabController,
                  children: [
                    otherTransactions.isNotEmpty
                        ? ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: otherTransactions.length,
                            itemBuilder: (context, index) {
                              var transaction = otherTransactions[index];
                              return Column(
                                children: [
                                  SizedBox(height: ScreenUtilNew.height(16)),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: ScreenUtilNew.width(16)),
                                    child: Slidable(
                                      endActionPane: ActionPane(
                                        motion: const ScrollMotion(),
                                        children: [
                                          SlidableAction(
                                            onPressed: (value) {
                                              Provider.of<NameServiceController>(context, listen: false).nameServiceNew=transaction.serviceName ?? "لا يوجد";
                                              print(transaction.type);
                                              print(transaction.typeName);
                                              Navigator.of(context).push(PageAnimationTransition(page:  UpdateProcess(numberProcess: transaction.number ?? "لا يوجد", sourceId:  transaction.sourceId??0, commission: transaction.commission ?? "0", amount: transaction.amount ?? "0", increaseAmount: transaction.increaseAmount ?? "0", total: transaction.total ?? "0", notes: transaction.notes ?? "لا يوجد", idBox: widget.idBox, serviceName:  transaction.serviceName ?? "لا يوجد", id: transaction.id ?? 0,typeName:  transaction.typeName??"لا يوجد", typeId: transaction.type??0, boxName: widget.nameBox,), pageAnimationType: RightToLeftTransition()));
                                            },
                                            backgroundColor: AppColors
                                                .primaryColor
                                                .withOpacity(0.08),
                                            foregroundColor:
                                                AppColors.secondaryColor,
                                            icon: Icons.mode_edit,
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(5.r),
                                              bottomRight: Radius.circular(5.r),
                                            ),
                                            label: 'Update',
                                          ),
                                        ],
                                      ),
                                      child: WidgetDetailsBoxProcess(
                                        numberProcess:
                                            transaction.number ?? "لا يوجد",
                                        commission:
                                            transaction.commission ?? "0",
                                        typeProcess:
                                            transaction.typeName ?? "لا يوجد",
                                        serviceName: transaction.serviceName ??
                                            'لا يوجد',
                                        increaseAmount:
                                            transaction.increaseAmount ?? "0",
                                        source:
                                            transaction.sourceName ?? "لا يوجد",
                                        amount: transaction.amount ?? "لا يوجد",
                                        total: transaction.total ?? "0",
                                        notes: transaction.notes ?? 'لا يوجد',
                                      ),
                                    ),
                                  ),
                                  if (index == completedTransactions.length - 1)
                                    SizedBox(height: ScreenUtilNew.height(16)),
                                ],
                              );
                            },
                          )
                        : Center(
                            child: Text(
                              "لا يوجد عمليات غير مكتملة لعرضها",
                              style: GoogleFonts.cairo(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.secondaryColor,
                              ),
                            ),
                          ),
                    completedTransactions.isNotEmpty
                        ? ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: completedTransactions.length,
                            itemBuilder: (context, index) {
                              var transaction = completedTransactions[index];
                              return Column(
                                children: [
                                  SizedBox(height: ScreenUtilNew.height(16)),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: ScreenUtilNew.width(16)),
                                    child: Slidable(
                                      endActionPane: ActionPane(
                                        motion: ScrollMotion(),
                                        children: [
                                          SlidableAction(
                                            onPressed: (value) {
                                              Provider.of<NameServiceController>(context, listen: false).nameServiceNew=transaction.serviceName ?? "لا يوجد";
                                              print(transaction.type);
                                              print(transaction.typeName);
                                              Navigator.of(context).push(PageAnimationTransition(page: UpdateProcess(idBox: widget.idBox,numberProcess: transaction.number ?? "لا يوجد", sourceId:  transaction.sourceId??0, commission: transaction.commission ?? "0", amount: transaction.amount ?? "0", increaseAmount: transaction.increaseAmount ?? "0", total: transaction.total ?? "0", notes: transaction.notes ?? "لا يوجد", serviceName:  transaction.serviceName ?? "لا يوجد", id: transaction.id ?? 0, typeName: transaction.typeName??"لا يوجد", typeId: transaction.type??0, boxName: widget.nameBox,), pageAnimationType: RightToLeftTransition()));
                                            },
                                            backgroundColor: AppColors
                                                .primaryColor
                                                .withOpacity(0.08),
                                            foregroundColor:
                                                AppColors.secondaryColor,
                                            icon: Icons.mode_edit,
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(5.r),
                                              bottomRight: Radius.circular(5.r),
                                            ),
                                            label: 'Update',
                                          ),
                                        ],
                                      ),
                                      child: WidgetDetailsBoxProcess(
                                        numberProcess:
                                            transaction.number ?? "لا يوجد",
                                        commission:
                                            transaction.commission ?? "0",
                                        typeProcess:
                                            transaction.typeName ?? "لا يوجد",
                                        serviceName: transaction.serviceName ??
                                            'لا يوجد',
                                        increaseAmount:
                                            transaction.increaseAmount ?? "0",
                                        source:
                                            transaction.sourceName ?? "لا يوجد",
                                        amount: transaction.amount ?? "لا يوجد",
                                        total: transaction.total ?? "0",
                                        notes: transaction.notes ?? 'لا يوجد',
                                      ),
                                    ),
                                  ),
                                  if (index == completedTransactions.length - 1)
                                    SizedBox(height: ScreenUtilNew.height(16)), // فقط هنا
                                ],
                              );
                            },
                          )
                        : Center(
                            child: Text(
                              "لا يوجد عمليات مكتملة لعرضها",
                              style: GoogleFonts.cairo(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.secondaryColor,
                              ),
                            ),
                          ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
