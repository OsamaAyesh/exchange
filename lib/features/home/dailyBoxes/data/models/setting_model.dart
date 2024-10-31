class SettingData {
  int? id;
  String? key;
  String? value;

  SettingData({this.id, this.key, this.value});

  SettingData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    value = json['value'];
  }

}