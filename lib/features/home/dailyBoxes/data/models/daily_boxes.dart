class BoxesDaily {
  int? id;
  String? name;
  int? status;
  String? currency;
  String? date;
  int? type;
  String? description;  // تم تغيير Null إلى String?
  String? totalBalance;
  String? reminder;

  BoxesDaily();

  // من دالة fromJson، يتم فك الترميز من خريطة JSON إلى الكائن
  BoxesDaily.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    currency = json['currency'];
    date = json['date'];
    type = json['type'];
    description = json['description'];  // أصبح String? بدلاً من Null
    totalBalance = json['total_balance'];
    reminder = json['reminder'];
  }
}
