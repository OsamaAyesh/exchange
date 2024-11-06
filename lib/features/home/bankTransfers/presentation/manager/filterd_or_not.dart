import 'package:flutter/material.dart';
class FilterdOrNot extends ChangeNotifier{
  bool _isFilter=false;

  bool get isFilter=>_isFilter;

  set newValueIsFilter(bool newValue){
    _isFilter=newValue;
    notifyListeners();
  }
}