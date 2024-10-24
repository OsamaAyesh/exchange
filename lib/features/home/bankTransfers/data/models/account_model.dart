
class AccountModel {
  late int id;
  late String name;
  late int status;

  AccountModel({required this.id,required this.name,required this.status});

  AccountModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
  }


}