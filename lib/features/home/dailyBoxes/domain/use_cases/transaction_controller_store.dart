import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/transaction_model_response.dart';

class ApiControllerDailyFundTransaction {
  // Base URL for daily fund transactions
  final String baseUrl =
      'https://stage.qudsoffice.com/api/v1/employee-api/daily-fund-transaction';

  // Function to get the token from SharedPreferences
  Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // In ApiControllerDailyFundTransaction
  Future<DailyFundTransactionResponse?> postData({
    required int dailyFundId,
    required int sourceId,
    required int commissionId,
    required int serviceId,
    required String type,
    required int commission,
    required String commissionType,
    required double increaseAmount,
    required double amount,
    required String notes,
  }) async {
    String? token = await _getToken();

    if (token == null) {
      print('Token not found in SharedPreferences');
      return null; // Return null if token is not found
    }

    try {
      final Map<String, dynamic> body = {
        'daily_fund_id': dailyFundId,
        'source_id': sourceId,
        'commission_id': commissionId,
        'service_id': serviceId,
        'type': type,
        'commission': commission,
        'commission_type': commissionType,
        'increase_amount': increaseAmount,
        'amount': amount,
        'notes': notes,
      };

      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        // Parse the JSON response into the DailyFundTransactionResponse model
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        return DailyFundTransactionResponse.fromJson(jsonResponse);
      } else {
        print('Failed to post data: ${response.statusCode}');
        return null; // Return null on failure
      }
    } catch (e) {
      print('Error occurred while posting data: $e');
      return null; // Return null on exception
    }
  }
}
