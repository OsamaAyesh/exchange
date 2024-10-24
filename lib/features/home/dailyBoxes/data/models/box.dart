class DataBox {
  late int id;
  late String reminder;
  late String balance;
  late String transactionSumDeposit;
  late String transactionSumWithdraw;

  DataBox();

  DataBox.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reminder = json['reminder'];
    balance = json['balance'];
    transactionSumDeposit = json['transaction_sum_deposit'];
    transactionSumWithdraw = json['transaction_sum_withdraw'];
  }

}