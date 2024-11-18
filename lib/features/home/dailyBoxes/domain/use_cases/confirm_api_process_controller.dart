import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../../../../core/settings_provider.dart';

class ConfirmApiProcessController {
  String confirmTransactionUrl = "${SettingsProvider.mainDomain}/api/v1/employee-api/confirm-transaction"; // عنوان API لتأكيد المعاملة

  Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token'); // احصل على التوكن من SharedPreferences
  }

  Future<bool> confirmTransaction(String number, String type) async {
    String? token = await _getToken(); // جلب التوكن

    if (token == null) {
      throw Exception("Token is not available");
    }

    try {
      // إعداد البيانات لإرسالها
      final Map<String, dynamic> body = {
        'number': number,
        'type': type,
      };

      // إرسال الطلب POST مع إضافة التوكن في الـ headers
      final response = await http.post(
        Uri.parse(confirmTransactionUrl),
        headers: {
          'Authorization': 'Bearer $token', // تمرير التوكن في الرأس
          'Content-Type': 'application/json', // تحديد نوع المحتوى
        },
        body: json.encode(body), // تحويل البيانات إلى JSON
      );

      if (response.statusCode == 200 || response.statusCode == 201) { // تحقق من حالة الاستجابة
        print('Transaction confirmed successfully');
        return true;
      } else {
        print('Error: ${response.statusCode}');
        return false;
      }
    } catch (error) {
      print('Error: $error');
      return false;
    }
  }
}
