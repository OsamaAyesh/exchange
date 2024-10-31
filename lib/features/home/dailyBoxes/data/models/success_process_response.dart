class DataSuccessProcess {
  int? id;
  String? number;
  int? status;
  String? type;
  String? typeName;
  String? sourceId;
  String? sourceName;
  String? serviceName;
  int? commissionId;
  int? commissionType;
  String? commissionValue;
  String? commissionName;
  String? commission;
  String? increaseAmount;
  String? amount;
  int? total;
  String? notes;
  String? date;
  String? createdBy;
  String? updatedBy;
  String? confirmBy;

  DataSuccessProcess(
      {this.id,
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
        this.confirmBy});

  DataSuccessProcess.fromJson(Map<String, dynamic> json) {
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
    commissionName = json['commission_name'];
    commission = json['commission'];
    increaseAmount = json['increase_amount'];
    amount = json['amount'];
    total = json['total'];
    notes = json['notes'];
    date = json['date'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    confirmBy = json['confirm_by'];
  }

}