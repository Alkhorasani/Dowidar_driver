

class ModNewOrders {
  String? message;
  Data? data;

  ModNewOrders({
    this.message,
    this.data,
  });

  factory ModNewOrders.fromJson(Map<String, dynamic> json) => ModNewOrders(
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
  };
}
