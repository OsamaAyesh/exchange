import 'dart:convert';

import 'package:exchange/features/home/bankTransfers/presentation/manager/message_transaction_add.dart';
import 'package:provider/provider.dart';

import '../../../../../core/sevices/shared_pref_controller.dart';
import 'package:http/http.dart' as http;

class StoreTransferControllerApi {
  final String baseUrl = 'https://stage.qudsoffice.com/api/v1/employee-api/bank-transfer';
  final SharedPrefController _sharedPrefController = SharedPrefController();

  Future<String?> _getToken() async {
    String? token = await _sharedPrefController.getValue(PrefKeys.token.name);
    print('Retrieved token: $token'); // تحقق من قيمة التوكن
    return token;
  }

  Future<Map<String, dynamic>?> postTransaction({
    required String refNumber,
    required String accountId,
    required String userId,
    required String nameReceive,
    required String date,
    required double amount,
    required String currency,
    required String notes,
    required String imagePath,
  }) async {
    String? token = await _getToken();
    if (token == null) {
      print('Token not found in SharedPreferences');
      return null;
    }

    try {
      final Map<String, String> body = {
        'ref_number': refNumber,
        'account_id': accountId,
        'user_id': userId,
        'name_receive': nameReceive,
        'date': date,
        'amount': amount.toString(),
        'currency': currency,
        'notes': notes,
      };

      var request = http.MultipartRequest('POST', Uri.parse(baseUrl));
      request.headers['Authorization'] = 'Bearer $token';
      request.fields.addAll(body);

      // إضافة الصورة
      if (imagePath.isNotEmpty) {
        print('Image path: $imagePath'); // تحقق من المسار
        request.files.add(await http.MultipartFile.fromPath('image', imagePath));
      } else {
        print('No image path provided');
      }

      final response = await request.send();

      // قراءة محتوى الاستجابة
      final responseData = await response.stream.bytesToString();
      final Map<String, dynamic> jsonResponse = json.decode(responseData);

      if (response.statusCode == 200) {
        print('Transaction posted successfully');
        print('Response: $jsonResponse'); // طباعة محتوى الاستجابة
        return jsonResponse; // إرجاع البيانات عند النجاح
      } else {
        print('Failed to post transaction: ${response.statusCode}, Response: $jsonResponse');

        // يمكنك استخدام البيانات هنا لعرض الأخطاء للمستخدم
        return jsonResponse; // إرجاع البيانات حتى في حالة الخطأ
      }
    } catch (e) {
      print('Error occurred while posting transaction: $e');
      return null; // إرجاع null في حالة الخطأ
    }
  }
}
