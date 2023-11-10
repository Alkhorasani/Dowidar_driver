

class ModDriverLocation {
  String? message;
  Data? data;

  ModDriverLocation({
    this.message,
    this.data,
  });

  factory ModDriverLocation.fromJson(Map<String, dynamic> json) => ModDriverLocation(
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  String? id;
  String? firstname;
  String? lastname;
  String? email;
  DateTime? emailVerifiedAt;
  String? phone;
  DateTime? phoneVerifiedAt;
  String? status;
  dynamic avatar;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? roleId;
  String? createdBy;
  String? updatedBy;
  dynamic deletedBy;
  dynamic device;
  dynamic deviceId;
  String? latitude;
  String? longitude;
  String? fullName;
  String? avatarUrl;
  Role? role;

  Data({
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
    role: json["role"] == null ? null : Role.fromJson(json["role"]),
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
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
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
