
class DataSummaryProcess {
  String? totalBalance;
  int? bankTransferCount;
  int? attendanceDays;
  int? absenceDays;

  DataSummaryProcess();

  DataSummaryProcess.fromJson(Map<String, dynamic> json) {
    totalBalance = json['totalBalance'];
    bankTransferCount = json['bank_transfer_count'];
    attendanceDays = json['attendanceDays'];
    absenceDays = json['absenceDays'];
  }

}