import 'package:flutter/cupertino.dart';

class ImagePathProviderController extends ChangeNotifier {
  String? _pathImageTransaction;

  String? get pathImageTransaction => _pathImageTransaction;

  set imagePathSet(String? newValue) {
    _pathImageTransaction = newValue;
    notifyListeners(); // Notify listeners when the value changes
  }
}