class DataCommissionById {
  late int  id;
  late String  name;
  late int  serviceId;
  late String  serviceName;
  late int  commissionId;
  late String  commissionName;
  late int  commissionType;
  late String  commissionValue;

  DataCommissionById();

  DataCommissionById.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    serviceId = json['service_id'];
    serviceName = json['service_name'];
    commissionId = json['commission_id'];
    commissionName = json['commission_name'];
    commissionType = json['commission_type'];
    commissionValue = json['commission_value'];
  }
  
}