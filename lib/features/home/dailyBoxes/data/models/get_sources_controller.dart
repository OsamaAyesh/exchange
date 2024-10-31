import 'package:flutter/material.dart';
class DataSources {
  int? id;
  String? name;
  int? status;
  int? accountId;
  int? serviceId;
  int? commissionId;
  String? commissionName;
  String? commissionValue;
  int? commissionType;
  String? serviceName;
  int? limit;
  int? min;
  int? max;
  List<TypeOperation>? typeOperation;

  DataSources({this.id, this.name, this.status,this.accountId,this.serviceId,this.commissionId,this.commissionName,this.commissionValue,this.commissionType,this.serviceName,this.limit,this.min,this.max,this.typeOperation});

  DataSources.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;  // تعيين قيمة افتراضية إذا كانت null
    name = json['name'] ?? '';
    status = json['status'] ?? 0;
    accountId = json['account_id'] ?? 0;
    serviceId = json['service_id'] ?? 0;
    commissionId = json['commission_id'] ?? 0;
    commissionName = json['commission_name'] ?? '';
    commissionValue = json['commission_value'] ?? '';
    commissionType = json['commission_type'] ?? 0;
    serviceName = json['service_name'] ?? '';
    limit = json['limit'] ?? 0;
    min = json['min'] ?? 0;
    max = json['max'] ?? 0;
    if (json['type_operation'] != null) {
      typeOperation = <TypeOperation>[];
      json['type_operation'].forEach((v) {
        typeOperation!.add(TypeOperation.fromJson(v));
      });
    } else {
      typeOperation = [];
    }
  }
}


class TypeOperation {
  String? id;
  String? name;

  TypeOperation({required this.id,required this.name});

  TypeOperation.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';  // تعيين قيمة افتراضية إذا كانت null
    name = json['name'] ?? '';
  }
}
