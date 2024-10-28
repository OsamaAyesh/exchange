class DataSalary {
  int? id;
  String? type;
  String? typeDescription;
  String? amount;
  String? date;
  String? notes;
  int? balance;

  DataSalary(
      {this.id,
        this.type,
        this.typeDescription,
        this.amount,
        this.date,
        this.notes,
        this.balance});

  DataSalary.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    typeDescription = json['type_description'];
    amount = json['amount'];
    date = json['date'];
    notes = json['notes'];
    balance = json['balance'];
  }

}

class ExtraSalary {
  String? totalBalance;
  String? totalDeposit;
  String? totalWithdraw;

  ExtraSalary({this.totalBalance, this.totalDeposit, this.totalWithdraw});

  ExtraSalary.fromJson(Map<String, dynamic> json) {
    totalBalance = json['total_balance'];
    totalDeposit = json['total_deposit'];
    totalWithdraw = json['total_withdraw'];
  }

}