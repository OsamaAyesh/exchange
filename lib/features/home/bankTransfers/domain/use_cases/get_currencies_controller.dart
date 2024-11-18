import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../../../core/settings_provider.dart';
import '../../../../../core/sevices/shared_pref_controller.dart';
import '../../data/models/currency_model.dart';
import 'package:http/http.dart' as http;
class GetCurrenciesController {
  String urlApi = "${SettingsProvider.mainDomain}/api/v1/employee-api/get-currencies";
  final SharedPrefController _sharedPrefController = SharedPrefController();

  // جلب التوكن من SharedPreferences
  Future<String?> _getToken() async {
    return _sharedPrefController.getValue(PrefKeys.token.name);
  }

  Future<List<CurrencyModel>> fetchCurrencies() async {
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
          List<CurrencyModel> items = itemsJson
              .map((item) => CurrencyModel.fromJson(item))
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