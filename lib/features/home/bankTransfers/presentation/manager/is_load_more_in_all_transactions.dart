import 'package:flutter/widgets.dart';

import 'message_transaction_add.dart';
class IsLoadMoreInAllTransactions extends ChangeNotifier{
  bool _isLoadMore=false;

  bool get isLoadMore=>_isLoadMore;

  set newValeIsLoadMore(bool newValue){
    _isLoadMore=newValue;
    notifyListeners();
  }
}