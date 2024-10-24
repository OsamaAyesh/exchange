// import 'dart:io';
// import 'dart:convert';
// import 'package:exchange_new_app/core/sevices/shared_pref_controller.dart';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';
// import 'package:path/path.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class UpdateProfileController {
//   String urlApi = "https://stage.qudsoffice.com/api/v1/employee-api/update-profile";
//   final SharedPrefController _sharedPrefController = SharedPrefController(); // إنشاء كائن من SharedPrefController
//
//   // جلب التوكن من SharedPreferences
//   Future<String?> _getToken() async {
//     return _sharedPrefController.getValue(PrefKeys.token.name); // جلب التوكن من SharedPreferences
//   }
//
//   // رفع الصورة وتحديث البيانات
//   Future<void> updateProfile({
//     required String name,
//     required String phone,
//     File? imageFile,
//   }) async {
//     try {
//       String? token = await _getToken(); // جلب التوكن
//
//       if (token == null) {
//         print('Token not found');
//         return;
//       }
//
//       // إنشاء الطلب المتعدد
//       var request = http.MultipartRequest('POST', Uri.parse(urlApi));
//
//       // إضافة الاسم ورقم الهاتف إلى الطلب
//       request.fields['name'] = name;
//       request.fields['phone'] = phone;
//
//       // إضافة الصورة إلى الطلب (في حال وجودها)
//       if (imageFile != null) {
//         request.files.add(await http.MultipartFile.fromPath(
//           'image', // المفتاح الذي يستخدمه الـ API لاستقبال الصورة
//           imageFile.path,
//           filename: basename(imageFile.path), // اسم الصورة
//         ));
//       }
//
//       // إضافة الهيدر مع التوكن
//       request.headers.addAll({
//         'Authorization': 'Bearer $token', // إضافة التوكن في الهيدر
//         'Content-Type': 'multipart/form-data',
//       });
//
//       // إرسال الطلب
//       var response = await request.send();
//
//       // التعامل مع الرد
//       if (response.statusCode == 200||response.statusCode==422) {
//         print("Profile updated successfully!");
//
//         // الحصول على الاستجابة كـ JSON
//         var responseData = await http.Response.fromStream(response);
//         var jsonData = json.decode(responseData.body);
//         print(jsonData); // طباعة الاستجابة
//         _updateSharedPreferences(jsonData);
//         // تحديث SharedPreferences بالقيم الجديدة
//         await _updateSharedPreferences(jsonData['data']);
//       } else {
//
//         print("Failed to update profile: ${response.statusCode}");
//       }
//     } catch (e) {
//       print("Error occurred while updating profile: $e");
//     }
//   }
//
//   // تحديث SharedPreferences بالقيم الجديدة
//   Future<void> _updateSharedPreferences(Map<String, dynamic> data) async {
//
//     // تحديث القيم في SharedPreferences
//     await _sharedPrefController.setValue(PrefKeys.nameEmployee.name, data['name']);
//     await _sharedPrefController.setValue(PrefKeys.emailEmployee.name, data['email']);
//     await _sharedPrefController.setValue(PrefKeys.phoneEmployee.name, data['phone']);
//     await _sharedPrefController.setValue(PrefKeys.pathImage.name, data['image']);
//
//     print("SharedPreferences updated successfully!");
//   }
//
//   // اختيار الصورة من المعرض
//   Future<File?> pickImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//
//     if (pickedFile != null) {
//       return File(pickedFile.path);
//     } else {
//       print('No image selected.');
//       return null;
//     }
//   }
// }
import 'dart:io';
import 'dart:convert';
import 'package:exchange/core/sevices/shared_pref_controller.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class UpdateProfileController {
  final String urlApi = "https://stage.qudsoffice.com/api/v1/employee-api/update-profile";
  final SharedPrefController _sharedPrefController = SharedPrefController();

  // جلب التوكن من SharedPreferences
  Future<String?> _getToken() async {
    return _sharedPrefController.getValue(PrefKeys.token.name);
  }

  // رفع الصورة وتحديث البيانات
  Future<String?> updateProfile({
    required String name,
    required String phone,
    File? imageFile,
  }) async {
    try {
      String? token = await _getToken();
      if (token == null) {
        return 'التوكن غير موجود'; // إرجاع رسالة إذا لم يكن هناك توكن
      }

      // إنشاء الطلب المتعدد
      var request = http.MultipartRequest('POST', Uri.parse(urlApi))
        ..fields['name'] = name
        ..fields['phone'] = phone;

      // إضافة الصورة إلى الطلب (في حال وجودها)
      if (imageFile != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'image',
          imageFile.path,
          filename: basename(imageFile.path),
        ));
      }

      // إضافة الهيدر مع التوكن
      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Content-Type'] = 'multipart/form-data';

      // إرسال الطلب
      var response = await request.send();

      // التعامل مع الرد
      if (response.statusCode == 200 || response.statusCode == 422) {
        var responseData = await http.Response.fromStream(response);
        var jsonData = json.decode(responseData.body);

        // تحديث SharedPreferences بالقيم الجديدة
        await _updateSharedPreferences(jsonData['data']);

        return jsonData['message'] ?? 'تم تحديث الملف الشخصي بنجاح!'; // إرجاع رسالة النجاح
      } else {
        return 'فشل في تحديث الملف الشخصي: ${response.statusCode}';
      }
    } catch (e) {
      return 'حدث خطأ أثناء تحديث الملف الشخصي: $e'; // إرجاع رسالة خطأ
    }
  }

  // تحديث SharedPreferences بالقيم الجديدة
  Future<void> _updateSharedPreferences(Map<String, dynamic> data) async {
    await _sharedPrefController.setValue(PrefKeys.nameEmployee.name, data['name']);
    await _sharedPrefController.setValue(PrefKeys.emailEmployee.name, data['email']);
    await _sharedPrefController.setValue(PrefKeys.phoneEmployee.name, data['phone']);
    await _sharedPrefController.setValue(PrefKeys.pathImage.name, data['image']);
    print("SharedPreferences updated successfully!");
  }

  // اختيار الصورة من المعرض
  Future<File?> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      print('لا توجد صورة محددة.');
      return null;
    }
  }
}
