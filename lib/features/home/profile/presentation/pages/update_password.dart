import 'package:exchange/core/utils/context_extension.dart';
import 'package:exchange/features/home/profile/domain/use_cases/update_password_controller.dart';
import 'package:exchange/features/home/profile/presentation/widgets/elevated_button_custom_data_and_password_updated.dart';
import 'package:exchange/features/home/profile/presentation/widgets/text_field_updated_password_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/screen_util_new.dart';

class UpdatePassword extends StatefulWidget {
  const UpdatePassword({super.key});

  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  late TextEditingController oldPasswordTextEditingController;
  late TextEditingController newPasswordTextEditingController;
  late TextEditingController confirmPasswordTextEditingController;
  bool _isLoading = false; // متغير حالة التحميل

  @override
  void initState() {
    // TODO: implement initState
    oldPasswordTextEditingController = TextEditingController();
    newPasswordTextEditingController = TextEditingController();
    confirmPasswordTextEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    oldPasswordTextEditingController.dispose();
    newPasswordTextEditingController.dispose();
    confirmPasswordTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: ScreenUtilNew.width(16)),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_forward_ios_sharp,
                color: Colors.white,
              ),
            ),
          ),
        ],
        title: Text(
          AppStrings.updatedPassword1,
          style: GoogleFonts.cairo(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              // height: ScreenUtilNew.height(184),
              width: ScreenUtilNew.width(375),
              decoration: const BoxDecoration(
                color: AppColors.primaryColor,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        right: ScreenUtilNew.width(36),
                        left: ScreenUtilNew.width(36),
                        top: ScreenUtilNew.height(104)),
                    child: Text(
                      AppStrings.updatedPassword2,
                      style: GoogleFonts.cairo(
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtilNew.height(24),
                  ),
                ],
              ),
            ),
            TextFieldUpdatedPasswordWidget(
                title: AppStrings.updatedPassword3,
                hintText: AppStrings.updatedPasswordHintText,
                iconData: Icons.lock,
                enabled: true,
                controller: oldPasswordTextEditingController,
                filledColor: const Color(0XFFEDEDED)),
            TextFieldUpdatedPasswordWidget(
                title: AppStrings.updatedPassword4,
                hintText: AppStrings.updatedPasswordHintText,
                iconData: Icons.lock,
                enabled: true,
                controller: newPasswordTextEditingController,
                filledColor: const Color(0XFFEDEDED)),
            TextFieldUpdatedPasswordWidget(
                title: AppStrings.updatedPassword5,
                hintText: AppStrings.updatedPasswordHintText,
                iconData: Icons.lock,
                enabled: true,
                controller: confirmPasswordTextEditingController,
                filledColor: const Color(0XFFEDEDED)),
            SizedBox(
              height: ScreenUtilNew.height(32),
            ),
            _isLoading?
                const CircularProgressIndicator(
                  color: AppColors.primaryColor,
                  backgroundColor: AppColors.secondaryColor,
                )
            :ElevatedButtonCustomDataAndPasswordUpdated(
                onTap: () {
                  updatePassword(
                      oldPasswordTextEditingController.text,
                      newPasswordTextEditingController.text,
                      confirmPasswordTextEditingController.text);

                },
                title: "تحديث كلمة المرور")
          ],
        ),
      ),
    );
  }

  void updatePassword(
      String oldPassword, String newPassword, String confirmNewPassword) async {
    setState(() {
      _isLoading = true; // تعيين حالة التحميل عند بدء الطلب
    });

    // الانتظار للحصول على النتيجة
    final result = await ApiControllerUpdatePassword().updatePassword(
      context,
      oldPassword: oldPassword,
      newPassword: newPassword,
      confirmNewPassword: confirmNewPassword,
    );

    setState(() {
      _isLoading = false; // تعيين حالة التحميل عند انتهاء الطلب
    });

    if (result != null && result.status == 200) {
      // عرض SnackBar عند نجاح العملية
      // context.showSnackBar(message: result.message ?? "تم تحديث كلمة المرور بنجاح",erorr: false);
      oldPasswordTextEditingController.clear();
      newPasswordTextEditingController.clear();
      confirmPasswordTextEditingController.clear();
      // يمكنك توجيه المستخدم إلى صفحة أخرى إذا رغبت
    } else {
      // في حالة الفشل، يمكن عرض رسالة خطأ أيضًا
      // context.showSnackBar(message: result!.message ?? "",erorr: true);
      // oldPasswordTextEditingController.clear();
      // newPasswordTextEditingController.clear();
      // confirmPasswordTextEditingController.clear();
    }
  }
}
