import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/settings_provider.dart';
import '../../data/models/summary_process_data.dart';

class ApiSummaryProcessController {
  final String apiUrl = "${SettingsProvider.mainDomain}/api/v1/employee-api/dashboard";

  Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token'); // احصل على التوكن من SharedPreferences
  }

  Future<DataSummaryProcess?> fetchData() async {
    String? token = await _getToken();

    if (token == null) {
      throw Exception("Token is not available");
    }

    try {
      // إرساء التوكن مع رأس الطلب في حال كان API يستقبل توكن في Header
      var response = await http.get(
        Uri.parse(apiUrl),  // رابط API
        headers: {
          'Authorization': 'Bearer $token',  // إضافة التوكن في الرأس
          'Accept': 'application/json',  // تحديد نوع المحتوى المتوقع
        },
      );

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        return DataSummaryProcess.fromJson(jsonData['data']); // التعامل مع البيانات المستلمة
      } else {
        print('Failed to load data: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }


}
