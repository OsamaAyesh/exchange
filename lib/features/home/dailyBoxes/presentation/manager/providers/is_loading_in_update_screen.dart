import 'package:flutter/material.dart';
class IsLoadingInUpdateScreen extends ChangeNotifier{
  bool _isLoading=false;

  bool get isLoading=>_isLoading;

  set newValueIsLoading(bool newValue){
    _isLoading=newValue;
    notifyListeners();
  }
}