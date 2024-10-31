class TransactionDataByIdBox {
  int? id;
  String? number;
  int? status;
  int? type;
  String? typeName;
  int? sourceId;
  String? sourceName;
  String? serviceName;
  int? commissionId;
  int? commissionType;
  String? commissionValue;
  String? commissionName; // تعديل Null إلى String?
  String? commission;
  String? increaseAmount;
  String? amount;
  String? total;
  String? notes; // تعديل Null إلى String?
  String? date;
  String? createdBy; // تعديل Null إلى String?
  String? updatedBy; // تعديل Null إلى String?
  String? confirmBy; // تعديل Null إلى String?

  TransactionDataByIdBox({
    this.id,
    this.number,
    this.status,
    this.type,
    this.typeName,
    this.sourceId,
    this.sourceName,
    this.serviceName,
    this.commissionId,
    this.commissionType,
    this.commissionValue,
    this.commissionName,
    this.commission,
    this.increaseAmount,
    this.amount,
    this.total,
    this.notes,
    this.date,
    this.createdBy,
    this.updatedBy,
    this.confirmBy,
  });

  TransactionDataByIdBox.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    number = json['number'];
    status = json['status'];
    type = json['type'];
    typeName = json['type_name'];
    sourceId = json['source_id'];
    sourceName = json['source_name'];
    serviceName = json['service_name'];
    commissionId = json['commission_id'];
    commissionType = json['commission_type'];
    commissionValue = json['commission_value'];
    commissionName = json['commission_name']; // تعديل Null إلى String?
    commission = json['commission'];
    increaseAmount = json['increase_amount'];
    amount = json['amount'];
    total = json['total'];
    notes = json['notes']; // تعديل Null إلى String?
    date = json['date'];
    createdBy = json['created_by']; // تعديل Null إلى String؟
    updatedBy = json['updated_by']; // تعديل Null إلى String؟
    confirmBy = json['confirm_by']; // تعديل Null إلى String؟
  }
}
