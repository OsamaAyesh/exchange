import 'package:flutter/material.dart';

import '../../../data/models/get_sources_controller.dart';
class TypesOperationProvider extends ChangeNotifier{
  List<TypeOperation> _typesOperation=[
    TypeOperation(id: "1", name: "بنكي")
  ];

  List<TypeOperation> get typesOperation=>_typesOperation;
  String? _selectedId;

  String? get selectedId => _selectedId;

  void changeSelectedId(String id) {
    _selectedId = id;
    notifyListeners();
  }
  set changeTypesOperation(List<TypeOperation> newValue) {
    _typesOperation = newValue;
    notifyListeners();
  }
}