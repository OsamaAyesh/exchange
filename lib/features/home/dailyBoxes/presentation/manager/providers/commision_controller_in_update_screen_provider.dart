import 'package:flutter/material.dart';
class CommissionControllerInUpdateScreenProvider extends ChangeNotifier{
  String _commission="";

  String get commission=>_commission;

  set newCommission(String newValue){
    _commission=newValue;
    notifyListeners();
  }
}