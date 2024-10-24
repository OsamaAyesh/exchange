class BeneficiarieModel {
  int? id;
  String? name;
  int? isActive;

  BeneficiarieModel({this.id, this.name, this.isActive});

  BeneficiarieModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isActive = json['is_active'];
  }
}
