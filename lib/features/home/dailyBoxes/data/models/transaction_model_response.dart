class DailyFundTransactionResponse {
  final int status;
  final String message;
  final TransactionData data;

  DailyFundTransactionResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory DailyFundTransactionResponse.fromJson(Map<String, dynamic> json) {
    return DailyFundTransactionResponse(
      status: json['status'],
      message: json['message'],
      data: TransactionData.fromJson(json['data']),
    );
  }
}
class TransactionData {
  late int id;
  late String number;
  late int status;
  late String type;
  late String typeName;
  late String sourceId;
  late String sourceName;
  late String serviceName;
  late int commissionId;
  late int commissionType;
  late String commissionValue;
  late String commissionName;
  late String commission;
  late String increaseAmount;
  late String amount;
  late String total;
  late String notes;
  late String date;
  late String createdBy;
  late String? updatedBy;
  late String? confirmBy;

  TransactionData({
    required this.id,
    required this.number,
    required this.status,
    required this.type,
    required this.typeName,
    required this.sourceId,
    required this.sourceName,
    required this.serviceName,
    required this.commissionId,
    required this.commissionType,
    required this.commissionValue,
    required this.commissionName,
    required this.commission,
    required this.increaseAmount,
    required this.amount,
    required this.total,
    required this.notes,
    required this.date,
    required this.createdBy,
    this.updatedBy,
    this.confirmBy,
  });

  factory TransactionData.fromJson(Map<String, dynamic> json) {
    return TransactionData(
      id: json['id'],
      number: json['number'],
      status: json['status'],
      type: json['type'],
      typeName: json['type_name'],
      sourceId: json['source_id'],
      sourceName: json['source_name'],
      serviceName: json['service_name'],
      commissionId: json['commission_id'],
      commissionType: json['commission_type'],
      commissionValue: json['commission_value'],
      commissionName: json['commission_name'],
      commission: json['commission'],
      increaseAmount: json['increase_amount'],
      amount: json['amount'],
      total: json['total'],
      notes: json['notes'],
      date: json['date'],
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      confirmBy: json['confirm_by'],
    );
  }
}
