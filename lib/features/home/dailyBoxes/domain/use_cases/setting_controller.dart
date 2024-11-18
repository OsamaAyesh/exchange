import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../../../core/settings_provider.dart';
import '../../../../../core/sevices/shared_pref_controller.dart';
import '../../data/models/setting_model.dart';
class SettingController {
  final String urlApi = '${SettingsProvider.mainDomain}/api/v1/employee-api/settings';
  final SharedPrefController _sharedPrefController = SharedPrefController();

  Future<String?> _getToken() async {
    String? token = await _sharedPrefController.getValue(PrefKeys.token.name);
    print('Retrieved token: $token'); // تحقق من قيمة التوكن
    return token;
  }

  Future<List<SettingData>> fetchSettings()async{
    String? token = await _getToken();

    if (token == null) {
      throw Exception("Token is not available");
    }

    try {
      var response = await http.get(
        Uri.parse(urlApi),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);

        // تحقق مما إذا كانت البيانات موجودة
        if (jsonData['data'] != null) {
          List<dynamic> itemsJson = jsonData['data'];
          List<SettingData> items = itemsJson
              .map((item) => SettingData.fromJson(item))
              .toList();

          return items;
        } else {
          print('No data found in the response');
          return [];
        }
      } else {
        print('Failed to load data: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print("Error occurred: $e");
      return [];
    }


  }
}