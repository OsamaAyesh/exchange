import 'dart:convert';
import 'package:flutter/material.dart';
import '../../../../../core/settings_provider.dart';
import '../../../../../core/sevices/shared_pref_controller.dart';
import '../../data/models/bank_transfer_model.dart';
import 'package:http/http.dart' as http;

class BankTransferController {
  final SharedPrefController _sharedPrefController = SharedPrefController();

  // جلب التوكن من SharedPreferences
  Future<String?> _getToken() async {
    return _sharedPrefController.getValue(PrefKeys.token.name);
  }

  Future<List<BankTransferModel>?> fetchDataBankTransfer(
    int page, {
    String? startDate,
    String? endDate,
    String? search,
    String? accountId,
    String? userId,
  }) async {
    String urlApi =
        "${SettingsProvider.mainDomain}/api/v1/employee-api/bank-transfer";
    // "${SettingsProvider.mainDomain}/api/v1/employee-api/bank-transfer?page=$page";

    String? token = await _getToken();

    if (token == null) {
      throw Exception("Token is not available");
    }

    Uri uri = Uri.parse(urlApi).replace(queryParameters: {
      'page': page.toString(),
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (search != null) 'search': search,
      if (accountId != null) 'account_id': accountId,
      if (userId != null) 'user_id': userId,
    });
    // Uri uri=Uri.parse(urlApi);
    try {
      var response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );
      print(response);

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);

        // تحويل البيانات إلى قائمة من BankTransferModel
        List<dynamic> itemsJson = jsonData['data']['items'];
        List<BankTransferModel> items =
            itemsJson.map((item) => BankTransferModel.fromJson(item)).toList();
        print(items);

        return items;
      } else {
        print('Failed to load data. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print("print :$e");
      return [];
    }
  }
}
