// import 'package:exchange_new_app/core/sevices/shared_pref_controller.dart';
// import 'package:exchange_new_app/core/utils/app_colors.dart';
// import 'package:exchange_new_app/core/utils/app_strings.dart';
// import 'package:exchange_new_app/core/utils/context_extension.dart';
// import 'package:exchange_new_app/core/utils/screen_util_new.dart';
// import 'package:exchange_new_app/features/home/profile/presentation/widgets/elevated_button_custom_data_and_password_updated.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import '../widgets/text_fields_updated_data_widget.dart';
//
// class UpdateData extends StatefulWidget {
//   const UpdateData({super.key});
//
//   @override
//   State<UpdateData> createState() => _UpdateDataState();
// }
//
// class _UpdateDataState extends State<UpdateData> {
//   late TextEditingController nameEmployeeTextEditingController;
//   late TextEditingController emailEmployeeTextEditingController;
//   late TextEditingController phoneNumberEmployeeTextEditingController;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     nameEmployeeTextEditingController=TextEditingController();
//     emailEmployeeTextEditingController=TextEditingController();
//     phoneNumberEmployeeTextEditingController=TextEditingController();
//     super.initState();
//   }
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     nameEmployeeTextEditingController.dispose();
//     emailEmployeeTextEditingController.dispose();
//     phoneNumberEmployeeTextEditingController.dispose();
//     super.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         automaticallyImplyLeading: false,
//         centerTitle: true,
//         actions: [
//           Padding(
//             padding: EdgeInsets.only(right: ScreenUtilNew.width(16)),
//             child: IconButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               icon: const Icon(
//                 Icons.arrow_forward_ios_sharp,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ],
//         title: Text(
//           AppStrings.updateData1,
//           style: GoogleFonts.cairo(
//             fontSize: 16.sp,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               // height: ScreenUtilNew.height(184),
//               width: ScreenUtilNew.width(375),
//               decoration: const BoxDecoration(
//                 color: AppColors.primaryColor,
//               ),
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.only(
//                         right: ScreenUtilNew.width(24),
//                         left: ScreenUtilNew.width(24),
//                         top: ScreenUtilNew.height(104)),
//                     child: Text(
//                       AppStrings.updateData2,
//                       style: GoogleFonts.cairo(
//                           fontWeight: FontWeight.w400,
//                           fontSize: 16.sp,
//                           color: Colors.white),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                   SizedBox(height: ScreenUtilNew.height(16),),
//                 ],
//               ),
//             ),
//             TextFieldsUpdatedDataWidget(
//               enabled: true,
//               controller: nameEmployeeTextEditingController,
//               hintText: SharedPrefController().getValue(PrefKeys.nameEmployee.name)??"أحمد صالحة",
//               title: AppStrings.updateData3,
//               filledColor: const Color(0XFFEDEDED),
//               iconData: Icons.person,
//             ),
//             TextFieldsUpdatedDataWidget(
//               enabled: false,
//               controller: emailEmployeeTextEditingController,
//               hintText: SharedPrefController().getValue(PrefKeys.emailEmployee.name)??"ahmedsalha130@gmail.com",
//               title: AppStrings.updateData4,
//               filledColor: const Color(0XFFEDEDED),
//               iconData: Icons.email,
//             ),
//             TextFieldsUpdatedDataWidget(
//               enabled: true,
//               controller: phoneNumberEmployeeTextEditingController,
//               hintText: SharedPrefController().getValue(PrefKeys.phoneEmployee.name)??"0594323042",
//               title: AppStrings.updateData5,
//               filledColor: const Color(0XFFEDEDED),
//               iconData: Icons.email,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 Text(
//                   "*",
//                   style: GoogleFonts.cairo(color: Colors.red),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(
//                     right: ScreenUtilNew.width(16),
//                     top: ScreenUtilNew.height(16),
//                   ),
//                   child: Text(
//                     AppStrings.updateData6,
//                     style: GoogleFonts.cairo(
//                       fontSize: 12.sp,
//                       fontWeight: FontWeight.w500,
//                       color: const Color(0XFF959595),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: ScreenUtilNew.height(8),
//             ),
//             GestureDetector(
//               onTap: (){
//                 context.showSnackBar(
//                   message: "القسم فعال",
//                   erorr: false
//                 );
//               },
//               child: Stack(
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: ScreenUtilNew.width(16)),
//                     child: SizedBox(
//                       // height: ScreenUtilNew.height(46),
//                       child: TextField(
//                         textDirection: TextDirection.rtl,
//                         style: GoogleFonts.cairo(
//                           fontWeight: FontWeight.w500,
//                           color: Colors.black,
//                           fontSize: 12.sp,
//                         ),
//                         decoration: InputDecoration(
//                           enabled: false,
//                           hintTextDirection: TextDirection.rtl,
//                           hintText: "",
//                           hintStyle: GoogleFonts.cairo(
//                             fontWeight: FontWeight.w500,
//                             color: Colors.black,
//                             fontSize: 12.sp,
//                           ),
//                           filled: true,
//                           fillColor:const Color(0XFFEDEDED) ,
//                           // suffixIcon:  Icon(iconData, color: Color(0XFF959595)),
//                           border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(5.r),
//                               borderSide: BorderSide.none
//                             // borderSide: enabled? const BorderSide(color: Color(0XFF959595)):BorderSide.none,
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5.r),
//                             borderSide: const BorderSide(color: AppColors.primaryColor),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       SizedBox(
//                         height: ScreenUtilNew.height(14),
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             AppStrings.updatedData7,
//                             style: GoogleFonts.cairo(
//                               fontSize: 12.sp,
//                               fontWeight: FontWeight.w500,
//                               color: const Color(0XFF959595),
//                             ),
//                           ),
//                           SizedBox(
//                             width: ScreenUtilNew.width(8),
//                           ),
//                           const Icon(
//                             Icons.file_upload_outlined,
//                             color: Color(0XFF959595),
//                           ),
//                         ],
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//
//             SizedBox(
//               height: ScreenUtilNew.height(32),
//             ),
//             ElevatedButtonCustomDataAndPasswordUpdated(
//                 onTap: () {}, title: "تحديث البيانات")
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'dart:io';
// import 'package:exchange_new_app/config/routes/app_routes.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:path/path.dart'; // Import this for `basename`
// import 'package:flutter/material.dart';
// import 'package:exchange_new_app/core/sevices/shared_pref_controller.dart';
// import 'package:exchange_new_app/core/utils/app_colors.dart';
// import 'package:exchange_new_app/core/utils/app_strings.dart';
// import 'package:exchange_new_app/core/utils/context_extension.dart';
// import 'package:exchange_new_app/core/utils/screen_util_new.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:image_picker/image_picker.dart'; // For picking images
// import '../../domain/use_cases/update_data_controller.dart';
// import '../widgets/elevated_button_custom_data_and_password_updated.dart';
// import '../widgets/text_fields_updated_data_widget.dart';
//
// class UpdateData extends StatefulWidget {
//   const UpdateData({super.key});
//
//   @override
//   State<UpdateData> createState() => _UpdateDataState();
// }
//
// class _UpdateDataState extends State<UpdateData> {
//   late TextEditingController nameEmployeeTextEditingController;
//   late TextEditingController emailEmployeeTextEditingController;
//   late TextEditingController phoneNumberEmployeeTextEditingController;
//
//   File? _imageFile;
//   final UpdateProfileController _profileController = UpdateProfileController(); // Create an instance of your controller
//   bool _isLoading = false; // For tracking loading state
//   String? _statusMessage; // For tracking the success or failure message
//
//   @override
//   void initState() {
//     nameEmployeeTextEditingController = TextEditingController();
//     emailEmployeeTextEditingController = TextEditingController();
//     phoneNumberEmployeeTextEditingController = TextEditingController();
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     nameEmployeeTextEditingController.dispose();
//     emailEmployeeTextEditingController.dispose();
//     phoneNumberEmployeeTextEditingController.dispose();
//     super.dispose();
//   }
//
//   // This function handles picking the image
//   Future<void> _pickImage() async {
//     File? pickedImage = await _profileController.pickImage();
//     if (pickedImage != null) {
//       setState(() {
//         _imageFile = pickedImage;
//       });
//     }
//   }
//
//   // This function will be called to update the profile
//   // Future<void> _updateProfile() async {
//   //   setState(() {
//   //     _isLoading = true; // Start loading
//   //     _statusMessage = null; // Clear any previous status messages
//   //   });
//   //
//   //   try {
//   //     await _profileController.updateProfile(
//   //       name: nameEmployeeTextEditingController.text,
//   //       phone: phoneNumberEmployeeTextEditingController.text,
//   //       imageFile: _imageFile,
//   //     );
//   //     setState(() {
//   //       _statusMessage = 'تم التحديث بنجاح!';
//   //     });
//   //   } catch (e) {
//   //     setState(() {
//   //       _statusMessage = 'حدث خطأ أثناء التحديث.';
//   //     });
//   //   } finally {
//   //     setState(() {
//   //       _isLoading = false; // Stop loading when done
//   //     });
//   //   }
//   // }
//   Future<void> _updateProfile() async {
//     setState(() {
//       _isLoading = true; // Start loading
//       _statusMessage = null; // Clear any previous status messages
//     });
//
//     try {
//       var responseMessage = await _profileController.updateProfile(
//         name: nameEmployeeTextEditingController.text,
//         phone: phoneNumberEmployeeTextEditingController.text,
//         imageFile: _imageFile,
//       );
//
//       // تأكد من أن responseMessage ليس null
//       if (responseMessage != null) {
//         setState(() {
//           _statusMessage = responseMessage; // استخدم الرسالة من الـ API
//         });
//       } else {
//         setState(() {
//           _statusMessage = 'حدث خطأ أثناء التحديث.'; // رسالة احتياطية إذا كانت الرسالة null
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _statusMessage = 'حدث خطأ أثناء التحديث.'; // رسالة احتياطية في حالة حدوث استثناء
//       });
//     } finally {
//       setState(() {
//         _isLoading = false; // Stop loading when done
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         automaticallyImplyLeading: false,
//         centerTitle: true,
//         actions: [
//           Padding(
//             padding: EdgeInsets.only(right: ScreenUtilNew.width(16)),
//             child: IconButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               icon: const Icon(
//                 Icons.arrow_forward_ios_sharp,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ],
//         title: Text(
//           AppStrings.updateData1,
//           style: GoogleFonts.cairo(
//             fontSize: 16.sp,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               width: ScreenUtilNew.width(375),
//               decoration: const BoxDecoration(
//                 color: AppColors.primaryColor,
//               ),
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.only(
//                         right: ScreenUtilNew.width(24),
//                         left: ScreenUtilNew.width(24),
//                         top: ScreenUtilNew.height(104)),
//                     child: Text(
//                       AppStrings.updateData2,
//                       style: GoogleFonts.cairo(
//                           fontWeight: FontWeight.w400,
//                           fontSize: 16.sp,
//                           color: Colors.white),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                   SizedBox(height: ScreenUtilNew.height(16)),
//                 ],
//               ),
//             ),
//             TextFieldsUpdatedDataWidget(
//               enabled: true,
//               controller: nameEmployeeTextEditingController,
//               hintText: SharedPrefController().getValue(PrefKeys.nameEmployee.name) ?? "أحمد صالحة",
//               title: AppStrings.updateData3,
//               filledColor: const Color(0XFFEDEDED),
//               iconData: Icons.person,
//             ),
//             TextFieldsUpdatedDataWidget(
//               enabled: false,
//               controller: emailEmployeeTextEditingController,
//               hintText: SharedPrefController().getValue(PrefKeys.emailEmployee.name) ?? "ahmedsalha130@gmail.com",
//               title: AppStrings.updateData4,
//               filledColor: const Color(0XFFEDEDED),
//               iconData: Icons.email,
//             ),
//             TextFieldsUpdatedDataWidget(
//               enabled: true,
//               controller: phoneNumberEmployeeTextEditingController,
//               hintText: SharedPrefController().getValue(PrefKeys.phoneEmployee.name) ?? "0594323042",
//               title: AppStrings.updateData5,
//               filledColor: const Color(0XFFEDEDED),
//               iconData: Icons.phone,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 Text(
//                   "*",
//                   style: GoogleFonts.cairo(color: Colors.red),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(
//                     right: ScreenUtilNew.width(16),
//                     top: ScreenUtilNew.height(16),
//                   ),
//                   child: Text(
//                     "تحديث الصورة",
//                     style: GoogleFonts.cairo(
//                       fontSize: 12.sp,
//                       fontWeight: FontWeight.w500,
//                       color: const Color(0XFF959595),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: ScreenUtilNew.height(8),
//             ),
//             GestureDetector(
//               onTap: _pickImage, // Set function to pick an image
//               child: Stack(
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: ScreenUtilNew.width(16)),
//                     child: SizedBox(
//                       child: TextField(
//                         enabled: false,
//                         decoration: InputDecoration(
//                           // hintText: _imageFile != null ? basename(_imageFile!.path) : 'اختر صورة',
//                           filled: true,
//                           fillColor: const Color(0XFFEDEDED),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5.r),
//                             borderSide: BorderSide.none,
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5.r),
//                             borderSide: const BorderSide(color: AppColors.primaryColor),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Column(
//                     children: [
//                       SizedBox(height: ScreenUtilNew.height(14)),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             AppStrings.updatedData7,
//                             style: GoogleFonts.cairo(
//                               fontSize: 12.sp,
//                               fontWeight: FontWeight.w500,
//                               color: const Color(0XFF959595),
//                             ),
//                           ),
//                           SizedBox(width: ScreenUtilNew.width(8)),
//                           const Icon(
//                             Icons.file_upload_outlined,
//                             color: Color(0XFF959595),
//                           ),
//                         ],
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//             SizedBox(height: ScreenUtilNew.height(32)),
//
//             // If loading, show CircularProgressIndicator, otherwise show the button
//             _isLoading
//                 ? const CircularProgressIndicator(
//               color: AppColors.primaryColor,
//               backgroundColor: AppColors.secondaryColor,
//             )
//                 : ElevatedButtonCustomDataAndPasswordUpdated(
//                 onTap: (){
//                   _updateProfile();
//                   if(_statusMessage == 'تم التحديث بنجاح!'){
//                     context.showSnackBar(message: _statusMessage!,erorr:_statusMessage == 'تم التحديث بنجاح!'?false:true);
//                     Navigator.pushNamed(context, Routes.profileScreen) ;
//
//                   }else{
//                     context.showSnackBar(message: _statusMessage??"فشل تحديث البيانات",erorr:_statusMessage == 'تم التحديث بنجاح!'?false:true);
//                   }
//
//                 }, title: "تحديث البيانات"),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:io';
import 'package:exchange/config/routes/app_routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path/path.dart'; // Import this for `basename`
import 'package:flutter/material.dart';
import 'package:exchange/core/sevices/shared_pref_controller.dart';
import 'package:exchange/core/utils/app_colors.dart';
import 'package:exchange/core/utils/app_strings.dart';
import 'package:exchange/core/utils/context_extension.dart';
import 'package:exchange/core/utils/screen_util_new.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart'; // For picking images
import '../../domain/use_cases/update_data_controller.dart';
import '../widgets/elevated_button_custom_data_and_password_updated.dart';
import '../widgets/text_fields_updated_data_widget.dart';

class UpdateData extends StatefulWidget {
  const UpdateData({super.key});

  @override
  State<UpdateData> createState() => _UpdateDataState();
}

class _UpdateDataState extends State<UpdateData> {
  late TextEditingController nameEmployeeTextEditingController;
  late TextEditingController emailEmployeeTextEditingController;
  late TextEditingController phoneNumberEmployeeTextEditingController;

  File? _imageFile;
  final UpdateProfileController _profileController = UpdateProfileController();
  bool _isLoading = false;
  String? _statusMessage;

  @override
  void initState() {
    nameEmployeeTextEditingController = TextEditingController(text:  SharedPrefController().getValue(PrefKeys.nameEmployee.name));
    emailEmployeeTextEditingController = TextEditingController();
    phoneNumberEmployeeTextEditingController = TextEditingController(text: SharedPrefController().getValue(PrefKeys.phoneEmployee.name) );
    super.initState();
  }

  @override
  void dispose() {
    nameEmployeeTextEditingController.dispose();
    emailEmployeeTextEditingController.dispose();
    phoneNumberEmployeeTextEditingController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    File? pickedImage = await _profileController.pickImage();
    if (pickedImage != null) {
      setState(() {
        _imageFile = pickedImage;
      });
    }
  }

  Future<void> _updateProfile(BuildContext context) async {
    setState(() {
      _isLoading = true;
      _statusMessage = null;
    });

    try {
      var responseMessage = await _profileController.updateProfile(
        name: nameEmployeeTextEditingController.text,
        phone: phoneNumberEmployeeTextEditingController.text,
        imageFile: _imageFile,
      );


      if (responseMessage != null) {
        setState(() {
          _statusMessage = responseMessage;
          _statusMessage=="تم تحديث البيانات بنجاح"?Navigator.pushReplacementNamed(context, Routes.profileScreen):null;
          Future.delayed(Duration(microseconds: 3000),(){
            context.showSnackBar(message: _statusMessage!,erorr:_statusMessage=="تم تحديث البيانات بنجاح"? false:true);

          });
        });
      } else {
        setState(() {
          _statusMessage = 'حدث خطأ أثناء التحديث.';
        });
      }
    } catch (e) {
      setState(() {
        _statusMessage = 'حدث خطأ أثناء التحديث.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    void checkProcess(){
      context.showSnackBar(message: _statusMessage!,);
    }
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
          AppStrings.updateData1,
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
              width: ScreenUtilNew.width(375),
              decoration: const BoxDecoration(
                color: AppColors.primaryColor,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        right: ScreenUtilNew.width(24),
                        left: ScreenUtilNew.width(24),
                        top: ScreenUtilNew.height(104)
                    ),
                    child: Text(
                      AppStrings.updateData2,
                      style: GoogleFonts.cairo(
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp,
                          color: Colors.white
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: ScreenUtilNew.height(16)),
                ],
              ),
            ),
            TextFieldsUpdatedDataWidget(
              enabled: true,
              controller: nameEmployeeTextEditingController,
              hintText: SharedPrefController().getValue(PrefKeys.nameEmployee.name) ?? "",
              title: AppStrings.updateData3,
              filledColor: const Color(0XFFEDEDED),
              iconData: Icons.person,
            ),
            TextFieldsUpdatedDataWidget(
              enabled: false,
              controller: emailEmployeeTextEditingController,
              hintText: SharedPrefController().getValue(PrefKeys.emailEmployee.name) ?? "",
              title: AppStrings.updateData4,
              filledColor: const Color(0XFFEDEDED),
              iconData: Icons.email,
            ),
            TextFieldsUpdatedDataWidget(
              enabled: true,
              controller: phoneNumberEmployeeTextEditingController,
              hintText: SharedPrefController().getValue(PrefKeys.phoneEmployee.name) ?? "",
              title: AppStrings.updateData5,
              filledColor: const Color(0XFFEDEDED),
              iconData: Icons.phone,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "*",
                  style: GoogleFonts.cairo(color: Colors.red),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: ScreenUtilNew.width(16),
                    top: ScreenUtilNew.height(16),
                  ),
                  child: Text(
                    "تحديث الصورة",
                    style: GoogleFonts.cairo(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0XFF959595),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: ScreenUtilNew.height(8)),
            GestureDetector(
              onTap: _pickImage,
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: ScreenUtilNew.width(16)),
                    child: SizedBox(
                      child: TextField(
                        enabled: false,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0XFFEDEDED),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.r),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.r),
                            borderSide: const BorderSide(color: AppColors.primaryColor),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(height: ScreenUtilNew.height(14)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppStrings.updatedData7,
                            style: GoogleFonts.cairo(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0XFF959595),
                            ),
                          ),
                          SizedBox(width: ScreenUtilNew.width(8)),
                          const Icon(
                            Icons.file_upload_outlined,
                            color: Color(0XFF959595),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: ScreenUtilNew.height(16)),

            // Display the selected image if available
            if (_imageFile != null)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: ScreenUtilNew.width(16)),
                child: Image.file(
                  _imageFile!,
                  height: 100, // Adjust height as needed
                  width: 100, // Adjust width as needed
                  fit: BoxFit.cover,
                ),
              ),

            SizedBox(height: ScreenUtilNew.height(32)),

            _isLoading
                ? const CircularProgressIndicator(
              color: AppColors.primaryColor,
              backgroundColor: AppColors.secondaryColor,
            )
                : ElevatedButtonCustomDataAndPasswordUpdated(
                onTap: () {
                  _updateProfile(context);
                },
                title: "تحديث البيانات"
            ),
          ],
        ),
      ),
    );
  }
}
