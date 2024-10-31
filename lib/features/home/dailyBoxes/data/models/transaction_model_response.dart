// class DailyFundTransactionResponse {
//   final int status;
//   final String message;
//   final TransactionData data;
//
//   DailyFundTransactionResponse({
//     required this.status,
//     required this.message,
//     required this.data,
//   });
//
//   factory DailyFundTransactionResponse.fromJson(Map<String, dynamic> json) {
//     return DailyFundTransactionResponse(
//       status: json['status'],
//       message: json['message'],
//       data: TransactionData.fromJson(json['data']),
//     );
//   }
// }
// class TransactionData {
//   late int id;
//   late String number;
//   late int status;
//   late String type;
//   late String typeName;
//   late String sourceId;
//   late String sourceName;
//   late String serviceName;
//   late int commissionId;
//   late int commissionType;
//   late String commissionValue;
//   late String commissionName;
//   late String commission;
//   late String increaseAmount;
//   late String amount;
//   late String total;
//   late String notes;
//   late String date;
//   late String createdBy;
//   late String? updatedBy;
//   late String? confirmBy;
//
//   TransactionData({
//     required this.id,
//     required this.number,
//     required this.status,
//     required this.type,
//     required this.typeName,
//     required this.sourceId,
//     required this.sourceName,
//     required this.serviceName,
//     required this.commissionId,
//     required this.commissionType,
//     required this.commissionValue,
//     required this.commissionName,
//     required this.commission,
//     required this.increaseAmount,
//     required this.amount,
//     required this.total,
//     required this.notes,
//     required this.date,
//     required this.createdBy,
//     this.updatedBy,
//     this.confirmBy,
//   });
//
//   factory TransactionData.fromJson(Map<String, dynamic> json) {
//     return TransactionData(
//       id: json['id'],
//       number: json['number'],
//       status: json['status'],
//       type: json['type'],
//       typeName: json['type_name'],
//       sourceId: json['source_id'],
//       sourceName: json['source_name'],
//       serviceName: json['service_name'],
//       commissionId: json['commission_id'],
//       commissionType: json['commission_type'],
//       commissionValue: json['commission_value'],
//       commissionName: json['commission_name'],
//       commission: json['commission'],
//       increaseAmount: json['increase_amount'],
//       amount: json['amount'],
//       total: json['total'],
//       notes: json['notes'],
//       date: json['date'],
//       createdBy: json['created_by'],
//       updatedBy: json['updated_by'],
//       confirmBy: json['confirm_by'],
//     );
//   }
// }
class DailyFundTransactionResponse {
  final int status; // تأكد من أن النوع متوافق مع int وليس String
  final String message;
  final Data data;

  DailyFundTransactionResponse({required this.status, required this.message, required this.data});

  factory DailyFundTransactionResponse.fromJson(Map<String, dynamic> json) {
    return DailyFundTransactionResponse(
      status: json['status'],
      message: json['message'],
      data: Data.fromJson(json['data']),
    );
  }

}

class Data {
  final int id;
  final int number;
  final int status;
  final int type;
  final String typeName;
  final int sourceId;
  final String sourceName;
  final String serviceName;
  final int commissionId;
  final int commissionType;
  final double commissionValue;
  final String commissionName;
  final double commission;
  final double increaseAmount;
  final double amount;
  final double total;
  final String? notes;
  final String date;
  final String createdBy;
  final String? updatedBy;
  final String? confirmBy;

  Data({
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
    this.notes,
    required this.date,
    required this.createdBy,
    this.updatedBy,
    this.confirmBy,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
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
      commissionValue: json['commission_value'].toDouble(),
      commissionName: json['commission_name'],
      commission: json['commission'].toDouble(),
      increaseAmount: json['increase_amount'].toDouble(),
      amount: json['amount'].toDouble(),
      total: json['total'].toDouble(),
      notes: json['notes'],
      date: json['date'],
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      confirmBy: json['confirm_by'],
    );
  }
}
