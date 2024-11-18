import 'dart:convert';

import 'package:exchange/core/utils/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart'as http;
import 'package:page_animation_transition/animations/bottom_to_top_faded_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';
import '../../../../../core/settings_provider.dart';
import '../../../../../core/sevices/shared_pref_controller.dart';
import '../../../../../core/utils/assets_manger.dart';
import '../../../../../core/utils/screen_util_new.dart';
import '../../data/models/show_transaction_model.dart';
import '../../presentation/pages/details_box_screen.dart';
class UpdateController {
  String apiUrl = "${SettingsProvider.mainDomain}/api/v1/employee-api/daily-fund-transaction/";
  final SharedPrefController _sharedPrefController = SharedPrefController();

  // جلب التوكن من SharedPreferences
  Future<String?> _getToken() async {
    return _sharedPrefController.getValue(PrefKeys.token.name);
  }
  Future<DailyFundTransactionResponse?> updateProcess({
    required BuildContext context,
    required int idBox,
    required String boxName,
    required int idProcess,
     required int sourceId,
     String? commissionId,
     String? serviceId,
    required int type,
    required double commission,
    required int commissionType,
    required double increaseAmount,
    required double amount,
    required String notes,
  }) async {
    String? token = await _getToken();
    String url="$apiUrl$idProcess";
    if (token == null) {
      print('Token not found in SharedPreferences');
      return null;
    }

    try {
      final Map<String, String> body = {
        // 'source_id': "3",
        // 'commission_id': "2",
        // 'service_id': "1",
        // 'type': "1",
        // 'commission': "0",
        // 'commission_type': "1",
        // 'increase_amount': "0",
        // 'amount': "200",
        // 'notes': "notes",
        // '_method':"put"
        'source_id': sourceId.toString(),
        'commission_id': commissionId.toString() ?? "",
        'service_id': serviceId.toString(),
        'type': type.toString(),
        'commission': commission.toString(),
        'commission_type': commissionType.toString(),
        'increase_amount': increaseAmount.toString(),
        'amount': amount.toString(),
        'notes': notes,
        '_method':"put"
      };

      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Content-Type'] = 'application/json';
      request.fields.addAll(body);

      final response = await request.send();

      // قراءة محتوى الاستجابة
      final responseData = await response.stream.bytesToString();
      final Map<String, dynamic> jsonResponse = json.decode(responseData);

      print('Full Response Data: $jsonResponse'); // تأكد من طباعة كامل الاستجابة

      if (response.statusCode == 200 && jsonResponse['status'] == 200) {
        print('Response: $jsonResponse'); // طباعة محتوى الاستجابة
        _settingModalBottomSheet(context);
        // Future.delayed(const Duration(milliseconds: 1200),(){
        //   Navigator.pop(context);
        // });
        Future.delayed(Duration(milliseconds: 1300), () {
          // Navigator.pushReplacement(context, DetailsBoxScreen(idBox: idBox, nameBox: nameBox))
          Navigator.pop(context);
          Navigator.of(context).push(
              PageAnimationTransition(
                  page: DetailsBoxScreen(
                      idBox: idBox,
                      nameBox: boxName),
                  pageAnimationType:
                  BottomToTopFadedTransition()));
        });
        return DailyFundTransactionResponse.fromJson(jsonResponse);
      } else {
        context.showSnackBar(
            message: 'Failed to post transaction: ${response.statusCode}, Response: $jsonResponse',
            erorr: true);
        return null;
      }
    } catch (e) {
      // context.showSnackBar(
      //     message: 'Error occurred while posting transaction: $e',
      //     erorr: true);
      // print('Error occurred while posting transaction: $e');
      return null;
    }
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50.r), topRight: Radius.circular(50.r)),
      ),
      builder: (BuildContext bc) {
        return SizedBox(
          // height: ScreenUtilNew.height(400),
          width: ScreenUtilNew.width(375),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: ScreenUtilNew.height(8)),
              Image.asset(
                AssetsManger.successImage,
                height: ScreenUtilNew.height(107),
                width: ScreenUtilNew.width(107),
                fit: BoxFit.contain,
              ),
              SizedBox(height: ScreenUtilNew.height(16)),
              Text(
                "لقد تم إتمام العملية بنجاح",
                style: GoogleFonts.cairo(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: ScreenUtilNew.height(8)),
              Padding(
                padding:
                EdgeInsets.symmetric(horizontal: ScreenUtilNew.width(40)),
                child: Text(
                  "لقد تم اضافة العملية انها متتمة بشكل كامل الى قائمة العمليات المتممة بشكل كامل ",
                  style: GoogleFonts.cairo(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0XFF9C9C9C)),
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                ),
              ),
              SizedBox(
                height: ScreenUtilNew.height(16),
              ),
            ],
          ),
        );
      },
    );
  }

}