import 'package:exchange/features/home/salary/data/models/salary_model.dart';
import 'package:flutter/material.dart';
class SummaryBalance extends ChangeNotifier{
  ExtraSalary _extraSalary=ExtraSalary();

  ExtraSalary get extraSalary=>_extraSalary;

  set newExtraBalanceData(ExtraSalary newData){
    _extraSalary=newData;
    notifyListeners();
  }
}