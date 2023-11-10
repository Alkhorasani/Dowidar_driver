

class ModOrderStatus {
  String? message;
  Data? data;

  ModOrderStatus({
    this.message,
    this.data,
  });

  factory ModOrderStatus.fromJson(Map<String, dynamic> json) => ModOrderStatus(
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  int? id;
  String? orderNo;
  int? addressId;
  String? userId;
  int? restaurantId;
  String? status;
  int? paymentMethodId;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? driverId;
  String? driverStatus;
  dynamic note;
  User? user;

  Data({
    this.id,
    this.orderNo,
    this.addressId,
    this.userId,
    this.restaurantId,
    this.status,
    this.paymentMethodId,
    this.createdAt,
    this.updatedAt,
    this.driverId,
    this.driverStatus,
    this.note,
    this.user,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    orderNo: json["order_no"],
    addressId: json["address_id"],
    userId: json["user_id"],
    restaurantId: json["restaurant_id"],
    status: json["status"],
    paymentMethodId: json["payment_method_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    driverId: json["driver_id"],
    driverStatus: json["driver_status"],
    note: json["note"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_no": orderNo,
    "address_id": addressId,
    "user_id": userId,
    "restaurant_id": restaurantId,
    "status": status,
    "payment_method_id": paymentMethodId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "driver_id": driverId,
    "driver_status": driverStatus,
    "note": note,
    "user": user?.toJson(),
  };
}

class User {
  String? id;
  String? firstname;
  String? lastname;
  String? email;
  DateTime? emailVerifiedAt;
  String? phone;
  DateTime? phoneVerifiedAt;
  String? status;
  String? avatar;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? roleId;
  dynamic createdBy;
  String? updatedBy;
  dynamic deletedBy;
  String? device;
  String? deviceId;
  dynamic latitude;
  dynamic longitude;
  String? fullName;
  String? avatarUrl;

  User({
    this.id,
    this.firstname,
    this.lastname,
    this.email,
    this.emailVerifiedAt,
    this.phone,
    this.phoneVerifiedAt,
    this.status,
    this.avatar,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.roleId,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
    this.device,
    this.deviceId,
    this.latitude,
    this.longitude,
    this.fullName,
    this.avatarUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"] == null ? null : DateTime.parse(json["email_verified_at"]),
    phone: json["phone"],
    phoneVerifiedAt: json["phone_verified_at"] == null ? null : DateTime.parse(json["phone_verified_at"]),
    status: json["status"],
    avatar: json["avatar"],
    deletedAt: json["deleted_at"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    roleId: json["role_id"],
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    deletedBy: json["deleted_by"],
    device: json["device"],
    deviceId: json["device_id"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    fullName: json["full_name"],
    avatarUrl: json["avatar_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstname": firstname,
    "lastname": lastname,
    "email": email,
    "email_verified_at": emailVerifiedAt?.toIso8601String(),
    "phone": phone,
    "phone_verified_at": phoneVerifiedAt?.toIso8601String(),
    "status": status,
    "avatar": avatar,
    "deleted_at": deletedAt,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "role_id": roleId,
    "created_by": createdBy,
    "updated_by": updatedBy,
    "deleted_by": deletedBy,
    "device": device,
    "device_id": deviceId,
    "latitude": latitude,
    "longitude": longitude,
    "full_name": fullName,
    "avatar_url": avatarUrl,
  };
}
