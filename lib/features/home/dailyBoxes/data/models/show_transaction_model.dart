class DailyFundTransactionResponse {
  final int status;
  final String message;
  final DataProcess? data; // يمكن أن تكون null إذا لم توجد بيانات

  DailyFundTransactionResponse({
    required this.status,
    required this.message,
    this.data,
  });

  factory DailyFundTransactionResponse.fromJson(Map<String, dynamic> json) {
    return DailyFundTransactionResponse(
      status: json['status'] ?? 0, // استخدام قيمة افتراضية إذا كانت null
      message: json['message'] ?? 'No message', // استخدام قيمة افتراضية
      data: json['data'] != null ? DataProcess.fromJson(json['data']) : null,
    );
  }
}

class DataProcess {
  final int id;
  final String number; // يجب أن تكون String وليس null
  final int status;
  final String typeName;
  final String sourceName;
  final String serviceName;
  final String commissionValue;
  final String amount;
  final String total;
  final String notes;
  final String date;
  final String createdBy;
  final String? updatedBy; // يمكن أن تكون null
  final String? confirmBy; // يمكن أن تكون null
  final String? increaseAmount;

  DataProcess({
    required this.id,
    required this.number,
    required this.status,
    required this.typeName,
    required this.sourceName,
    required this.serviceName,
    required this.commissionValue,
    required this.amount,
    required this.total,
    required this.notes,
    required this.date,
    required this.createdBy,
    this.updatedBy,
    this.confirmBy,
    required this.increaseAmount,
  });

  factory DataProcess.fromJson(Map<String, dynamic> json) {
    return DataProcess(
      id: json['id'],
      number: json['number'] ?? 'N/A', // استخدام قيمة افتراضية
      status: json['status'] ?? 0, // استخدام قيمة افتراضية
      typeName: json['type_name'] ?? 'N/A', // استخدام قيمة افتراضية
      sourceName: json['source_name'] ?? 'N/A', // استخدام قيمة افتراضية
      serviceName: json['service_name'] ?? 'N/A', // استخدام قيمة افتراضية
      commissionValue: json['commission_value'] ?? '0.00', // استخدام قيمة افتراضية
      amount: json['amount'] ?? '0.00', // استخدام قيمة افتراضية
      total: json['total'] ?? '0.00', // استخدام قيمة افتراضية
      notes: json['notes'] ?? 'No notes', // استخدام قيمة افتراضية
      date: json['date'] ?? 'N/A', // استخدام قيمة افتراضية
      createdBy: json['created_by'] ?? 'Unknown', // استخدام قيمة افتراضية
      updatedBy: json['updated_by'], // قد تكون null
      confirmBy: json['confirm_by'], // قد تكون null
      increaseAmount: json['increase_amount']
    );
  }
}
