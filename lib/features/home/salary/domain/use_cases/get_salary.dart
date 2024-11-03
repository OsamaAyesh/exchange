import 'package:exchange/features/home/salary/presentation/manager/summary_balance.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';

import '../../../../../core/sevices/shared_pref_controller.dart';
import '../../data/models/salary_model.dart';

class GetSalary {
  final SharedPrefController _sharedPrefController = SharedPrefController();

  // جلب التوكن من SharedPreferences
  Future<String?> _getToken() async {
    return _sharedPrefController.getValue(PrefKeys.token.name);
  }

  Future<List<DataSalary>?> fetchSalaries(int page,BuildContext context ,{String? startDate, String? endDate, String? search}) async {
    String? token = await _getToken();

    if (token == null) {
      throw Exception("Token is not available");
    }

    String urlApi = "https://stage.qudsoffice.com/api/v1/employee-api/get-salary?page=$page";

    // إنشاء كائن الفلترة بناءً على المعطيات المتاحة
    Map<String, dynamic> filter = {};
    if (startDate != null) filter['start_date'] = startDate;
    if (endDate != null) filter['end_date'] = endDate;
    if (search != null) filter['search'] = search;

    try {
      var response = await http.post(
        Uri.parse(urlApi),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(filter),
      );

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        Provider.of<SummaryBalance>(context,listen: false).newExtraBalanceData=ExtraSalary.fromJson(jsonData['data']['extra']);
        return _parseSalaries(jsonData['data']['items']);
      } else {
        print('Failed to load data: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print("Error fetching salaries: $e");
      return [];
    }
  }

  // دالة لتحليل البيانات وإرجاع كائنات Salary
  List<DataSalary> _parseSalaries(List<dynamic> items) {
    return items.map((item) => DataSalary.fromJson(item)).toList();
  }
}
