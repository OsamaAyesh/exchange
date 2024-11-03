import 'package:flutter/material.dart';

import '../../../../../../core/utils/app_colors.dart';
class FillColorCommissionControllerProvider extends ChangeNotifier{
  Color _colorCommission=AppColors.primaryColor.withOpacity(0.08);

  Color get colorCommission=>_colorCommission;

  set newColorCommission(Color newValue){
    _colorCommission=newValue;
    notifyListeners();
  }
}