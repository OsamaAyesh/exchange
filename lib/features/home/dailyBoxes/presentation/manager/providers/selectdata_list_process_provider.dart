import 'package:exchange/features/home/dailyBoxes/data/models/data_type_process.dart';
import 'package:flutter/material.dart';
class SelectdataListProcessProvider extends ChangeNotifier {
  DataTypeProcess _dataTypeProcess;

  SelectdataListProcessProvider(this._dataTypeProcess); // Provide initial value

  DataTypeProcess get dataTypeProcess => _dataTypeProcess;

  set newDataTypeProcess(DataTypeProcess newProcess) {
    _dataTypeProcess = newProcess;
    notifyListeners();
  }
}
