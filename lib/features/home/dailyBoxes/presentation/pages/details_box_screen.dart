import 'package:exchange/config/routes/app_routes.dart';
import 'package:exchange/core/utils/app_colors.dart';
import 'package:exchange/core/utils/assets_manger.dart';
import 'package:exchange/core/utils/context_extension.dart';
import 'package:exchange/core/utils/screen_util_new.dart';
import 'package:exchange/features/home/dailyBoxes/data/models/data_type_process.dart';
import 'package:exchange/features/home/dailyBoxes/data/models/get_transaction_by_id_box.dart';
import 'package:exchange/features/home/dailyBoxes/presentation/pages/box_screen.dart';
import 'package:exchange/features/home/dailyBoxes/presentation/pages/filter_transactions.dart';
import 'package:exchange/features/home/dailyBoxes/presentation/pages/process_drop_down.dart';
import 'package:exchange/features/home/dailyBoxes/presentation/pages/update_process.dart';
import 'package:exchange/features/home/dailyBoxes/presentation/widgets/drop_down_select_source.dart';
import 'package:exchange/features/home/dailyBoxes/presentation/widgets/widget_detalis_box_process.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:page_animation_transition/animations/bottom_to_top_faded_transition.dart';
import 'package:page_animation_transition/animations/left_to_right_transition.dart';
import 'package:page_animation_transition/animations/right_to_left_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;
import '../../../../../core/utils/app_strings.dart';
import '../../../bankTransfers/presentation/widgets/widget_when_wating_data_drop_down_menu.dart';
import '../../data/models/get_sources_controller.dart';
import '../../data/models/show_transaction_model.dart';
import '../../domain/use_cases/get_sources.dart';
import '../../domain/use_cases/get_transactions.dart';
import '../manager/providers/name_service_controller.dart';
import '../manager/providers/selectdata_list_process_provider.dart';
import '../widgets/column_data_widget_process_details.dart';
import '../widgets/cost_process_widget.dart';
import '../widgets/drop_down_filter_source.dart';

class DetailsBoxScreen extends StatefulWidget {
  DetailsBoxScreen({super.key, required this.idBox, required this.nameBox});

  int idBox;
  String nameBox;

  @override
  State<DetailsBoxScreen> createState() => _DetailsBoxScreenState();
}

class _DetailsBoxScreenState extends State<DetailsBoxScreen>
    with SingleTickerProviderStateMixin {
  List<TransactionDataByIdBox> transactions = [];
  DataTypeProcess? selectedProcess; // متغير لتخزين القيمة المحددة

  String? startDate;
  String? endDate;
  String? search;
  String? sourceId;
  String? type;
  bool isLoading = false;
  bool status=false;
  bool status2=false;
  final FocusNode _focusNode = FocusNode();

  List<DataTypeProcess> dataListProcess = [
    DataTypeProcess(id: "0", name: "اختر نوع العملية"),
    DataTypeProcess(id: "1", name: "سحب"),
    DataTypeProcess(id: "2", name: "إيداع"),
    DataTypeProcess(id: "3", name: "سلفة"),
    DataTypeProcess(id: "4", name: "غير مرحلة"),
  ];

  @override
  void initState() {
    super.initState();
    Provider.of<SelectdataListProcessProvider>(context,listen: false).newDataTypeProcess=DataTypeProcess(id: "0", name: "اختر نوع العملية");
    _applyFilter();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _focusNode.dispose();
    super.dispose();
  }
  void _showFilterDialog() {
    status=false;
    status2=false;
    // startDate=null;
    // endDate=null;
    // search=null;
    // sourceId=null;
    // type=null;
    // selectedProcess=null;
    // Provider.of<SelectdataListProcessProvider>(context).newDataTypeProcess=null;
    final TextEditingController _startDateController =
    TextEditingController(text: startDate);
    final TextEditingController _endDateController =
    TextEditingController(text: endDate);
    final TextEditingController _searchController =
    TextEditingController(text: search);

    // This Part Date
    DateTime? selectedStartDate;
    DateTime? selectedEndDate;
    final ValueNotifier<String> _startDateTextValue = ValueNotifier<String>(
        startDate == null ? "تاريخ البدء" : "$startDate");
    final ValueNotifier<String> _endDateTextValue = ValueNotifier<String>(
        endDate == null ? "تاريخ الانتهاء" : "$endDate");

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
        _startDateController.text =
            _startDateTextValue.value;
        print(_startDateController.text);
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
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String? selectedType;
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
              mainAxisSize: MainAxisSize.min,
              children: [
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
                    TextField(
                      controller: _searchController,
                      textDirection: ui.TextDirection.rtl,
                      onChanged: (value) => search = value,
                      decoration: InputDecoration(
                        fillColor: AppColors.primaryColor.withOpacity(0.08),
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.r),
                            borderSide: BorderSide.none
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.r),
                            borderSide: BorderSide.none
                        ),
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
                    // Container(
                    //   height: ScreenUtilNew.height(52),
                    //   width: double.infinity,
                    //   decoration: BoxDecoration(
                    //     color:AppColors.primaryColor.withOpacity(0.08),
                    //   borderRadius: BorderRadius.circular(5.r),
                    //   ),
                    //   child: TextField(
                    //     controller: _searchController,
                    //     textDirection: ui.TextDirection.rtl,
                    //     decoration: InputDecoration(
                    //       hintTextDirection: ui.TextDirection.rtl,
                    //       hintText: "البحث",
                    //       hintStyle: GoogleFonts.cairo(
                    //         fontWeight: FontWeight.w400,
                    //         fontSize: 16.sp,
                    //         color: AppColors.primaryColor,
                    //       ),
                    //       contentPadding: EdgeInsets.only(left: ScreenUtilNew.width(8),right: ScreenUtilNew.width(8)),
                    //       border: InputBorder.none,
                    //     ),
                    //     style: GoogleFonts.cairo(
                    //       fontWeight: FontWeight.w400,
                    //       fontSize: 16.sp,
                    //       color: AppColors.primaryColor,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                SizedBox(height: ScreenUtilNew.height(16),),
                FutureBuilder(
                    future: ApiControllerSourcesBox().fetchData(widget.idBox),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Container(
                          height: ScreenUtilNew.height(52),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color:AppColors.primaryColor.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: ScreenUtilNew.width(16),),
                              const Icon(Icons.keyboard_arrow_down_outlined,color: Colors.black,),
                              SizedBox(width: ScreenUtilNew.width(16),),
                            ],
                          ),
                        );
                      } else if (snapshot.hasError) {
                        // في حالة حدوث خطأ
                        return Center(
                            child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData ||
                          snapshot.data!.isEmpty) {
                        return Container(
                          height: ScreenUtilNew.height(52),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color:AppColors.primaryColor.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: ScreenUtilNew.width(8),),
                              const Icon(Icons.keyboard_arrow_down_outlined,color: Colors.black,),
                              SizedBox(width: ScreenUtilNew.width(16),),
                            ],
                          ),
                        );
                      } else {
                        List<DataSources> options=[DataSources(id: 0,name: "اختر المصدر...")];
                         options.addAll(snapshot.data!);
                        return SizedBox(
                          width: double.infinity,
                          child: DropDownFilterSource(
                            options: options,
                            textTitle: "المصدر أو المستفيد",
                            selectedValueString: "",
                            onChanged: (selectedAccount) {
                              if(selectedAccount!.id!=0){
                                sourceId="${selectedAccount.id}";
                              }else{
                                sourceId=null;
                              }
                            },
                            selectDefaultValue: int.tryParse(sourceId??"0")??0,
                          ),
                        );
                      }
                    }),
                SizedBox(height: ScreenUtilNew.height(16),),
            Center(
              child: Consumer<SelectdataListProcessProvider>(
                builder: (context, provider, child) {
                  return ProcessDropdown(
                    selectedValue: provider.dataTypeProcess,
                    onChanged: (value) {
                      status=true;
                      if(status){
                        setState(() {
                          if(provider.dataTypeProcess.id!="0"){
                            type=provider.dataTypeProcess.id;
                            print(type);
                          }else{
                            type=null;
                            print(type);
                          }
                        });
                      }
                    },
                    dataListProcess: dataListProcess,
                  );
                },
              ),
            ),

                // Consumer<SelectdataListProcessProvider>(builder: (context,provider,child){
                //   return ProcessDropdown(
                //     selectedValue:provider.dataTypeProcess, // تمرير القيمة المختارة
                //     onChanged: (DataTypeProcess? value) {
                //       // setState(() {
                //       //   provider.newDataTypeProcess=value!;
                //       //   selectedProcess = value; // تحديث القيمة المختارة
                //       //   // if (selectedProcess != null) {
                //       //   //   type="${selectedProcess!.id}";
                //       //   // }
                //       // });
                //     },
                //     dataListProcess: dataListProcess, // تمرير قائمة العمليات
                //   );
                // })
              ],
            ),
          ),
          actions: [
            Row(
              children: [
                Flexible(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        startDate = _startDateController.text;
                        endDate = _endDateController.text;
                        search = _searchController.text;
                      });
                      _applyFilter();
                      Navigator.pop(context);
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
                SizedBox(width: ScreenUtilNew.width(8)), // Add space between buttons
                Flexible(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        status = false;
                        status2 = false;
                        startDate = null;
                        endDate = null;
                        search = null;
                        sourceId = null;
                        type = null;
                        selectedProcess = null;
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
          ],

          // actions: [
          //   Expanded(
          //     child: GestureDetector(
          //       onTap: (){
          //         setState(() {
          //           startDate = _startDateController.text;
          //           endDate = _endDateController.text;
          //           search = _searchController.text;
          //         });
          //         _applyFilter();
          //         Navigator.pop(context);
          //       },
          //       child: Container(
          //         height: ScreenUtilNew.height(47),
          //         decoration: BoxDecoration(
          //           color: AppColors.secondaryColor,
          //           borderRadius: BorderRadius.circular(8.r),
          //         ),
          //         child: Center(
          //           child: Text(
          //             "تطبيق",
          //             style: GoogleFonts.cairo(
          //               fontSize: 14.sp,
          //               color: Colors.white,
          //               fontWeight: FontWeight.bold,
          //             ),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          //   SizedBox(height: ScreenUtilNew.height(8),),
          //   Expanded(
          //     child: GestureDetector(
          //       onTap: (){
          //         setState(() {
          //           status=false;
          //           status2=false;
          //           startDate=null;
          //           endDate=null;
          //           search=null;
          //           sourceId=null;
          //           type=null;
          //           selectedProcess=null;
          //         });
          //
          //         // Navigator.pop(context);
          //       },
          //       child: Container(
          //         height: ScreenUtilNew.height(47),
          //         decoration: BoxDecoration(
          //           color: const Color(0XFFFFE2E2),
          //           borderRadius: BorderRadius.circular(8.r),
          //         ),
          //         child: Center(
          //           child: Text(
          //             "تفريغ",
          //             style: GoogleFonts.cairo(
          //               fontSize: 14.sp,
          //               color: const Color(0XFFFF0000),
          //               fontWeight: FontWeight.bold,
          //             ),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ],
        );
      },
    );
  }


  void _clearFilter() {
    setState(() {
      startDate = null;
      endDate = null;
      search = null;
      sourceId = null;
      type = null;
    });
    _applyFilter();
  }
  String? errorMessage;

  void _applyFilter() async {
    setState(() {
      isLoading = true;
      errorMessage = null; // Reset error message
    });

    try {
      transactions = await GetTransactions().fetchTransactions(
        widget.idBox,
        startDate: startDate,
        endDate: endDate,
        sourceId: sourceId,
        search: search,
        type: type,
      );

      // Check if the response indicates no data
      if (transactions.isEmpty) {
        errorMessage = "لا يوجد بيانات بهذا الفلتر."; // No data message
      }
    } catch (e) {
      print("Error applying filter: $e");
      if (e.toString().contains("404")) {
        errorMessage = "لا يوجد بيانات بهذه البيانات التي أدخلتها."; // Specific error message for 404
      } else {
        errorMessage = "حدث خطأ أثناء تحميل البيانات."; // General error message
      }
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(PageAnimationTransition(
            page: BoxScreen(idBox: widget.idBox, nameBox: widget.nameBox),
            pageAnimationType: RightToLeftTransition(),
          ));
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
                    onPressed: _clearFilter,
                    icon: const Icon(
                      Icons.update,
                      color: Colors.red,
                    ),
                  ),
                  IconButton(
                    onPressed: _showFilterDialog,
                    icon: const Icon(
                      Icons.filter_list_outlined,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
              Text(
                widget.nameBox,
                style: GoogleFonts.cairo(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(PageAnimationTransition(
                      page: BoxScreen(idBox: widget.idBox, nameBox: widget.nameBox),
                      pageAnimationType: RightToLeftTransition(),
                    ));                  },
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.primaryColor,
                  ))
            ],
          ),
          // Show loading indicator while fetching data
          if (isLoading)
            const Center(child: CircularProgressIndicator(
              color: AppColors.primaryColor,
              backgroundColor: AppColors.secondaryColor,
            )),
          // Display error message if applicable
          if (errorMessage != null)
            Center(
              child: Text(
                errorMessage!,
                style: GoogleFonts.cairo(
                  fontSize: 16.sp,
                  color: AppColors.secondaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          // Only display transactions if there are any
          if (!isLoading && errorMessage == null && transactions.isNotEmpty)
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                physics: const BouncingScrollPhysics(),
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  var transaction = transactions[index];
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
                                  Provider.of<NameServiceController>(context,
                                      listen: false)
                                      .nameServiceNew =
                                      transaction.serviceName ?? "لا يوجد";
                                  // if(transaction.type != 4){
                                  //   context.showSnackBar(message: "لا يمكن تعديل عملية مكتملة", erorr: true);
                                  // }else{
                                    Future<bool> isSourceAvailable(int id, String sourceName) async {
                                      List<DataSources>? sources = await ApiControllerSourcesBox().fetchData(id);
                                      if (sources == null || sources.isEmpty) {
                                        print('No data found or an error occurred.');
                                        return false;
                                      }
                                      bool sourceExists = sources.any((source) => source.name== sourceName);
                                      if (sourceExists) {
                                        Navigator.of(context).push(PageAnimationTransition(
                                          page: UpdateProcess(
                                            numberProcess:
                                            transaction.number ?? "لا يوجد",
                                            sourceId: transaction.sourceId ?? 0,
                                            commission: transaction.commission ?? "0",
                                            amount: transaction.amount ?? "0",
                                            increaseAmount:
                                            transaction.increaseAmount ?? "0",
                                            total: transaction.total ?? "0",
                                            notes: transaction.notes ?? "لا يوجد",
                                            idBox: widget.idBox,
                                            serviceName:
                                            transaction.serviceName ?? "لا يوجد",
                                            id: transaction.id ?? 0,
                                            typeName: transaction.typeName ?? "لا يوجد",
                                            typeId: transaction.type ?? 0,
                                            boxName: widget.nameBox, commissionid: transaction.commissionId,
                                          ),
                                          pageAnimationType: RightToLeftTransition(),
                                        ));
                                        print('Source "$sourceName" exists.');
                                        return true;
                                      } else {
                                        context.showSnackBar(message: "المصدر غير مفعل",erorr: true);
                                        print('Source "$sourceName" does not exist.');
                                        return false;
                                      }
                                    }
                                    isSourceAvailable(widget.idBox,transaction.sourceName!);
                                  // }

                                  // transaction.type != 4
                                  //     ? context.showSnackBar(message: "لا يمكن تعديل عملية مكتملة", erorr: true)
                                  //     : Navigator.of(context).push(
                                  //   PageAnimationTransition(
                                  //     page: UpdateProcess(
                                  //       numberProcess:
                                  //       transaction.number ?? "لا يوجد",
                                  //       sourceId: transaction.sourceId ?? 0,
                                  //       commission: transaction.commission ?? "0",
                                  //       amount: transaction.amount ?? "0",
                                  //       increaseAmount:
                                  //       transaction.increaseAmount ?? "0",
                                  //       total: transaction.total ?? "0",
                                  //       notes: transaction.notes ?? "لا يوجد",
                                  //       idBox: widget.idBox,
                                  //       serviceName:
                                  //       transaction.serviceName ?? "لا يوجد",
                                  //       id: transaction.id ?? 0,
                                  //       typeName: transaction.typeName ?? "لا يوجد",
                                  //       typeId: transaction.type ?? 0,
                                  //       boxName: widget.nameBox, commissionid: transaction.commissionId,
                                  //     ),
                                  //     pageAnimationType: RightToLeftTransition(),
                                  //   ),
                                  // );
                                 
                                },
                                backgroundColor:
                                AppColors.primaryColor.withOpacity(0.08),
                                foregroundColor: AppColors.secondaryColor,
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
                            numberProcess: transaction.number ?? "لا يوجد",
                            commission: transaction.commission ?? "0",
                            typeProcess: transaction.typeName ?? "لا يوجد",
                            serviceName: transaction.serviceName ?? 'لا يوجد',
                            increaseAmount: transaction.increaseAmount ?? "0",
                            source: transaction.sourceName ?? "لا يوجد",
                            amount: transaction.amount ?? "لا يوجد",
                            total: transaction.total ?? "0",
                            notes: transaction.notes ?? 'لا يوجد',
                            backgroundColor: transaction.type == 4
                                ? AppColors.secondaryColor
                                : AppColors.primaryColor,
                          ),
                        ),
                      ),
                      if (index == transactions.length - 1)
                        SizedBox(height: ScreenUtilNew.height(16)),
                    ],
                  );
                },
              ),
            ),
          // Display a message when no transactions are available
          if (!isLoading && errorMessage == null && transactions.isEmpty)
            Center(
              child: Text(
                "لا يوجد عمليات لعرضها لهذا الصندوق",
                style: GoogleFonts.cairo(
                  fontSize: 16.sp,
                  color: AppColors.secondaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
    );
  }

}