import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../../../core/settings_provider.dart';
import '../../../../../core/sevices/shared_pref_controller.dart';
import '../../data/models/show_transaction_model.dart';

class ShowTransactionByNumber {
  String urlApi = "${SettingsProvider.mainDomain}/api/v1/employee-api/get-transaction-number/";
  final SharedPrefController _sharedPrefController = SharedPrefController();

  Future<String?> _getToken() async {
    return _sharedPrefController.getValue(PrefKeys.token.name);
  }

  Future<DailyFundTransactionResponse> fetchData(int numberProcess) async {
    final String url = "$urlApi$numberProcess";
    String? token = await _getToken(); // جلب التوكن

    if (token == null) {
      throw Exception("Token is not available");
    }

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      final Map<String, dynamic> jsonData = json.decode(response.body);

      // تحقق من حالة الاستجابة
      if (response.statusCode == 200) {
        // تحقق من البيانات إذا كانت فارغة
        if (jsonData['data'] == null || (jsonData['data'] is List && jsonData['data'].isEmpty)) {
          print("Message: ${jsonData['message']}");
          return DailyFundTransactionResponse(
            status: jsonData['status'] ?? 404, // استخدام كود خطأ افتراضي
            message: jsonData['message'] ?? "No data available",
            data: DataProcess(id: 0, number: '', status: 404, typeName: '', sourceName: '', serviceName: '', commissionValue: '', amount: '', total: '', notes: '', date: '', createdBy: '', increaseAmount: ''), // كائن فارغ
          );
        }
        return DailyFundTransactionResponse.fromJson(jsonData);
      } else {
        // معالجة الاستجابة غير الناجحة
        return DailyFundTransactionResponse(
          status: jsonData['status'] ?? 404, // استخدام كود خطأ افتراضي
          message: jsonData['message'] ?? "Error fetching data",
          data: DataProcess(id: 0, number: '', status: 404, typeName: '', sourceName: '', serviceName: '', commissionValue: '', amount: '', total: '', notes: '', date: '', createdBy: '', increaseAmount: ''), // كائن فارغ
        );
      }
    } catch (error) {
      print('Error: $error');
      rethrow; // إعادة الخطأ ليتم التعامل معه في مكان آخر
    }
  }
}

// Future<DailyFundTransactionResponse> fetchData(int numberProcess) async {
  //   final String url = "$urlApi$numberProcess";
  //   String? token = await _getToken(); // جلب التوكن
  //
  //   if (token == null) {
  //     throw Exception("Token is not available");
  //   }
  //
  //   try {
  //     final response = await http.get(
  //       Uri.parse(url),
  //       headers: {
  //         'Authorization': 'Bearer $token',
  //         'Accept': 'application/json',
  //       },
  //     );
  //
  //     debugPrint('Response status: ${response.statusCode}');
  //     debugPrint('Response body: ${response.body}');
  //
  //     if (response.statusCode == 200) {
  //       final Map<String, dynamic> jsonData = json.decode(response.body);
  //       return DailyFundTransactionResponse.fromJson(jsonData);
  //     } else {
  //       throw Exception('Error: ${response.statusCode}');
  //     }
  //   } catch (error) {
  //     print('Error: $error');
  //     throw error; // إعادة الخطأ ليتم التعامل معه في مكان آخر
  //   }
  // }


