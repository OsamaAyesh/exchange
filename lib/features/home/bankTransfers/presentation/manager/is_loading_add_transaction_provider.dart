import 'package:flutter/material.dart';

class IsLoadingAddTransactionProvider extends ChangeNotifier {
  bool _isLoading = false;

  // Getter for isLoading
  bool get isLoading => _isLoading;

  // Setter for isLoading with the correct name
  set isLoadingSet(bool newValue) {
    _isLoading = newValue;
    notifyListeners(); // Notify listeners when the value changes
  }
}