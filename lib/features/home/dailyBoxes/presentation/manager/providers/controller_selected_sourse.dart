import 'package:flutter/material.dart';

class ControllerSelectedSource extends ChangeNotifier {
  int  _idCommission = 0;

  // Getter to access the boolean variable
  int get idSelectedSource => _idCommission;

  // Setter to update the boolean variable and notify listeners
  set idCommissionNew(int newValue) {
    _idCommission = newValue;
    notifyListeners(); // Notify listeners when the value changes
  }
}
