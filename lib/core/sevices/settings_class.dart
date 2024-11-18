import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SettingsClass {
  final String apiUrl = 'https://qudsoffice.com/api/v1/employee-api/settings';

  Future<String> fetchMainDomain() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        List<dynamic> settings = data['data'];

        var domainSetting = settings.firstWhere(
              (setting) => setting['key'] == 'domain',
          orElse: () => null,
        );
        print("تمت عملية الجلب بنجاح");
        if (domainSetting != null) {
          print(domainSetting['value']);
          return domainSetting['value'];
        } else {
          return 'https://qudsoffice.com'; // القيمة الافتراضية
        }
      } else {
        throw Exception('فشل في تحميل البيانات');
      }
    } catch (e) {
      print("Error fetching settings: $e");
      return 'https://stage.qudsoffice.com'; // القيمة الافتراضية عند حدوث خطأ
    }
  }
}
