import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../../../core/sevices/shared_pref_controller.dart';
import '../../data/models/get_transaction_by_id_box.dart';

class GetTransactions {
  String apiUrl = "https://stage.qudsoffice.com/api/v1/employee-api/daily-fund-transaction?daily_fund_id=";
  final SharedPrefController _sharedPrefController = SharedPrefController();

  Future<String?> _getToken() async {
    return _sharedPrefController.getValue(PrefKeys.token.name);
  }

  Future<List<TransactionDataByIdBox>> fetchTransactions(int idBox) async {
    String? token = await _getToken();
    String url = "$apiUrl$idBox";

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
        // تحويل البيانات المستلمة إلى قائمة من كائنات TransactionDataByIdBox
        List<dynamic> transactionsList = jsonData['data']['items'] as List; // الحصول على قائمة الـ items
        return transactionsList.map((transaction) => TransactionDataByIdBox.fromJson(transaction)).toList();
      } else {
        print('Error: ${response.statusCode}');
        return [];
      }
    } catch (error) {
      print('Error: $error');
      return [];
    }
  }
}
