import 'package:exchange/config/routes/app_routes.dart';
import 'package:exchange/core/utils/app_colors.dart';
import 'package:exchange/core/utils/app_strings.dart';
import 'package:exchange/core/utils/context_extension.dart';
import 'package:exchange/core/utils/screen_util_new.dart';
import 'package:exchange/features/auth/presentation/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/assets_manger.dart';
import '../../data/models/process_response.dart';
import '../../domain/use_cases/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _emailTextEditingController;
  late TextEditingController _passwordTextEditingController;
  bool _isLoading = false; // Add this state variable

  @override
  void initState() {
    _emailTextEditingController = TextEditingController();
    _passwordTextEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack( // Use Stack to overlay loading indicator
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: ScreenUtilNew.height(100)),
                Center(
                  child: Image.asset(
                    AssetsManger.logoApp,
                    height: ScreenUtilNew.height(132),
                    width: ScreenUtilNew.width(216),
                  ),
                ),
                SizedBox(height: ScreenUtilNew.height(36)),
                Text(
                  AppStrings.loginText1,
                  style: GoogleFonts.cairo(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
                SizedBox(height: ScreenUtilNew.height(16)),
                TextFieldWidget(
                  textEditingController: _emailTextEditingController,
                  iconData: Icons.email,
                  hintText: AppStrings.loginText3,
                  label: AppStrings.loginText2,
                  passwordTextFiled: false,
                ),
                SizedBox(height: ScreenUtilNew.height(16)),
                TextFieldWidget(
                  textEditingController: _passwordTextEditingController,
                  iconData: Icons.lock_outline,
                  hintText: AppStrings.loginText5,
                  label: AppStrings.loginText4,
                  passwordTextFiled: true,
                ),
                SizedBox(height: ScreenUtilNew.height(16)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: ScreenUtilNew.width(16)),
                  child: Row(
                    children: [
                      Container(
                        width: ScreenUtilNew.width(58),
                        height: ScreenUtilNew.height(52),
                        decoration: BoxDecoration(
                          color: AppColors.secondaryColor,
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        child: const Icon(
                          Icons.fingerprint_rounded,
                          size: 32,
                          color: Colors.white,
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      GestureDetector(
                        onTap: () => _performLogin(),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            height: ScreenUtilNew.height(52),
                            width: ScreenUtilNew.width(279),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.r),
                              color: AppColors.primaryColor,
                            ),
                            child: Center(
                              child: Text(
                                AppStrings.loginText6,
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
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
                backgroundColor: AppColors.secondaryColor,
              ), // Display loading indicator
            ),
        ],
      ),
    );
  }

  void _performLogin() {
    if (_checkData()) {
      _login();
    }
  }

  bool _checkData() {
    _controlErrors();
    if (_emailTextEditingController.text.isNotEmpty &&
        _passwordTextEditingController.text.isNotEmpty) {
      return true;
    }
    context.showSnackBar(message: "يرجى تعبئة الحقول الفارغة الخاصة بالبريد الالكتروني وكلمة المرور", erorr: true);
    return false;
  }

  void _controlErrors() {}

  void _login() async {
    setState(() {
      _isLoading = true; // Show loading indicator
    });

    // التأكد من أن المتغيرات _emailTextEditingController و _passwordTextEditingController ليست فارغة قبل محاولة إرسال الطلب
    if (_emailTextEditingController.text.isEmpty || _passwordTextEditingController.text.isEmpty) {
      setState(() {
        _isLoading = false; // إيقاف الـ loading indicator
      });
      context.showSnackBar(message: "يرجى تعبئة الحقول الفارغة الخاصة بالبريد الالكتروني وكلمة المرور", erorr: true);
      return; // عدم إرسال الطلب إذا كانت الحقول فارغة
    }

    ProcessResponse processResponse = await LoginApiController()
        .login(_emailTextEditingController.text, _passwordTextEditingController.text);

    setState(() {
      _isLoading = false; // Hide loading indicator after response
    });

    if (processResponse.success) {
      // إذا كان تسجيل الدخول ناجحاً
      Navigator.pushReplacementNamed(context, Routes.homeScreen);
    } else {
      // إذا فشل تسجيل الدخول
      context.showSnackBar(message: processResponse.message, erorr: !processResponse.success);
    }
  }

}
