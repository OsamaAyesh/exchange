import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../../../../core/settings_provider.dart';

class ApiCommissionById {
  Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token'); // احصل على التوكن من SharedPreferences
  }

  Future<void> fetchCommissionData(int commissionId) async {
    // بناء عنوان URL
    final String url =
        '${SettingsProvider.mainDomain}/api/v1/employee-api/get-services-commissions/$commissionId';

    String? token = await _getToken(); // جلب التوكن

    try {
      // إجراء الطلب مع إضافة التوكن في الـ headers
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token', // تمرير التوكن في الرأس
          'Accept': 'application/json', // تحديد نوع المحتوى المتوقع
        },
      );

      // التحقق من حالة الاستجابة
      if (response.statusCode == 200) {
        // إذا كانت الاستجابة ناجحة، قم بتحويلها إلى JSON
        final data = json.decode(response.body);
        print(data); // عرض البيانات في وحدة التحكم
      } else {
        // إذا كانت هناك مشكلة، عرض رسالة خطأ
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      // معالجة الأخطاء
      print('Error: $e');
    }
  }
}
