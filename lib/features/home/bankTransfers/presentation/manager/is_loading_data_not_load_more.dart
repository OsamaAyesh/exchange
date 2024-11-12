import 'package:flutter/material.dart';
class IsLoadingDataNotLoadMore extends ChangeNotifier{
  bool _isLoad=false;

  bool get isLoad=>_isLoad;

  set newValueLoading(bool newValue){
    _isLoad=newValue;
    notifyListeners();
  }
}