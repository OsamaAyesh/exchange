import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../../../core/settings_provider.dart';
import '../../../../../core/sevices/shared_pref_controller.dart';
import '../../data/models/notfication_model.dart';

class GetNotificationController {
  final SharedPrefController _sharedPrefController = SharedPrefController();

  // Fetch token from SharedPreferences
  Future<String?> _getToken() async {
    return _sharedPrefController.getValue(PrefKeys.token.name);
  }

  // Fetch notifications with optional pagination
  Future<List<NotificationModel>?> fetchNotifications(int page, {int readable = 1}) async {
    print("NUMBER 1");
    String urlApi = "${SettingsProvider.mainDomain}/api/v1/employee-api/get-notification-all?page=$page&readable=$readable";
    String? token = await _getToken();
    print("NUMBER 2");

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
        print(response.body);
        return _parseNotifications(jsonData['data']['items']);
      } else {
        print('Failed to load data: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print("Error fetching notifications: $e");
      return [];
    }
  }

  // Parse the notification items from JSON
  List<NotificationModel> _parseNotifications(List<dynamic> itemsJson) {
    return itemsJson.map((item) => NotificationModel.fromJson(item)).toList();
  }

  // Mark notification as read
// Mark notification as read
  Future<void> markAsRead(String notificationId) async {
    String urlApi = "${SettingsProvider.mainDomain}/api/v1/employee-api/read-notification"; // تحديث الرابط هنا
    String? token = await _getToken();

    if (token == null) {
      throw Exception("Token is not available");
    }

    try {
      var response = await http.post(
        Uri.parse(urlApi),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: json.encode({"id": notificationId}), // تأكد من تنسيق الجسم بشكل صحيح
      );

      if (response.statusCode == 200) {
        print("Notification marked as read");
      } else {
        print('Failed to mark as read: ${response.statusCode}');
      }
    } catch (e) {
      print("Error marking as read: $e");
    }
  }
}
