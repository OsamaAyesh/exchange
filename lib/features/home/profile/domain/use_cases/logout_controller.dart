import 'dart:convert';
import 'dart:io';
import 'package:exchange/features/auth/data/models/employee.dart';
import 'package:http/http.dart' as http;

import '../../../../../core/sevices/shared_pref_controller.dart';
import '../../../../auth/data/data_sources/api_helper.dart';
import '../../../../auth/data/data_sources/api_settings.dart';
import '../../../../auth/data/models/process_response.dart';

class LogoutApiController with ApiHelper {
  Future<ProcessResponse> logout() async {
    // Get the token from shared preferences
    String? token = SharedPrefController().getValue<String>(PrefKeys.token.name);

    // Ensure token is available before proceeding
    if (token == null) {
      return ProcessResponse("Token not found. Please login again.", false);
    }

    Uri uri = Uri.parse("https://stage.qudsoffice.com/api/v1/employee-api/logout");

    // Prepare the body with the token, because the API expects form-data
    var body = {
      'token': token,
    };

    // Add the token to the request headers for form-data request
    var response = await http.post(uri, headers: {
      'Accept': 'application/json', // Optional: Specify content type
    }, body: body);

    if (response.statusCode == 200 || response.statusCode == 401) {
      // Clear the shared preferences on successful logout or unauthorized response
      // await SharedPrefController().clear();
      return ProcessResponse("تم تسجيل الخروج بنجاح", true);
    } else {
      // Handle error case
      return ProcessResponse("فشل تسجيل الخروج. الرجاء المحاولة مرة أخرى.", false);
    }
  }
}
