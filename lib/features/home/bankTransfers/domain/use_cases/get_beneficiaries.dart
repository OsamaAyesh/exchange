import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import '../../../../../core/sevices/shared_pref_controller.dart';
import '../../data/models/beneficiarie_model.dart';
class GetBeneficiaries {
  String urlApi="https://stage.qudsoffice.com/api/v1/employee-api/get-beneficiaries";
  final SharedPrefController _sharedPrefController = SharedPrefController();

  // جلب التوكن من SharedPreferences
  Future<String?> _getToken() async {
    return _sharedPrefController.getValue(PrefKeys.token.name);
  }
  Future<List<BeneficiarieModel>> fetchData()async{
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
          List<BeneficiarieModel> items = itemsJson
              .map((item) => BeneficiarieModel.fromJson(item))
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