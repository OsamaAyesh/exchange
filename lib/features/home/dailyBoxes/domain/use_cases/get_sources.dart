import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/settings_provider.dart';
import '../../data/models/get_sources_controller.dart';

class ApiControllerSourcesBox {
  // Base URL without صندوقId
  final String baseUrl =
      '${SettingsProvider.mainDomain}/api/v1/employee-api/get-sources/';

  // Function to get the token from SharedPreferences
  Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // Function to fetch data from the API with صندوقId as a parameter
  Future<List<DataSources>?> fetchData(int id) async {
    String? token = await _getToken();

    if (token == null) {
      // Handle the case where the token is not found
      print('Token not found in SharedPreferences');
      return null;
    }

    try {
      // Complete URL with صندوقId
      final String urlWithId = '$baseUrl$id';

      final response = await http.get(
        Uri.parse(urlWithId),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // Parse the JSON response
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        if (jsonResponse['status'] == 200) {
          List<dynamic> dataList = jsonResponse['data'];
          // Map the response to a list of Data objects
          // print(dataList);
          return dataList.map((data) => DataSources.fromJson(data)).toList();

        } else {
          // Handle non-200 status code from API
          print('Failed to load data: ${jsonResponse['message']}');
          print(response);
          return null;
        }
      } else {
        print('Failed to fetch data: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error occurred while fetching data: $e');
      return null;
    }
  }
}
