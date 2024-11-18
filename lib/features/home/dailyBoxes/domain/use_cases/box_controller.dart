import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../../../../core/settings_provider.dart';
import '../../data/models/box.dart';
class ApiBoxController{
  String apiUrl="${SettingsProvider.mainDomain}/api/v1/employee-api/get-boxes/";
  Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token'); // احصل على التوكن من SharedPreferences
  }
  Future<DataBox?> fetchData(int id) async {
    final String url = "$apiUrl$id";
    String? token = await _getToken(); // جلب التوكن

    if (token == null) {
      throw Exception("Token is not available");
    }
    try {
      // إرسال الطلب مع إضافة التوكن في الـ headers
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',  // تمرير التوكن في الرأس
          'Accept': 'application/json',      // تحديد نوع المحتوى المتوقع
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        // print(jsonData);
        // تحويل البيانات المستلمة إلى object من نوع DataBox
        return DataBox.fromJson(jsonData['data']);
      } else {
        print('Error: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      print('Error: $error');
      return null;
    }
  }



}