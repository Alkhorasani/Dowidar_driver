class ModGetAllOrders {
  String? message;
  Data? data;

  ModGetAllOrders({
    this.message,
    this.data,
  });

  factory ModGetAllOrders.fromJson(Map<String, dynamic> json) => ModGetAllOrders(
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  int? total;
  List<Order>? orders;

  Data({
    this.total,
    this.orders,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        total: json["total"],
        orders: json["orders"] == null ? [] : List<Order>.from(json["orders"]!.map((x) => Order.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "orders": orders == null ? [] : List<dynamic>.from(orders!.map((x) => x.toJson())),
      };
}

class Order {
  int? id;
  String? orderNo;
  int? addressId;
  String? userId;
  int? restaurantId;
  OrderStatus? status;
  int? paymentMethodId;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? driverId;
  DriverStatus? driverStatus;
  dynamic note;
  Restaurant? restaurant;
  Map<String, String?>? user;
  List<Item>? items;
  List<PaymentHistory>? paymentHistories;

  Order({
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
    this.restaurant,
    this.user,
    this.items,
    this.paymentHistories,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        orderNo: json["order_no"],
        addressId: json["address_id"],
        userId: json["user_id"],
        restaurantId: json["restaurant_id"],
        status: orderStatusValues.map[json["status"]],
        paymentMethodId: json["payment_method_id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        driverId: json["driver_id"],
        driverStatus: driverStatusValues.map[json["driver_status"]],
        note: json["note"],
        restaurant: json["restaurant"] == null ? null : Restaurant.fromJson(json["restaurant"]),
        user: Map.from(json["user"]!).map((k, v) => MapEntry<String, String?>(k, v)),
        items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
        paymentHistories: json["payment_histories"] == null
            ? []
            : List<PaymentHistory>.from(json["payment_histories"]!.map((x) => PaymentHistory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_no": orderNo,
        "address_id": addressId,
        "user_id": userId,
        "restaurant_id": restaurantId,
        "status": orderStatusValues.reverse[status],
        "payment_method_id": paymentMethodId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "driver_id": driverId,
        "driver_status": driverStatusValues.reverse[driverStatus],
        "note": note,
        "restaurant": restaurant?.toJson(),
        "user": Map.from(user!).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
        "payment_histories":
            paymentHistories == null ? [] : List<dynamic>.from(paymentHistories!.map((x) => x.toJson())),
      };
}

enum DriverStatus { ACCEPTED, WAITING }

final driverStatusValues = EnumValues({"accepted": DriverStatus.ACCEPTED, "waiting": DriverStatus.WAITING});

class Item {
  int? id;
  int? restaurantId;
  int? categoryId;
  int? subCategoryId;
  String? name;
  String? image;
  String? arName;
  String? description;
  String? arDescription;
  double? price;
  dynamic discount;
  bool? isAvailable;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? imageUrl;
  Pivot? pivot;

  Item({
    this.id,
    this.restaurantId,
    this.categoryId,
    this.subCategoryId,
    this.name,
    this.image,
    this.arName,
    this.description,
    this.arDescription,
    this.price,
    this.discount,
    this.isAvailable,
    this.createdAt,
    this.updatedAt,
    this.imageUrl,
    this.pivot,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        restaurantId: json["restaurant_id"] == null ? null : json["restaurant_id"],
        categoryId: json["category_id"] == null ? null : json["category_id"],
        subCategoryId: json["sub_category_id"] == null ? null : json["sub_category_id"],
        name: json["name"],
        image: json["image"],
        arName: json["ar_name"],
        description: json["description"],
        arDescription: json["ar_description"],
        price: json["price"]?.toDouble(),
        discount: json["discount"],
        isAvailable: json["is_available"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        imageUrl: json["image_url"],
        pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "restaurant_id": restaurantId,
        "category_id": categoryId,
        "sub_category_id": subCategoryId,
        "name": name,
        "image": image,
        "ar_name": arName,
        "description": description,
        "ar_description": arDescription,
        "price": price,
        "discount": discount,
        "is_available": isAvailable,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "image_url": imageUrl,
        "pivot": pivot?.toJson(),
      };
}

class Pivot {
  int? orderId;
  int? itemId;
  int? quantity;
  double? unitPrice;
  String? variationGroups;

  Pivot({
    this.orderId,
    this.itemId,
    this.quantity,
    this.unitPrice,
    this.variationGroups,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        orderId: json["order_id"],
        itemId: json["item_id"],
        quantity: json["quantity"],
        unitPrice: json["unit_price"]?.toDouble(),
        variationGroups: json["variation_groups"],
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "item_id": itemId,
        "quantity": quantity,
        "unit_price": unitPrice,
        "variation_groups": variationGroups,
      };
}

class PaymentHistory {
  int? id;
  String? userId;
  int? restaurantId;
  int? walletId;
  int? orderId;
  String? amount;
  int? paymentMethodId;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic transactionTypeId;
  dynamic reason;
  dynamic reasonAr;
  PaymentMethod? paymentMethod;

  PaymentHistory({
    this.id,
    this.userId,
    this.restaurantId,
    this.walletId,
    this.orderId,
    this.amount,
    this.paymentMethodId,
    this.createdAt,
    this.updatedAt,
    this.transactionTypeId,
    this.reason,
    this.reasonAr,
    this.paymentMethod,
  });

  factory PaymentHistory.fromJson(Map<String, dynamic> json) => PaymentHistory(
        id: json["id"],
        userId: json["user_id"],
        restaurantId: json["restaurant_id"],
        walletId: json["wallet_id"],
        orderId: json["order_id"],
        amount: json["amount"],
        paymentMethodId: json["payment_method_id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        transactionTypeId: json["transaction_type_id"],
        reason: json["reason"],
        reasonAr: json["reason_ar"],
        paymentMethod: json["payment_method"] == null ? null : PaymentMethod.fromJson(json["payment_method"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "restaurant_id": restaurantId,
        "wallet_id": walletId,
        "order_id": orderId,
        "amount": amount,
        "payment_method_id": paymentMethodId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "transaction_type_id": transactionTypeId,
        "reason": reason,
        "reason_ar": reasonAr,
        "payment_method": paymentMethod?.toJson(),
      };
}

class PaymentMethod {
  int? id;
  PaymentMethodName? name;
  String? nameAr;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  PaymentMethod({
    this.id,
    this.name,
    this.nameAr,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
        id: json["id"],
        name: paymentMethodNameValues.map[json["name"]],
        nameAr: json["name_ar"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": paymentMethodNameValues.reverse[name],
        "name_ar": nameAr,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

enum PaymentMethodName { CASH, WALLET }

final paymentMethodNameValues =
    EnumValues({"Cash": PaymentMethodName.CASH, "Wallet": PaymentMethodName.WALLET});

class Restaurant {
  int? id;
  String? name;
  String? arName;
  String? address;
  String? phoneNumber;
  String? email;
  String? logo;
  String? coverPhoto;
  String? description;
  String? arDescription;
  OpeningHours? openingHours;
  int? deliveryRange;
  int? minimumOrderValue;
  int? maximumOrderValue;
  Location? location;
  bool? cashOnDelivery;
  bool? isActive;
  String? status;
  String? createdBy;
  String? updatedBy;
  dynamic deletedBy;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? deliveryTime;
  DeliveryCharges? deliveryCharges;
  String? tax;
  double? averageRating;
  int? totalRatings;
  String? logoUrl;
  String? coverPhotoUrl;
  bool? assignedManager;

  Restaurant({
    this.id,
    this.name,
    this.arName,
    this.address,
    this.phoneNumber,
    this.email,
    this.logo,
    this.coverPhoto,
    this.description,
    this.arDescription,
    this.openingHours,
    this.deliveryRange,
    this.minimumOrderValue,
    this.maximumOrderValue,
    this.location,
    this.cashOnDelivery,
    this.isActive,
    this.status,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.deliveryTime,
    this.deliveryCharges,
    this.tax,
    this.averageRating,
    this.totalRatings,
    this.logoUrl,
    this.coverPhotoUrl,
    this.assignedManager,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        arName: json["ar_name"],
        address: json["address"],
        phoneNumber: json["phone_number"],
        email: json["email"],
        logo: json["logo"],
        coverPhoto: json["cover_photo"],
        description: json["description"],
        arDescription: json["ar_description"],
        openingHours: (json["opening_hours"] == null || json["opening_hours"] is List<dynamic>)
            ? OpeningHours.fromJson(openingHoursJson)
            : OpeningHours.fromJson(json["opening_hours"]),

        //openingHours: json["opening_hours"] == null ? null : OpeningHours.fromJson(json["opening_hours"]),
        deliveryRange: json["delivery_range"],
        minimumOrderValue: json["minimum_order_value"],
        maximumOrderValue: json["maximum_order_value"],
        location: json["location"] == null ? null : Location.fromJson(json["location"]),
        cashOnDelivery: json["cash_on_delivery"],
        isActive: json["is_active"],
        status: json["status"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        deletedBy: json["deleted_by"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        deliveryTime: json["delivery_time"],
        deliveryCharges:
            json["delivery_charges"] == null ? null : DeliveryCharges.fromJson(json["delivery_charges"]),
        tax: json["tax"],
        averageRating: json["average_rating"]?.toDouble(),
        totalRatings: json["total_ratings"],
        logoUrl: json["logo_url"],
        coverPhotoUrl: json["cover_photo_url"],
        assignedManager: json["assigned_manager"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "ar_name": arName,
        "address": address,
        "phone_number": phoneNumber,
        "email": email,
        "logo": logo,
        "cover_photo": coverPhoto,
        "description": description,
        "ar_description": arDescription,
        "opening_hours": openingHours?.toJson(),
        "delivery_range": deliveryRange,
        "minimum_order_value": minimumOrderValue,
        "maximum_order_value": maximumOrderValue,
        "location": location?.toJson(),
        "cash_on_delivery": cashOnDelivery,
        "is_active": isActive,
        "status": status,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "deleted_by": deletedBy,
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "delivery_time": deliveryTime,
        "delivery_charges": deliveryCharges?.toJson(),
        "tax": tax,
        "average_rating": averageRating,
        "total_ratings": totalRatings,
        "logo_url": logoUrl,
        "cover_photo_url": coverPhotoUrl,
        "assigned_manager": assignedManager,
      };
}

const openingHoursJson = {
  "monday": {"from": "10:00", "to": "22:00"},
  "tuesday": {"from": "10:00", "to": "22:00"},
  "wednesday": {"from": "10:00", "to": "22:00"},
  "thursday": {"from": "10:00", "to": "22:00"},
  "friday": {"from": "10:00", "to": "22:00"},
  "saturday": {"from": "10:00", "to": "22:00"},
  "sunday": {"from": "10:00", "to": "22:00"}
};

class DeliveryCharges {
  int? charges;
  int? distance;

  DeliveryCharges({
    this.charges,
    this.distance,
  });

  factory DeliveryCharges.fromJson(Map<String, dynamic> json) => DeliveryCharges(
        charges: json["charges"],
        distance: json["distance"],
      );

  Map<String, dynamic> toJson() => {
        "charges": charges,
        "distance": distance,
      };
}

class Location {
  double? latitude;
  double? longitude;
  double? lat;
  double? lng;

  Location({
    this.latitude,
    this.longitude,
    this.lat,
    this.lng,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        latitude: double.tryParse(json["latitude"].toString()) ?? 0.0,
        longitude: double.tryParse(json["longitude"].toString()) ?? 0.0,
        lat: double.tryParse(json["lat"].toString()) ?? 0.0,
        lng: double.tryParse(json["lng"].toString()) ?? 0.0,
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
        "lat": lat,
        "lng": lng,
      };
}

class OpeningHours {
  Day? monday;
  Day? tuesday;
  Day? wednesday;
  Day? thursday;
  Day? friday;
  Day? saturday;
  Day? sunday;

  OpeningHours({
    this.monday,
    this.tuesday,
    this.wednesday,
    this.thursday,
    this.friday,
    this.saturday,
    this.sunday,
  });

  factory OpeningHours.fromJson(Map<String, dynamic> json) => OpeningHours(
        monday: json["monday"] == null ? null : Day.fromJson(json["monday"]),
        tuesday: json["tuesday"] == null ? null : Day.fromJson(json["tuesday"]),
        wednesday: json["wednesday"] == null ? null : Day.fromJson(json["wednesday"]),
        thursday: json["thursday"] == null ? null : Day.fromJson(json["thursday"]),
        friday: json["friday"] == null ? null : Day.fromJson(json["friday"]),
        saturday: json["saturday"] == null ? null : Day.fromJson(json["saturday"]),
        sunday: json["sunday"] == null ? null : Day.fromJson(json["sunday"]),
      );

  Map<String, dynamic> toJson() => {
        "monday": monday?.toJson(),
        "tuesday": tuesday?.toJson(),
        "wednesday": wednesday?.toJson(),
        "thursday": thursday?.toJson(),
        "friday": friday?.toJson(),
        "saturday": saturday?.toJson(),
        "sunday": sunday?.toJson(),
      };
}

class Day {
  String? from;
  String? to;

  Day({
    this.from,
    this.to,
  });

  factory Day.fromJson(Map<String, dynamic> json) => Day(
        from: json["from"],
        to: json["to"],
      );

  Map<String, dynamic> toJson() => {
        "from": from,
        "to": to,
      };
}

enum OrderStatus { CANCELLED, PENDING, PROCESSING, Delivered, Enroute }

final orderStatusValues = EnumValues({
  "cancelled": OrderStatus.CANCELLED,
  "pending": OrderStatus.PENDING,
  "processing": OrderStatus.PROCESSING,
  "delivered": OrderStatus.Delivered,
  "enroute": OrderStatus.Enroute,
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
