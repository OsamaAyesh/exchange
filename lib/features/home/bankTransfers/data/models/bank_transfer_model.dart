class BankTransferModel {
  int? id;
  String? refNumber;
  int? accountId;
  String? accountName;
  int? userId;
  String? userName;
  String? nameReceive;
  int? status;
  String? amount;
  String? currency;
  String? date;
  String? notes;
  String? image;

  BankTransferModel({
    this.id,
    this.refNumber,
    this.accountId,
    this.accountName,
    this.userId,
    this.userName,
    this.nameReceive,
    this.status,
    this.amount,
    this.currency,
    this.date,
    this.notes,
    this.image,
  });

  // Factory method to safely create an instance from JSON
  factory BankTransferModel.fromJson(Map<String, dynamic> json) {
    return BankTransferModel(
      id: json['id'] != null ? json['id'] as int : null,
      refNumber: json['ref_number'] ?? '',
      accountId: json['account_id'] != null ? json['account_id'] as int : null,
      accountName: json['account_name'] ?? '',
      userId: json['user_id'] != null ? json['user_id'] as int : null,
      userName: json['user_name'] ?? '',
      nameReceive: json['name_receive'] ?? '',
      status: json['status'] != null ? json['status'] as int : null,
      amount: json['amount'] ?? '0.00', // Default value to avoid nulls
      currency: json['currency'] ?? '',
      date: json['date'] ?? '',
      notes: json['notes'] ?? '',
      image: json['image'] ?? '',
    );
  }
}
