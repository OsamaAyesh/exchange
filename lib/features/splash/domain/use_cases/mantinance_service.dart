import 'dart:convert';
import 'package:exchange/core/settings_provider.dart';
import 'package:http/http.dart' as http;

class MaintenanceService {
  final String apiUrl = '${SettingsProvider.mainDomain}/api/v1/employee-api/settings'; // API الخاص بك

  Future<bool> isWebsiteUnderMaintenance() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        List<dynamic> settings = data['data'];

        var maintenanceSetting = settings.firstWhere(
              (setting) => setting['key'] == 'website_maintenance',
          orElse: () => null,
        );

        // إذا كانت قيمة 'website_maintenance' تساوي 1، فهذا يعني أن الموقع في مرحلة صيانة
        return maintenanceSetting != null && maintenanceSetting['value'] == '1';
      } else {
        throw Exception('فشل في تحميل البيانات');
      }
    } catch (e) {
      print("Error checking maintenance status: $e");
      return false; // في حالة حدوث خطأ، سنعتبر الموقع متاحًا
    }
  }
}
