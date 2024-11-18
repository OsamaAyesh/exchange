import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/settings_provider.dart';
import '../../data/models/get_sources_controller.dart';
import '../../presentation/manager/providers/controller_selected_sourse.dart';

class SourceRepositoryOne {
  Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token'); // احصل على التوكن من SharedPreferences
  }

  Future<DataSources?> fetchSourceById(int boxId, int sourceId) async {
    final String url = '${SettingsProvider.mainDomain}/api/v1/employee-api/get-sources/$boxId';
    String? token = await _getToken(); // جلب التوكن

    if (token == null) {
      throw Exception("Token is not available");
    }

    try {
      // إرسال الطلب مع إضافة التوكن في الـ headers
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',  // تمرير التوكن في الرأس
          'Accept': 'application/json',      // تحديد نوع المحتوى المتوقع
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List<DataSources> sources = (jsonData['data'] as List)
            .map((source) => DataSources.fromJson(source))
            .toList();

        // البحث عن العنصر الذي يطابق المعرف sourceId
        final DataSources selectedSource = sources.firstWhere(
              (source) => source.id == ControllerSelectedSource().idSelectedSource,
          orElse: () => DataSources(), // إرجاع كائن فارغ بدلاً من null
        );

        return selectedSource; // سيتم إرجاع DataSources? (قابل للنول)
      } else {
        throw Exception('فشل في تحميل البيانات: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('خطأ: $error');
    }
  }
}
