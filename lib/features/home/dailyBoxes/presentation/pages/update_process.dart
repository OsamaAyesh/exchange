import 'package:exchange/core/utils/app_colors.dart';
import 'package:exchange/core/utils/screen_util_new.dart';
import 'package:exchange/features/home/dailyBoxes/presentation/widgets/drop_down_widget_text_field.dart';
import 'package:exchange/features/home/dailyBoxes/presentation/widgets/text_field_cusomized_box_screen_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/utils/app_strings.dart';
import '../../../profile/presentation/widgets/elevated_button_custom_data_and_password_updated.dart';

class UpdateProcess extends StatefulWidget {
  const UpdateProcess({super.key});

  @override
  State<UpdateProcess> createState() => _UpdateProcessState();
}

class _UpdateProcessState extends State<UpdateProcess> {
  String valueRadioButton = "إيداع";

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
    sumAmountMoneyTextEditingController=TextEditingController();
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
    sumAmountMoneyTextEditingController.dispose();
    notesTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: ScreenUtilNew.width(16)),
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
                      "2093029039",
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
            SizedBox(
              height: ScreenUtilNew.height(8),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: ScreenUtilNew.width(16)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DropDownWidgetTextField(
                      textTitle: AppStrings.updateProcess4,
                      options: ["بتكي", "usdt"],
                  onChanged: (_){},
                  ),
                  DropDownWidgetTextField(
                      textTitle: AppStrings.updateProcess3,
                      options: ["أحمد صالحة", "أسامة عايش"],
                      onChanged: (_){},
                  ),
                ],
              ),
            ),
            SizedBox(
              height: ScreenUtilNew.height(8),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: ScreenUtilNew.width(16)),
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
                        hintText: "1200",
                        iconData: Icons.percent_rounded,
                        textEditingController: amountMoneyTextEditingController,
                        textFiledDiscount: false,
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
                        hintText: "19",
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
              padding: EdgeInsets.symmetric(horizontal: ScreenUtilNew.width(16)),
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
                        hintText: "1200",
                        iconData: Icons.percent_rounded,
                        textEditingController: amountAfterCalculateTextEditingController,
                        textFiledDiscount: false,
                        width: ScreenUtilNew.width(160),
                        minLines: 1,
                        maxLines: 2,
                        enabled: false,
                        filledColor: AppColors.secondaryColor,
                        styleHintText: GoogleFonts.cairo(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 16.sp,
                        ),
                      )                    ],
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
                        hintText: "50",
                        iconData: Icons.percent_rounded,
                        textEditingController: sumAmountMoneyTextEditingController,
                        textFiledDiscount: false,
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
            /////
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
                          color: typesProcess[index] == valueRadioButton
                              ? AppColors.primaryColor
                              : Colors.black,
                          fontSize: 14.sp,
                        ),
                      ),
                      visualDensity: const VisualDensity(
                          vertical: VisualDensity.minimumDensity,
                          horizontal: VisualDensity.minimumDensity),
                      value: typesProcess[index],
                      groupValue: valueRadioButton,
                      onChanged: (value) {
                        setState(
                          () {
                            valueRadioButton = typesProcess[index];
                          },
                        );
                      },
                    ),
                  );
                },
              ),
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
              padding: EdgeInsets.symmetric(horizontal: ScreenUtilNew.width(16)),
              child: TextFieldCusomizedBoxScreenWidget(
                textInputType: TextInputType.text,
                hintText: "قم بكتابة ملاحظاتك....",
                iconData: Icons.percent_rounded,
                textEditingController: notesTextEditingController,
                textFiledDiscount: false,
                width:double.infinity,
                minLines: 3,
                maxLines: 4,
                enabled: true,
                filledColor: AppColors.primaryColor.withOpacity(0.08),
                styleHintText: GoogleFonts.cairo(
                  fontWeight: FontWeight.w400,
                  color: AppColors.primaryColor,
                  fontSize: 16.sp,
                ),
              )
            ),
            SizedBox(
              height: ScreenUtilNew.height(32),
            ),
            ElevatedButtonCustomDataAndPasswordUpdated(
                onTap: () {}, title: "تعديل البيانات"),
            SizedBox(
              height: ScreenUtilNew.height(16),
            ),
          ],
        ),
      ),
    );
  }
}
