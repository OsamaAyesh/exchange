import 'dart:convert';
import 'package:flutter/material.dart';
import '../../../../../core/sevices/shared_pref_controller.dart';
import '../../data/models/bank_transfer_model.dart';
import 'package:http/http.dart' as http;

class BankTransferController {
  final SharedPrefController _sharedPrefController = SharedPrefController();

  // جلب التوكن من SharedPreferences
  Future<String?> _getToken() async {
    return _sharedPrefController.getValue(PrefKeys.token.name);
  }

  Future<List<BankTransferModel>?> fetchDataBankTransfer(int page) async {
    String urlApi =
        "https://stage.qudsoffice.com/api/v1/employee-api/bank-transfer?page=$page";
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

        // تحويل البيانات إلى قائمة من BankTransferModel
        List<dynamic> itemsJson = jsonData['data']['items'];
        List<BankTransferModel> items = itemsJson
            .map((item) => BankTransferModel.fromJson(item))
            .toList();
        print(items);

        return items;
      } else {
        print('Failed to load data: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print("print :$e");
      return [];
    }
  }
}
