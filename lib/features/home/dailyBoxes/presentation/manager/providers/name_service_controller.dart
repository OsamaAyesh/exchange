import 'package:flutter/material.dart';
class NameServiceController extends ChangeNotifier{

  String _nameService="";

  String  get nameService=>_nameService;

  // Setter to update the boolean variable and notify listeners
  set nameServiceNew(String newValue) {
    _nameService = newValue;
    notifyListeners(); // Notify listeners when the value changes
  }
}