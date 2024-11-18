import 'dart:convert';

import 'package:exchange/features/home/dailyBoxes/presentation/widgets/daily_boxes_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../../../core/settings_provider.dart';
import '../../data/models/daily_boxes.dart';
class ApiDailyBoxesController{
  final String apiUrl = "${SettingsProvider.mainDomain}/api/v1/employee-api/get-daily-fund";

  Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token'); // احصل على التوكن من SharedPreferences
  }

  Future<List<BoxesDaily>?> fetchData() async {
    String? token = await _getToken();

    if (token == null) {
      throw Exception("Token is not available");
    }

    try {
      var response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        List items = jsonData['data']['items'];
        return items.map((item) => BoxesDaily.fromJson(item)).toList();
      } else {
        print('Failed to load data: ${response.statusCode}');
        return [];  // إرجاع null عند الفشل
      }
    } catch (e) {
      print('Error: $e');
      return [];  // إرجاع null عند حدوث خطأ
    }
  }



}
