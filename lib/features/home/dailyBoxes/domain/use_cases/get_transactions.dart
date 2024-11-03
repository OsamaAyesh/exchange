// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import '../../../../../core/sevices/shared_pref_controller.dart';
// import '../../data/models/get_transaction_by_id_box.dart';
//
// class GetTransactions {
//   String apiUrl = "https://stage.qudsoffice.com/api/v1/employee-api/daily-fund-transaction";
//   final SharedPrefController _sharedPrefController = SharedPrefController();
//
//   Future<String?> _getToken() async {
//     return _sharedPrefController.getValue(PrefKeys.token.name);
//   }
//
//   Future<List<TransactionDataByIdBox>> fetchTransactions(int idBox, {String? startDate, String? endDate, String? sourceId, String? search, String? type}) async {
//     String? token = await _getToken();
//
//     Uri uri = Uri.parse(apiUrl).replace(queryParameters: {
//       'daily_fund_id': idBox.toString(),
//       if (startDate != null) 'start_date': startDate,
//       if (endDate != null) 'end_date': endDate,
//       if (sourceId != null) 'source_id': sourceId,
//       if (search != null) 'search': search,
//       if (type != null) 'type': type,
//     });
//
//     if (token == null) {
//       throw Exception("Token is not available");
//     }
//
//     try {
//       // إرسال الطلب مع إضافة التوكن في الـ headers
//       final response = await http.get(
//         uri,
//         headers: {
//           'Authorization': 'Bearer $token',  // تمرير التوكن في الرأس
//           'Accept': 'application/json',      // تحديد نوع المحتوى المتوقع
//         },
//       );
//
//       if (response.statusCode == 200) {
//         final Map<String, dynamic> jsonData = json.decode(response.body);
//         // تحويل البيانات المستلمة إلى قائمة من كائنات TransactionDataByIdBox
//         List<dynamic> transactionsList = jsonData['data']['items'] as List; // الحصول على قائمة الـ items
//         return transactionsList.map((transaction) => TransactionDataByIdBox.fromJson(transaction)).toList();
//       } else {
//         print('Error: ${response.statusCode}');
//         return [];
//       }
//     } catch (error) {
//       print('Error: $error');
//       return [];
//     }
//   }
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../../../core/sevices/shared_pref_controller.dart';
import '../../data/models/get_transaction_by_id_box.dart';

class GetTransactions {
  final String apiUrl = "https://stage.qudsoffice.com/api/v1/employee-api/daily-fund-transaction";
  final SharedPrefController _sharedPrefController = SharedPrefController();

  Future<String?> _getToken() async {
    return _sharedPrefController.getValue(PrefKeys.token.name);
  }
  Future<List<TransactionDataByIdBox>> fetchTransactions(
      int idBox, {
        String? startDate,
        String? endDate,
        String? sourceId,
        String? search,
        String? type,
      }) async {
    String? token = await _getToken();

    if (token == null) {
      throw Exception("Token is not available");
    }

    Uri uri = Uri.parse(apiUrl).replace(queryParameters: {
      'daily_fund_id': idBox.toString(),
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (sourceId != null) 'source_id': sourceId,
      if (search != null) 'search': search,
      if (type != null) 'type': type,
    });

    try {
      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        List<dynamic> transactionsList = jsonData['data']['items'] as List;
        return transactionsList.map((transaction) => TransactionDataByIdBox.fromJson(transaction)).toList();
      } else {
        print('API Error: ${response.statusCode} - ${response.body}');
        throw Exception('Failed to load transactions: ${response.statusCode}');
      }
    } catch (error) {
      print('Request Error: $error');
      throw Exception('Error fetching transactions: $error');
    }
  }

  // Future<List<TransactionDataByIdBox>> fetchTransactions(
  //     int idBox, {
  //       String? startDate,
  //       String? endDate,
  //       String? sourceId,
  //       String? search,
  //       String? type,
  //     }) async {
  //   String? token = await _getToken();
  //
  //   // Handle missing token
  //   if (token == null) {
  //     throw Exception("Token is not available");
  //   }
  //
  //   Uri uri = Uri.parse(apiUrl).replace(queryParameters: {
  //     'daily_fund_id': idBox.toString(),
  //     if (startDate != null) 'start_date': startDate,
  //     if (endDate != null) 'end_date': endDate,
  //     if (sourceId != null) 'source_id': sourceId,
  //     if (search != null) 'search': search,
  //     if (type != null) 'type': type,
  //   });
  //
  //   try {
  //     final response = await http.get(
  //       uri,
  //       headers: {
  //         'Authorization': 'Bearer $token',
  //         'Accept': 'application/json',
  //       },
  //     );
  //
  //     if (response.statusCode == 200) {
  //       final Map<String, dynamic> jsonData = json.decode(response.body);
  //       List<dynamic> transactionsList = jsonData['data']['items'] as List;
  //       return transactionsList.map((transaction) => TransactionDataByIdBox.fromJson(transaction)).toList();
  //     } else {
  //       throw Exception('Failed to load transactions: ${response.statusCode}');
  //     }
  //   } catch (error) {
  //     throw Exception('Error fetching transactions: $error');
  //   }
  // }
}
