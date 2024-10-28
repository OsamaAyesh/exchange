class NotificationModel {
  String? id;
  DataNotification? data;
  String? readAt;
  String? createdAt;

  NotificationModel({this.id, this.data, this.readAt, this.createdAt});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    data = json['data'] != null ?  DataNotification.fromJson(json['data']) : null;
    readAt = json['read_at'];
    createdAt = json['created_at'];
  }

}

class DataNotification {
  String? title;
  int? bankId;
  String? data;
  String? senderName;
  List<String>? channels;

  DataNotification({this.title, this.bankId, this.data, this.senderName, this.channels});

  DataNotification.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    bankId = json['bank_id'];
    data = json['data'];
    senderName = json['sender_name'];
    channels = json['channels'].cast<String>();
  }

}