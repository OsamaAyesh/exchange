import 'package:flutter/material.dart';
class EnabledTextFiledsOrNotProvider extends ChangeNotifier{
  bool _enabledOrNot=true;

  bool get enabledOrNot=>_enabledOrNot;

  set newValue(bool newValue){
    _enabledOrNot=newValue;
    notifyListeners();
  }
}