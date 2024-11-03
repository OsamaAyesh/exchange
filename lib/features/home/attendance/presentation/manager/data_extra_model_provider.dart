import 'package:flutter/material.dart';

import '../../data/models/attendance_model.dart';
class DataExtraModelProvider extends ChangeNotifier{
  DataAttendanceExtra _dataAttendanceExtra=DataAttendanceExtra();

  DataAttendanceExtra get dataAttendanceExtra=>_dataAttendanceExtra;

  set newDtaAttendance(DataAttendanceExtra newDataAttendanceExtra){
    _dataAttendanceExtra=newDataAttendanceExtra;
    notifyListeners();
  }


}