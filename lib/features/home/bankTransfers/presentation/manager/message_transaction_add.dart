import 'package:flutter/material.dart';

class MessageTransactionAdd extends ChangeNotifier {
  String _messageStatus = "";

  String get messageStatus => _messageStatus;

  set changeMessage(String newValue) {
    _messageStatus = newValue;
    notifyListeners();
  }
}
