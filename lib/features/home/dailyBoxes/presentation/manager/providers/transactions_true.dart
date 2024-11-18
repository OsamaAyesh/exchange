import 'package:flutter/material.dart';
class TransactionsTrue extends ChangeNotifier{
  bool _transactionTrue=true;

  bool get transactionTrue =>_transactionTrue;

  set newValueTransactionTrue(bool newValue){
    _transactionTrue=newValue;
    notifyListeners();
  }

}