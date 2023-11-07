

class ModUserData {
  String? message; // Make 'message' property nullable
  Data? data; // Make 'data' property nullable

  ModUserData({
    this.message,
    this.data,
  });

  factory ModUserData.fromJson(Map<String, dynamic> json) => ModUserData(
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  User? user; // Make 'user' property nullable
  String? accessToken; // Make 'accessToken' property nullable

  Data({
    this.user,
    this.accessToken,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    user: User.fromJson(json["user"]),
    accessToken: json["access_token"],
  );

  Map<String, dynamic> toJson() => {
    "user": user?.toJson(),
    "access_token": accessToken,
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
  dynamic? deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? roleId;
  dynamic? createdBy;
  dynamic? updatedBy;
  dynamic? deletedBy;
  String? device;
  String? deviceId;
  dynamic? latitude;
  dynamic? longitude;
  String? fullName;
  String? avatarUrl;
  Role? role; // Make 'role' property nullable

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
    this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    email: json["email"],
    emailVerifiedAt: DateTime.parse(json["email_verified_at"]),
    phone: json["phone"],
    phoneVerifiedAt: DateTime.parse(json["phone_verified_at"]),
    status: json["status"],
    avatar: json["avatar"],
    deletedAt: json["deleted_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
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
    role: Role.fromJson(json["role"]),
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
    "role": role?.toJson(),
  };
}

class Role {
  String? id;
  String? name;
  String? description;
  String? abilities;
  dynamic? createdBy;
  dynamic? updatedBy;
  dynamic? deletedBy;
  String? abilitiesList;

  Role({
    this.id,
    this.name,
    this.description,
    this.abilities,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
    this.abilitiesList,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    abilities: json["abilities"],
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    deletedBy: json["deleted_by"],
    abilitiesList: json["abilities_list"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "abilities": abilities,
    "created_by": createdBy,
    "updated_by": updatedBy,
    "deleted_by": deletedBy,
    "abilities_list": abilitiesList,
  };
}
