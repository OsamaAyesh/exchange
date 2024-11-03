import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:provider/provider.dart';
import '../../../../../core/sevices/shared_pref_controller.dart';
import '../../data/models/attendance_model.dart';
import '../../presentation/manager/data_extra_model_provider.dart';
class AttendanceController {
  String urlApi = "https://stage.qudsoffice.com/api/v1/employee-api/get-attendance";
  final SharedPrefController _sharedPrefController = SharedPrefController();

  // جلب التوكن من SharedPreferences
  Future<String?> _getToken() async {
    return _sharedPrefController.getValue(PrefKeys.token.name);
  }
  Future<List<AttendanceModel>> fetchAttendance(BuildContext context) async {
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
        if (jsonData['data']['items'] != null) {
          List<dynamic> itemsJson = jsonData['data']['items'];
          List<AttendanceModel> items = itemsJson
              .map((item) => AttendanceModel.fromJson(item))
              .toList();
          Provider.of<DataExtraModelProvider>(context,listen: false).newDtaAttendance=DataAttendanceExtra.fromJson(jsonData['data']['extra']);

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