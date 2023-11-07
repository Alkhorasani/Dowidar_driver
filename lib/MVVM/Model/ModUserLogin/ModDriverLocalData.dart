class ModDriverLocalData {
  String? email;
  String? phone;
  String? status;
  String? accessToken;
  String? id;
  String? password;
  String? fullname;

  ModDriverLocalData({
    this.email,
    this.phone,
    this.status,
    this.accessToken,
    this.id,
    this.password,
    this.fullname,
  });

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "phone": phone,
      "status": status,
      "accessToken": accessToken,
      "id": id,
      "password": password,
      "fullname": fullname,
    };
  }
}
