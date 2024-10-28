import 'package:exchange/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../../core/utils/assets_manger.dart';
import '../../../../../core/utils/screen_util_new.dart';
import '../../data/models/salary_model.dart';
import '../../domain/use_cases/get_salary.dart';
import '../widgets/column_data_widget_process_details.dart';
import 'dart:ui' as ui;

class SalaryPage extends StatefulWidget {
  @override
  _SalaryPageState createState() => _SalaryPageState();
}

class _SalaryPageState extends State<SalaryPage> {
  List<DataSalary> salaries = [];
  int page = 1;
  bool isLoading = false;
  bool isLoadingMore = false; // لمتابعة تحميل المزيد من البيانات
  final ScrollController _scrollController = ScrollController();

  String? startDate;
  String? endDate;
  String? search;

  @override
  void initState() {
    super.initState();
    _fetchSalaries();

    // إضافة مستمع عند الوصول إلى نهاية القائمة
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !isLoadingMore) {
        _loadMoreSalaries();
      }
    });
  }

  Future<void> _fetchSalaries(
      {String? startDate, String? endDate, String? search}) async {
    setState(() => isLoading = true);

    List<DataSalary>? fetchedSalaries = await GetSalary().fetchSalaries(
      page,
      startDate: startDate,
      endDate: endDate,
      search: search,
    );

    setState(() {
      if (fetchedSalaries != null) {
        salaries = fetchedSalaries;
      }
      isLoading = false;
    });
  }

  Future<void> _loadMoreSalaries() async {
    setState(() => isLoadingMore = true);
    page += 1; // زيادة رقم الصفحة

    List<DataSalary>? fetchedSalaries = await GetSalary().fetchSalaries(
      page,
      startDate: startDate,
      endDate: endDate,
      search: search,
    );

    setState(() {
      if (fetchedSalaries != null && fetchedSalaries.isNotEmpty) {
        salaries.addAll(
            fetchedSalaries); // إضافة البيانات الجديدة إلى القائمة الحالية
      }
      isLoadingMore = false;
    });
  }

  void _openFilterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController _startDateController =
            TextEditingController(text: startDate);
        final TextEditingController _endDateController =
            TextEditingController(text: endDate);
        final TextEditingController _searchController =
            TextEditingController(text: search);

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
            _startDateController.text =
                _startDateTextValue.value; // تحويل التاريخ إلى نص
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

        // Function to build styled input containers
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
                color: const Color(0XFFEBF7F1),
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
          content: Column(
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
              SizedBox(height: ScreenUtilNew.height(16),),
              // End Date Input Field
              _buildInputField(
                labelText: "End Date",
                controller: _endDateController,
                onTap: () {
                  _selectEndDate(context);
                },
                textValueNotifier: _endDateTextValue,
              ),
              SizedBox(height: ScreenUtilNew.height(16),),
              // Search Input Field
              Container(
                height: ScreenUtilNew.height(52),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0XFFEBF7F1),
                  borderRadius: BorderRadius.circular(5.r),
                ),
                child: TextField(
                  controller: _searchController,
                  textDirection: ui.TextDirection.rtl,
                  decoration:  InputDecoration(
                    hintTextDirection:  ui.TextDirection.rtl,
                    hintText: "البحث",
                    hintStyle: GoogleFonts.cairo(
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp,
                      color: AppColors.primaryColor,
                    ),
                    contentPadding: EdgeInsets.only(left: 8.0),
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
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  startDate = _startDateController.text;
                  endDate = _endDateController.text;
                  search = _searchController.text;
                  page = 1; // إعادة تعيين رقم الصفحة عند تطبيق فلتر جديد
                  salaries.clear(); // مسح القائمة الحالية
                });
                _fetchSalaries(
                  startDate: startDate,
                  endDate: endDate,
                  search: search,
                );
                Navigator.of(context).pop();
              },
              child: Text("تطبيق",style: GoogleFonts.cairo(
                fontSize: 16.sp,
                color: AppColors.primaryColor,
              ),),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("إلغاء",style: GoogleFonts.cairo(
                fontSize: 16.sp,
                color: Colors.red,
              ),),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      // Clear filters and fetch all data
                      setState(() {
                        startDate = null;
                        endDate = null;
                        search = null;
                        page = 1; // إعادة تعيين الصفحة عند مسح الفلتر
                        salaries.clear(); // مسح البيانات الحالية
                      });
                      _fetchSalaries();
                    },
                    icon: const Icon(
                      Icons.update,
                      color: Colors.red,
                    ),
                  ),
                  IconButton(
                    onPressed: _openFilterDialog,
                    icon: const Icon(
                      Icons.filter_list_outlined,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
              Text(
                "الرواتب والسلف",
                style: GoogleFonts.cairo(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
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
                "قائمة الحركات المالية",
                style: GoogleFonts.cairo(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          SizedBox(
            height: ScreenUtilNew.height(16),
          ),
          Expanded(
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                      backgroundColor: AppColors.secondaryColor,
                    ),
                  )
                : ListView.builder(
                    controller: _scrollController,
                    padding: EdgeInsets.zero,
                    itemCount: salaries.length + (isLoadingMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == salaries.length) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                            backgroundColor: AppColors.secondaryColor,
                          ),
                        ); // إظهار مؤشر تحميل المزيد
                      }
                      final salary = salaries[index];

                      return Stack(children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: ScreenUtilNew.width(16),
                              right: ScreenUtilNew.width(16),
                              bottom: ScreenUtilNew.height(16)),
                          child: Container(
                            // height: ScreenUtilNew.height(122),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.r),
                              color: AppColors.primaryColor,
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: ScreenUtilNew.height(8),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: ScreenUtilNew.width(16)),
                                  child: Container(
                                    height: ScreenUtilNew.height(48),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(5.r)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "الرصــــــــــــــيــــد",
                                          style: GoogleFonts.cairo(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.secondaryColor,
                                          ),
                                          maxLines: 1,
                                          textAlign: TextAlign.right,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(
                                          height: ScreenUtilNew.height(4),
                                        ),
                                        Text(
                                          "${salary.balance}",
                                          style: GoogleFonts.cairo(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.secondaryColor,
                                          ),
                                          maxLines: 2,
                                          textAlign: TextAlign.right,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          ColumnDataWidgetProcessDetails(
                                            title: "الملاحظات",
                                            subTitle: "${salary.notes}",
                                            maxLines: 5,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          ColumnDataWidgetProcessDetails(
                                            title: "المبلغ",
                                            subTitle: "${salary.amount}",
                                            maxLines: 1,
                                          ),
                                          ColumnDataWidgetProcessDetails(
                                            title: "التاريخ",
                                            subTitle: "${salary.date}",
                                            maxLines: 1,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          ColumnDataWidgetProcessDetails(
                                            title: "النوع",
                                            subTitle: "${salary.type}",
                                            maxLines: 1,
                                          ),
                                          ColumnDataWidgetProcessDetails(
                                            title: "وصف النوع",
                                            subTitle:
                                                "${salary.typeDescription}",
                                            maxLines: 1,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: ScreenUtilNew.height(8),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Image.asset(
                          AssetsManger.detailsWidgetBackground,
                          height: ScreenUtilNew.height(57),
                          width: ScreenUtilNew.width(61),
                          fit: BoxFit.fill,
                        ),
                      ]);

                    },
                  ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController
        .dispose(); // التخلص من الـ ScrollController عند تدمير الصفحة
    super.dispose();
  }
}
