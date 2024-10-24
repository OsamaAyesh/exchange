class DataEmployee {
  int id;
  String name;
  String email;
  String image;
  String phone;
  String type;
  String roles;
  int isActive;
  String fcmToken;
  String lastLogin;
  String lastLogout;
  String token;

  DataEmployee({
    required this.id,
    required this.name,
    required this.email,
    required this.image,
    required this.phone,
    required this.type,
    required this.roles,
    required this.isActive,
    required this.fcmToken,
    required this.lastLogin,
    required this.lastLogout,
    required this.token,
  });

  factory DataEmployee.fromJson(Map<String, dynamic> json) {
    // التأكد من تحويل List إلى String إذا لزم الأمر
    String roles = json['roles'] is List ? json['roles'].join(', ') : json['roles'] ?? '';
    String fcmToken = json['fcm_token'] is List ? json['fcm_token'].join(', ') : json['fcm_token'] ?? '';

    return DataEmployee(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      image: json['image'] ?? '',
      phone: json['phone'] ?? '',
      type: json['type'] ?? '',
      roles: roles,
      isActive: json['is_active'] ?? 0,
      fcmToken: fcmToken,
      lastLogin: json['last_login'] ?? '',
      lastLogout: json['last_logout'] ?? '',
      token: json['token'] ?? '',
    );
  }
}
