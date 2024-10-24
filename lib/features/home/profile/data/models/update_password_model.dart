class UpdatePasswordModel {
  int? status;
  String? message;
  List<dynamic>? data; // استخدم dynamic أو نوع بيانات مناسب
  List<dynamic>? external; // استخدم dynamic أو نوع بيانات مناسب

  UpdatePasswordModel({this.status, this.message, this.data, this.external});

  UpdatePasswordModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];

    // التحقق مما إذا كانت البيانات موجودة وتحويلها إلى قائمة
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        // هنا يمكن أن تكون هناك حاجة إلى تحويل v إلى نوع محدد
        data!.add(v); // استخدم v كما هو أو قم بتحويله
      });
    }

    // التحقق مما إذا كانت البيانات الخارجية موجودة وتحويلها إلى قائمة
    if (json['external'] != null) {
      external = [];
      json['external'].forEach((v) {
        // هنا يمكن أن تكون هناك حاجة إلى تحويل v إلى نوع محدد
        external!.add(v); // استخدم v كما هو أو قم بتحويله
      });
    }
  }
}
