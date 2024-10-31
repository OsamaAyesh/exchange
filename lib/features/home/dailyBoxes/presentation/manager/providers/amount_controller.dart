import 'package:flutter/material.dart';
class AmountController extends ChangeNotifier{
  String _amountAfterCalculate="0.0";

  String get amountAfterCalculate =>_amountAfterCalculate;

  set amountNewValue(String newValue){
    _amountAfterCalculate=newValue;
    notifyListeners();
  }

}