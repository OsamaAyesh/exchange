



























import 'dart:io';

import 'package:exchange/config/routes/app_routes.dart';
import 'package:exchange/core/utils/app_colors.dart';
import 'package:exchange/core/utils/context_extension.dart';
import 'package:exchange/core/utils/screen_util_new.dart';
import 'package:exchange/features/home/bankTransfers/data/models/account_model.dart';
import 'package:exchange/features/home/bankTransfers/data/models/beneficiarie_model.dart';
import 'package:exchange/features/home/bankTransfers/data/models/currency_model.dart';
import 'package:exchange/features/home/bankTransfers/domain/use_cases/get_beneficiaries.dart';
import 'package:exchange/features/home/bankTransfers/domain/use_cases/get_currencies_controller.dart';
import 'package:exchange/features/home/bankTransfers/presentation/manager/image_path_provider_controller.dart';
import 'package:exchange/features/home/bankTransfers/presentation/manager/is_loading_add_transaction_provider.dart';
import 'package:exchange/features/home/bankTransfers/presentation/widgets/drop_down_widget_text_field_account.dart';
import 'package:exchange/features/home/bankTransfers/presentation/widgets/drop_down_widget_text_field_beneficiarie.dart';
import 'package:exchange/features/home/bankTransfers/presentation/widgets/text_field_cusomized_box_screen_widget.dart';
import 'package:exchange/features/home/bankTransfers/presentation/widgets/widget_when_wating_data_drop_down_menu.dart';

import 'package:exchange/features/home/profile/presentation/widgets/elevated_button_custom_data_and_password_updated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart'; // لاستعمال تنسيق التاريخ
import 'package:provider/provider.dart';

import '../../../../../core/utils/app_strings.dart';
import '../../domain/use_cases/get_accounts.dart';
import '../../domain/use_cases/store_transfer_controller.dart';
import '../widgets/drop_down_widget_text_field_currency.dart';
import 'dart:ui' as ui;
import 'package:image/image.dart' as img;

class AddTransactionNewScreen extends StatefulWidget {
  const AddTransactionNewScreen({super.key});

  @override
  State<AddTransactionNewScreen> createState() =>
      _AddTransactionNewScreenState();
}

class _AddTransactionNewScreenState extends State<AddTransactionNewScreen> {
  final ImagePicker _picker = ImagePicker();
  bool isLoading = false;

  late TextEditingController _refNumberController ;
  late TextEditingController _accountIdController ;
  late TextEditingController _userIdController ;
  late TextEditingController _nameReceiveController ;
  late TextEditingController _dateController ;
  late TextEditingController _amountController ;
  late TextEditingController _currencyController ;
  late TextEditingController _notesController ;

  final StoreTransferControllerApi _controller = StoreTransferControllerApi();

  // Future<void> _pickAndShowImage(BuildContext context) async {
  //   final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     // تحديث مسار الصورة المحددة في الـ Provider
  //     Provider.of<ImagePathProviderController>(context, listen: false)
  //         .imagePathSet = pickedFile.path; // احفظ مسار الصورة المحددة
  //   }
  // }
  // Future<void> _compressAndSaveImage(String imagePath, BuildContext context) async {
  //   // ضغط الصورة
  //   final compressedImage = await FlutterImageCompress.compressWithFile(
  //     imagePath,
  //     quality: 20, // نسبة الجودة (من 0 إلى 100)
  //   );
  //
  //   if (compressedImage != null) {
  //     // حفظ الصورة المضغوطة في ملف جديد
  //     final compressedFile = File('${Directory.systemTemp.path}/compressed_${imagePath.split('/').last}');
  //     await compressedFile.writeAsBytes(compressedImage);
  //
  //     // تحديث مسار الصورة المحددة في الـ Provider
  //     Provider.of<ImagePathProviderController>(context, listen: false)
  //         .imagePathSet = compressedFile.path; // احفظ مسار الصورة المضغوطة
  //   }
  // }
  // Future<void> _pickAndShowImage(BuildContext context) async {
  //   // إظهار حوار لتحديد مصدر الصورة
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('اختر مصدر الصورة',
  //           style: GoogleFonts.cairo(
  //             fontWeight: FontWeight.w500,
  //
  //           ),
  //         textAlign: TextAlign.right,
  //         textDirection: ui.TextDirection.rtl,),
  //         content: SingleChildScrollView(
  //           child: ListBody(
  //             children: <Widget>[
  //               ListTile(
  //                 leading: const Icon(Icons.camera),
  //                 title: Text('التقاط صورة من الكاميرا',
  //                   style: GoogleFonts.cairo(
  //                     color: AppColors.secondaryColor,
  //                     fontWeight: FontWeight.w400,
  //                   ),
  //                   textAlign: TextAlign.right,
  //                   textDirection: ui.TextDirection.rtl,),
  //                 onTap: () async {
  //                   final pickedFile =
  //                       await _picker.pickImage(source: ImageSource.camera);
  //                   if (pickedFile != null) {
  //                     // تحديث مسار الصورة المحددة في الـ Provider
  //                     // Provider.of<ImagePathProviderController>(context,
  //                     //             listen: false)
  //                     //         .imagePathSet =
  //                     //     pickedFile.path;
  //                     _compressAndSaveImage(pickedFile.path,context);// احفظ مسار الصورة المحددة
  //                   }
  //                   Navigator.of(context).pop(); // إغلاق الحوار
  //                 },
  //               ),
  //               ListTile(
  //                 leading: Icon(Icons.image),
  //                 title: Text(
  //                   'اختيار صورة من المعرض',
  //                   style: GoogleFonts.cairo(
  //                     fontWeight: FontWeight.w400,
  //                       color:   AppColors.secondaryColor
  //
  //                   ),
  //                   textAlign: TextAlign.right,
  //                   textDirection: ui.TextDirection.rtl,
  //                 ),
  //                 onTap: () async {
  //                   // Navigator.of(context).pop(); // إغلاق الحوار
  //                   final pickedFile =
  //                       await _picker.pickImage(source: ImageSource.gallery);
  //                   if (pickedFile != null) {
  //                     // تحديث مسار الصورة المحددة في الـ Provider
  //                     Provider.of<ImagePathProviderController>(context,
  //                                 listen: false)
  //                             .imagePathSet =
  //                         pickedFile.path; // احفظ مسار الصورة المحددة
  //                   }
  //                   Navigator.of(context).pop(); // إغلاق الحوار
  //                 },
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  Future<void> _pickAndShowImage(BuildContext context) async {
    // إظهار حوار لتحديد مصدر الصورة
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'اختر مصدر الصورة',
            style: GoogleFonts.cairo(
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.right,
            textDirection: ui.TextDirection.rtl,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.camera),
                  title: Text(
                    'التقاط صورة من الكاميرا',
                    style: GoogleFonts.cairo(
                      color: AppColors.secondaryColor,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.right,
                    textDirection: ui.TextDirection.rtl,
                  ),
                  onTap: ()async {
                    final pickedFile =
                    await _picker.pickImage(source: ImageSource.camera);
                    if (pickedFile != null) {
                      // ضغط الصورة بعد التقاطها
                      final compressedImage = await FlutterImageCompress.compressWithFile(
                        pickedFile.path, // استخدام مسار الصورة بدلاً من الاسم
                        quality: 50, // نسبة الجودة (من 0 إلى 100)
                      );
                      // تأكد من أن الصورة المضغوطة ليست فارغة قبل التحديث
                      if (compressedImage != null) {
                        // حفظ الصورة المضغوطة في ملف جديد
                        final compressedFile = File('${Directory.systemTemp.path}/compressed_${pickedFile.name}');
                        await compressedFile.writeAsBytes(compressedImage);
                        // تحديث مسار الصورة المحددة في الـ Provider
                        Provider.of<ImagePathProviderController>(context, listen: false)
                            .imagePathSet = compressedFile.path; // احفظ مسار الصورة المضغوطة
                      }
                    }
                    Navigator.of(context).pop(); // إغلاق الحوار قبل اختيار الصورةس
                  },
                ),
                ListTile(
                  leading: Icon(Icons.image),
                  title: Text(
                    'اختيار صورة من المعرض',
                    style: GoogleFonts.cairo(
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondaryColor,
                    ),
                    textAlign: TextAlign.right,
                    textDirection: ui.TextDirection.rtl,
                  ),
                  onTap: () async {
                    final pickedFile =
                    await _picker.pickImage(source: ImageSource.gallery);
                    if (pickedFile != null) {
                      // ضغط الصورة بعد اختيارها من المعرض
                      Provider.of<ImagePathProviderController>(context,
                                        listen: false)
                                    .imagePathSet =
                                pickedFile.path;
                    }
                    Navigator.of(context).pop(); // إغلاق الحوار قبل اختيار الصورة


                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

// دالة لضغط الصورة وحفظها
  Future<void> _compressAndSaveImage(String imagePath, BuildContext context) async {
    // ضغط الصورة
    final compressedImage = await FlutterImageCompress.compressWithFile(
      imagePath,
      quality: 20, // نسبة الجودة (من 0 إلى 100)
    );

    if (compressedImage != null) {
      // حفظ الصورة المضغوطة في ملف جديد
      final compressedFile = File('${Directory.systemTemp.path}/compressed_${imagePath.split('/').last}');
      await compressedFile.writeAsBytes(compressedImage);

      // تحديث مسار الصورة المحددة في الـ Provider
      context.read<ImagePathProviderController>().imagePathSet = compressedFile.path; // احفظ مسار الصورة المضغوطة
    }
  }
  void submitTransaction(BuildContext context) async {
    Provider.of<IsLoadingAddTransactionProvider>(context, listen: false)
        .isLoadingSet = true;

    final imagePath =
        Provider.of<ImagePathProviderController>(context, listen: false)
            .pathImageTransaction;
    if (imagePath == null) {
      // إذا كان مسار الصورة فارغًا، يمكنك معالجة الخطأ هنا
      context.showSnackBar(message: "يرجى اختيار صورة.", erorr: true);
      Provider.of<IsLoadingAddTransactionProvider>(context, listen: false)
          .isLoadingSet = false;
      return; // إنهاء الدالة
    }

    final response = await _controller.postTransaction(
      refNumber: _refNumberController.text,
      accountId: _accountIdController.text,
      userId: _userIdController.text,
      nameReceive: _nameReceiveController.text,
      date: _dateController.text,
      amount: double.tryParse(_amountController.text) ?? 0.0,
      currency: _currencyController.text,
      notes: _notesController.text,
      imagePath: imagePath, // استخدم هنا القيمة التي تم التحقق منها
    );

    // إعادة تعيين حالة التحميل إلى false بعد الانتهاء من العملية
    Provider.of<IsLoadingAddTransactionProvider>(context, listen: false)
        .isLoadingSet = false;

    if (response != null) {
      if (response['status'] == 200) {
        if (response['message'] == "تم عملية الحفظ بنجاح") {
          Navigator.pushReplacementNamed(context, Routes.allTransactionScreen);
          context.showSnackBar(message: response['message'], erorr: false);
        } else {
          context.showSnackBar(message: response['message'], erorr: true);
        }
      } else {
        // التعامل مع الأخطاء
        String errorMessage = 'Error: ${response['message']}';
        if (response['data'] != null) {
          response['data'].forEach((key, value) {
            errorMessage += '\n$key: ${value.join(', ')}'; // تجميع الأخطاء
          });
        }
        context.showSnackBar(message: errorMessage, erorr: true);
      }
    } else {
      // في حالة فشل الاتصال بالخادم
      context.showSnackBar(
          message: "فشل في تقديم المعاملة. يرجى المحاولة مرة أخرى.",
          erorr: false);
    }
  }

  //This Part Date
  DateTime? selectedDate;
  final ValueNotifier<String> _textValue =
      ValueNotifier<String>("قم باختيار التاريخ");

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      selectedDate = pickedDate;
      _textValue.value = DateFormat('yyyy-MM-dd').format(selectedDate!);
      _dateController.text = _textValue.value; // تحويل التاريخ إلى نص
      print(_dateController);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<ImagePathProviderController>(context, listen: false)
        .imagePathSet = "";
    _refNumberController = TextEditingController();
    _accountIdController = TextEditingController();
    _userIdController = TextEditingController();
    _nameReceiveController = TextEditingController();
    _dateController = TextEditingController();
    _amountController = TextEditingController();
    _currencyController = TextEditingController();
    _notesController = TextEditingController();
    super.initState();
  }

  // Future<void> _pickAndShowImage(BuildContext context) async {
  //   final ImagePicker _picker = ImagePicker();
  //
  //   // إظهار حوار لتحديد مصدر الصورة
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('اختر مصدر الصورة'),
  //         content: SingleChildScrollView(
  //           child: ListBody(
  //             children: <Widget>[
  //               ListTile(
  //                 leading: Icon(Icons.camera),
  //                 title: Text('التقاط صورة من الكاميرا'),
  //                 onTap: () async {
  //                   Navigator.of(context).pop(); // إغلاق الحوار
  //                   final pickedFile = await _picker.pickImage(source: ImageSource.camera);
  //                   if (pickedFile != null) {
  //                     // تحديث مسار الصورة المحددة في الـ Provider
  //                     Provider.of<ImagePathProviderController>(context, listen: false)
  //                         .imagePathSet = pickedFile.path;                     }
  //                 },
  //               ),
  //               ListTile(
  //                 leading: Icon(Icons.image),
  //                 title: Text('اختيار صورة من المعرض'),
  //                 onTap: () async {
  //                   Navigator.of(context).pop(); // إغلاق الحوار
  //                   _pickAndShowImage1(context);
  //                 },
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    // void _submit() async {
    //   // تعيين حالة التحميل إلى true
    //   Provider.of<IsLoadingAddTransactionProvider>(context, listen: false).isLoadingSet = true;
    //
    //   // حاول رفع المعاملة
    //   final success = await _controller.postTransaction(
    //     refNumber: _refNumberController.text,
    //     accountId: _accountIdController.text,
    //     userId: _userIdController.text,
    //     nameReceive: _nameReceiveController.text,
    //     date: _dateController.text,
    //     amount: double.tryParse(_amountController.text) ?? 0.0,
    //     currency: _currencyController.text,
    //     notes: _notesController.text,
    //     imagePath: Provider.of<ImagePathProviderController>(context, listen: false).pathImageTransaction!, // استخدام listen: false هنا
    //   );
    //
    //   // تعيين حالة التحميل إلى false
    //   Provider.of<IsLoadingAddTransactionProvider>(context, listen: false).isLoadingSet = false;
    //
    //   // إظهار رسالة النجاح أو الفشل
    //   if (success) {
    //     context.showSnackBar(message: "تمت عملية الاضافة بنجاح", erorr: true);
    //     Navigator.pushReplacementNamed(context, Routes.allTransactionScreen);
    //   } else {
    //     context.showSnackBar(message: "فشل تسجيل العملية", erorr: true);
    //   }
    // }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_forward,
            ),
          ),
        ],
        title: Text(
          AppStrings.addNewTransication1,
          style: GoogleFonts.cairo(
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
            color: AppColors.primaryColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: ScreenUtilNew.width(16)),
                child: Text(
                  AppStrings.addNewTransication2,
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
                hintText: AppStrings.addNewTransication3,
                width: double.infinity,
                filledColor: AppColors.primaryColor.withOpacity(0.08),
                enabled: true,
                textFiledDiscount: false,
                iconData: Icons.add,
                styleHintText: GoogleFonts.cairo(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                textEditingController: _refNumberController,
                maxLines: 2,
                minLines: 1, keyboardType: TextInputType.number,
              ),
            ),
            SizedBox(
              height: ScreenUtilNew.height(8),
            ),
            FutureBuilder<List<AccountModel>>(
              future: GetAccounts().fetchAccount(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtilNew.width(16)),
                      child: WidgetWhenWatingDataDropDownMenu(
                          textTitle: AppStrings.addNewTransication4,
                          width: double.infinity));
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtilNew.width(16)),
                    child: DropDownWidgetTextFieldAccount(
                      selectDefaultValue: 0,
                      options: [
                        AccountModel(id: 1, name: "", status: 1),
                      ],
                      textTitle: AppStrings.addNewTransication4,
                      selectedValueString: '',
                      onChanged: (selectedAccount) {},
                    ),
                  );
                } else {
                  List<AccountModel> options=[AccountModel(id: 0, name: "اختر المحول...", status: 1)];
                  options.addAll(snapshot.data!);
                  // List<AccountModel> options = snapshot.data!;
                  return Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtilNew.width(16)),
                    child: DropDownWidgetTextFieldAccount(
                      selectDefaultValue: 0,
                      options: options,
                      textTitle: AppStrings.addNewTransication4,
                      selectedValueString: '',
                      onChanged: (selectedAccount) {
                        if(selectedAccount!.id!=0){
                          _accountIdController.text = "${selectedAccount!.id}";
                        }else{
                          _accountIdController=TextEditingController();
                        }
                      },
                    ),
                  );
                }
              },
            ),
            SizedBox(
              height: ScreenUtilNew.height(8),
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: ScreenUtilNew.width(16)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          AppStrings.addNewTransication8,
                          style: GoogleFonts.cairo(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtilNew.height(8),
                      ),
                      TextFieldCusomizedBoxScreenWidget(
                        hintText: AppStrings.addNewTransication9,
                        width: ScreenUtilNew.width(160),
                        filledColor: AppColors.primaryColor.withOpacity(0.08),
                        enabled: true,
                        textFiledDiscount: false,
                        iconData: Icons.add,
                        styleHintText: GoogleFonts.cairo(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                        textEditingController: _nameReceiveController,
                        maxLines: 2,
                        minLines: 1, keyboardType: TextInputType.text,
                      ),
                    ],
                  ),
                  const Expanded(child: SizedBox()),
                  FutureBuilder<List<BeneficiarieModel>>(
                    future: GetBeneficiaries().fetchData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return WidgetWhenWatingDataDropDownMenu(
                            textTitle: AppStrings.addNewTransication7,
                            width: ScreenUtilNew.width(160));
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return DropDownWidgetTextFieldBeneficiarie(
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
                        List<BeneficiarieModel> options=[BeneficiarieModel(id: 0, name: "لصالح من...")];
                        options.addAll(snapshot.data!);
                        // List<BeneficiarieModel> options = snapshot.data!;
                        return DropDownWidgetTextFieldBeneficiarie(
                          width: ScreenUtilNew.width(160),
                          options: options,
                          textTitle: AppStrings.addNewTransication7,
                          selectedValueString: '',
                          onChanged: (selectedAccount) {
                            if(selectedAccount!.id!=0){
                              _userIdController.text = "${selectedAccount!.id}";
                            }else{
                              _userIdController=TextEditingController();
                            }
                          },
                          defaultValueId: 0,
                        );
                      }
                    },
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
                  AppStrings.addNewTransication10,
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
              child: GestureDetector(
                onTap: () {
                  _selectDate(context);
                },
                child: Container(
                  height: ScreenUtilNew.height(52),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: const Color(0XFFEBF7F1),
                      borderRadius: BorderRadius.circular(5.r)),
                  child: Row(
                    children: [
                      SizedBox(
                        width: ScreenUtilNew.width(8),
                      ),
                      const Icon(
                        Icons.date_range,
                        color: Colors.black,
                      ),
                      const Expanded(child: SizedBox()),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding:
                              EdgeInsets.only(right: ScreenUtilNew.width(8)),
                          child: ValueListenableBuilder<String>(
                            valueListenable: _textValue,
                            builder: (context, value, child) {
                              return Text(
                                value, // عرض القيمة الحالية للنص
                                style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.sp,
                                  color: Colors.black,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
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
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FutureBuilder<List<CurrencyModel>>(
                    future: GetCurrenciesController().fetchCurrencies(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return WidgetWhenWatingDataDropDownMenu(
                            textTitle: "", width: ScreenUtilNew.width(160));
                      } else if (snapshot.hasError) {
                        // في حالة حدوث خطأ
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        // إذا لم توجد بيانات
                        return Text("لا يوجد بيانات");
                      } else {
                        List<CurrencyModel> options=[CurrencyModel(id: 0, name: "اختر العملة")];
                        options.addAll(snapshot.data!);
                        // List<CurrencyModel> options = snapshot.data!;
                        return DropDownWidgetTextFieldCurrency(
                            width: ScreenUtilNew.width(160),
                            options: options,
                            textTitle: AppStrings.addNewTransication13,
                            selectedValueString: '',
                            onChanged: (selectedAccount) {
                              if(selectedAccount!.id!=0){
                                _currencyController.text =
                                selectedAccount.currency!;
                              }else{
                                _currencyController=TextEditingController();
                              }
                              print(_currencyController);
                            }, selectid: 0,
                        updated: false,);
                      }
                    },
                  ),
                  const Expanded(child: SizedBox()),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          AppStrings.addNewTransication11,
                          style: GoogleFonts.cairo(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtilNew.height(8),
                      ),
                      TextFieldCusomizedBoxScreenWidget(
                        hintText: "مبلغ التحويل ",
                        width: ScreenUtilNew.width(160),
                        filledColor: AppColors.primaryColor.withOpacity(0.08),
                        enabled: true,
                        textFiledDiscount: false,
                        iconData: Icons.add,
                        styleHintText: GoogleFonts.cairo(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                        textEditingController: _amountController,
                        maxLines: 2,
                        minLines: 1, keyboardType: TextInputType.number,
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
                  AppStrings.addNewTransication16,
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
                hintText: "قم بكتابة ملاحظاتك.....",
                width: double.infinity,
                filledColor: AppColors.primaryColor.withOpacity(0.08),
                enabled: true,
                textFiledDiscount: false,
                iconData: Icons.add,
                styleHintText: GoogleFonts.cairo(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                textEditingController: _notesController,
                maxLines: 4,
                minLines: 3, keyboardType: TextInputType.text,
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
                  AppStrings.addNewTransication18,
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Consumer<ImagePathProviderController>(
                    builder: (context, provider, child) {
                      return GestureDetector(
                        onTap: () {
                          _settingModalBottomSheet(context);
                        },
                        child: Container(
                          height: ScreenUtilNew.height(52),
                          width: ScreenUtilNew.width(52),
                          decoration: BoxDecoration(
                              color: AppColors.secondaryColor,
                              borderRadius: BorderRadius.circular(5.r)),
                          child: const Icon(
                            Icons.remove_red_eye,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                      );
                    },
                  ),
                  const Expanded(child: SizedBox()),
                  GestureDetector(
                    onTap: () {
                      _pickAndShowImage(context);
                    },
                    child: Container(
                      width: ScreenUtilNew.width(283),
                      height: ScreenUtilNew.height(52),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.r),
                        color: const Color(0XFFE8F3ED),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppStrings.addNewTransication19,
                            style: GoogleFonts.cairo(
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: ScreenUtilNew.width(8),
                          ),
                          const Icon(
                            Icons.file_upload_outlined,
                            color: Colors.black,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: ScreenUtilNew.height(12),
            ),
            Consumer<IsLoadingAddTransactionProvider>(
                builder: (context, isLoadingProvider, child) {
              return isLoadingProvider.isLoading
                  ? const CircularProgressIndicator(
                      color: AppColors.primaryColor,
                      backgroundColor: AppColors.secondaryColor,
                    )
                  : ElevatedButtonCustomDataAndPasswordUpdated(
                      onTap: () {
                        submitTransaction(context);
                      },
                      title: AppStrings.addNewTransication20);
            }),
            SizedBox(
              height: ScreenUtilNew.height(12),
            ),
          ],
        ),
      ),
    );
  }

  void _settingModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          topRight: Radius.circular(16.r),
        ),
      ),
      builder: (BuildContext bc) {
        return SizedBox(
          width: ScreenUtilNew.width(375),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: ScreenUtilNew.height(24)),
                Consumer<ImagePathProviderController>(
                  builder: (context, provider, child) {
                    return provider.pathImageTransaction != ""
                        ? Image.file(
                            File(provider.pathImageTransaction!),
                            width: ScreenUtilNew.width(340),
                            fit: BoxFit.contain,
                          )
                        : Text(
                            'لم يتم اختيار صورة بعد',
                            style: GoogleFonts.cairo(
                              fontSize: 16.sp,
                              color: AppColors.primaryColor,
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
