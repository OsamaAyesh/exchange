import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../data/models/update_password_model.dart';

class ApiControllerUpdatePassword {
  String urlApi =
      "https://stage.qudsoffice.com/api/v1/employee-api/update-password";

  Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token'); // احصل على التوكن من SharedPreferences
  }

  Future<UpdatePasswordModel?> updatePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    String? token = await _getToken();

    if (token == null) {
      print('Token not found in SharedPreferences');
      return null;
    }

    print('Old Password: $oldPassword');
    print('New Password: $newPassword');
    print('Confirm New Password: $confirmNewPassword');

    try {
      // إعداد البيانات كـ Map
      final Map<String, String> body = {
        'old_password': oldPassword,
        'password': newPassword,
        'password_confirmation': confirmNewPassword,
      };

      final response = await http.post(
        Uri.parse(urlApi),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body, // استخدم الخريطة مباشرة
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        if (jsonResponse.containsKey('status') &&
            jsonResponse.containsKey('message')) {
          print('Failed to post data: ${response.statusCode}');
          print('Response body: ${response.body}');
          return UpdatePasswordModel.fromJson(jsonResponse);
        } else {
          print('Unexpected response structure: $jsonResponse');
          return null;
        }
      } else {
        print('Failed to post data: ${response.statusCode}');
        print('Response body: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error occurred while posting data: $e');
      return null;
    }
  }
}
