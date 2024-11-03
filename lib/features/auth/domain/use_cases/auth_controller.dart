import 'dart:convert';
import 'package:exchange/features/auth/data/models/employee.dart';
import 'package:http/http.dart' as http;

import '../../../../core/sevices/shared_pref_controller.dart';
import '../../data/data_sources/api_helper.dart';
import '../../data/data_sources/api_settings.dart';
import '../../data/models/process_response.dart';

class LoginApiController with ApiHelper {
  Future<ProcessResponse> login(String email, String password) async {
    Uri uri = Uri.parse("https://stage.qudsoffice.com/api/v1/employee-api/login");

    try {
      // Perform the POST request
      var response = await http.post(
        uri,
        body: {
          "email": email,
          "password": password,
          "fcm_token":SharedPrefController().getValue(PrefKeys.fcmToken.name)
        }
      );

      // Handle the response based on status code
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        DataEmployee employee = DataEmployee.fromJson(jsonResponse["data"]);
        // Save employee data in SharedPreferences
        await SharedPrefController().save(employee);

        // Return success
        bool status = jsonResponse["status"] == 200;
        return ProcessResponse(jsonResponse["message"], status);
      } else if (response.statusCode == 404) {
        // Handle 404 error (Not Found)
        return ProcessResponse("The requested resource was not found. Please check the URL.", false);
      } else if (response.statusCode == 422) {
        // Handle 422 error (Unprocessable Entity)
        var jsonResponse = jsonDecode(response.body);
        String errorMessage = jsonResponse["message"] ?? "Invalid data provided.";
        return ProcessResponse(errorMessage, false);
      } else if (response.statusCode == 400) {
        // Handle 400 error (Bad Request)
        var jsonResponse = jsonDecode(response.body);
        String errorMessage = jsonResponse["message"] ?? "Bad Request. Please try again.";
        return ProcessResponse(errorMessage, false);
      } else {
        // Handle other errors (unexpected status codes)
        return ProcessResponse("An unexpected error occurred. Please try again later.", false);
      }
    } catch (e) {
      // Catch any exception (network issues, invalid response, etc.)
      print("Error: $e");
      return ProcessResponse("$e", false);
    }
  }
}
