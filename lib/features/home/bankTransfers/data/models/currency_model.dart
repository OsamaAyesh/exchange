class CurrencyModel {
  int? id;
  String? name;
  String? currency;
  String? flag;
  int? isActive;

  CurrencyModel({this.id, this.name, this.currency, this.flag, this.isActive});

  CurrencyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    currency = json['currency'];
    flag = json['flag'];
    isActive = json['is_active'];
  }
}