

class ModGetAllOrders {
  String? message;
  List<Datum>? data;

  ModGetAllOrders({
    this.message,
    this.data,
  });

  factory ModGetAllOrders.fromJson(Map<String, dynamic> json) => ModGetAllOrders(
    message: json["message"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  int? id;
  String? orderNo;
  int? addressId;
  String? userId;
  int? restaurantId;
  DatumStatus? status;
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

  Datum({
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

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    orderNo: json["order_no"],
    addressId: json["address_id"],
    userId: json["user_id"],
    restaurantId: json["restaurant_id"],
    status:   json["status"]  == null ? null :  datumStatusValues.map[json["status"]],
    paymentMethodId: json["payment_method_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    driverId: json["driver_id"],
    driverStatus: json["driver_status"]  == null ? null : driverStatusValues.map[json["driver_status"]],
    note: json["note"],
    restaurant: json["restaurant"] == null ? null : Restaurant.fromJson(json["restaurant"]),
    user: Map.from(json["user"]!).map((k, v) => MapEntry<String, String?>(k, v)),
    items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
    paymentHistories: json["payment_histories"] == null ? [] : List<PaymentHistory>.from(json["payment_histories"]!.map((x) => PaymentHistory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_no": orderNo,
    "address_id": addressId,
    "user_id": userId,
    "restaurant_id": restaurantId,
    "status": datumStatusValues.reverse[status],
    "payment_method_id": paymentMethodId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "driver_id": driverId,
    "driver_status": driverStatusValues.reverse[driverStatus],
    "note": note,
    "restaurant": restaurant?.toJson(),
    "user": Map.from(user!).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
    "payment_histories": paymentHistories == null ? [] : List<dynamic>.from(paymentHistories!.map((x) => x.toJson())),
  };
}

enum DriverStatus {
  ACCEPTED,
  WAITING
}

final driverStatusValues = EnumValues({
  "accepted": DriverStatus.ACCEPTED,
  "waiting": DriverStatus.WAITING
});

class Item {
  int? id;
  int? restaurantId;
  int? categoryId;
  int? subCategoryId;
  String? name;
  String? image;
  ItemArName? arName;
  String? description;
  String? arDescription;
  double? price;
  int? discount;
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
    restaurantId: json["restaurant_id"],
    categoryId: json["category_id"],
    subCategoryId: json["sub_category_id"],
    name: json["name"],
    image: json["image"],
    arName: itemArNameValues.map[json["ar_name"]]!,
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
    "ar_name": itemArNameValues.reverse[arName],
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

enum ItemArName {
  CELINE_ROMAGUERA_MD,
  EMPTY,
  NULL,
  THE_1
}

final itemArNameValues = EnumValues({
  "Celine Romaguera MD": ItemArName.CELINE_ROMAGUERA_MD,
  "جوسي لوسي": ItemArName.EMPTY,
  "null": ItemArName.NULL,
  "اسم المنتج العيني 1": ItemArName.THE_1
});

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
    "payment_method": paymentMethod?.toJson(),
  };
}

class PaymentMethod {
  int? id;
  PaymentMethodName? name;
  NameAr? nameAr;
  PaymentMethodStatus? status;
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
    id:   json["id"]  == null ? null :  json["id"],
    name:  json["name"]  == null ? null :  paymentMethodNameValues.map[json["name"]],
    nameAr:   json["name_ar"] == null ? null : nameArValues.map[json["name_ar"]],
    status:  json["status"]  == null ? null :  paymentMethodStatusValues.map[json["status"]],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": paymentMethodNameValues.reverse[name],
    "name_ar": nameArValues.reverse[nameAr],
    "status": paymentMethodStatusValues.reverse[status],
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

enum PaymentMethodName {
  CASH,
  WALLET
}

final paymentMethodNameValues = EnumValues({
  "Cash": PaymentMethodName.CASH,
  "Wallet": PaymentMethodName.WALLET
});

enum NameAr {
  EMPTY,
  NAME_AR
}

final nameArValues = EnumValues({
  "مال يدفع نقدا": NameAr.EMPTY,
  "محفظة": NameAr.NAME_AR
});

enum PaymentMethodStatus {
  ACTIVE
}

final paymentMethodStatusValues = EnumValues({
  "active": PaymentMethodStatus.ACTIVE
});

class Restaurant {
  int? id;
  RestaurantName? name;
  RestaurantArName? arName;
  String? address;
  String? phoneNumber;
  Email? email;
  CoverPhoto? logo;
  CoverPhoto? coverPhoto;
  String? description;
  String? arDescription;
  OpeningHours? openingHours;
  int? deliveryRange;
  int? minimumOrderValue;
  int? maximumOrderValue;
  Location? location;
  bool? cashOnDelivery;
  bool? isActive;
  RestaurantStatus? status;
  String? createdBy;
  String? updatedBy;
  dynamic deletedBy;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  DeliveryTime? deliveryTime;
  DeliveryCharges? deliveryCharges;
  String? tax;
  int? averageRating;
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
    name: restaurantNameValues.map[json["name"]]!,
    arName: restaurantArNameValues.map[json["ar_name"]]!,
    address: json["address"],
    phoneNumber: json["phone_number"],
    email: emailValues.map[json["email"]]!,
    logo: coverPhotoValues.map[json["logo"]]!,
    coverPhoto: coverPhotoValues.map[json["cover_photo"]]!,
    description: json["description"],
    arDescription: json["ar_description"],
    openingHours: json["opening_hours"] == null ? null : OpeningHours.fromJson(json["opening_hours"]),
    deliveryRange: json["delivery_range"],
    minimumOrderValue: json["minimum_order_value"],
    maximumOrderValue: json["maximum_order_value"],
    location: json["location"] == null ? null : Location.fromJson(json["location"]),
    cashOnDelivery: json["cash_on_delivery"],
    isActive: json["is_active"],
    status: restaurantStatusValues.map[json["status"]]!,
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    deletedBy: json["deleted_by"],
    deletedAt: json["deleted_at"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deliveryTime: deliveryTimeValues.map[json["delivery_time"]]!,
    deliveryCharges: json["delivery_charges"] == null ? null : DeliveryCharges.fromJson(json["delivery_charges"]),
    tax: json["tax"],
    averageRating: json["average_rating"],
    totalRatings: json["total_ratings"],
    logoUrl: json["logo_url"],
    coverPhotoUrl: json["cover_photo_url"],
    assignedManager: json["assigned_manager"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": restaurantNameValues.reverse[name],
    "ar_name": restaurantArNameValues.reverse[arName],
    "address": address,
    "phone_number": phoneNumber,
    "email": emailValues.reverse[email],
    "logo": coverPhotoValues.reverse[logo],
    "cover_photo": coverPhotoValues.reverse[coverPhoto],
    "description": description,
    "ar_description": arDescription,
    "opening_hours": openingHours?.toJson(),
    "delivery_range": deliveryRange,
    "minimum_order_value": minimumOrderValue,
    "maximum_order_value": maximumOrderValue,
    "location": location?.toJson(),
    "cash_on_delivery": cashOnDelivery,
    "is_active": isActive,
    "status": restaurantStatusValues.reverse[status],
    "created_by": createdBy,
    "updated_by": updatedBy,
    "deleted_by": deletedBy,
    "deleted_at": deletedAt,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "delivery_time": deliveryTimeValues.reverse[deliveryTime],
    "delivery_charges": deliveryCharges?.toJson(),
    "tax": tax,
    "average_rating": averageRating,
    "total_ratings": totalRatings,
    "logo_url": logoUrl,
    "cover_photo_url": coverPhotoUrl,
    "assigned_manager": assignedManager,
  };
}

enum RestaurantArName {
  EMPTY,
  THE_1,
  THE_2
}

final restaurantArNameValues = EnumValues({
  "مطعم بوندو خان": RestaurantArName.EMPTY,
  "مطعم 1": RestaurantArName.THE_1,
  "مطعم 2": RestaurantArName.THE_2
});

enum CoverPhoto {
  THE_1698320255_JPG,
  THE_1699013616_JPG,
  THE_1699260227_JPG
}

final coverPhotoValues = EnumValues({
  "1698320255.jpg": CoverPhoto.THE_1698320255_JPG,
  "1699013616.jpg": CoverPhoto.THE_1699013616_JPG,
  "1699260227.jpg": CoverPhoto.THE_1699260227_JPG
});

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

enum DeliveryTime {
  THE_45_MINUTES
}

final deliveryTimeValues = EnumValues({
  "45 minutes": DeliveryTime.THE_45_MINUTES
});

enum Email {
  ADMIN_ADMIN_COM,
  AZAMANSARI4747_GMAIL_COM,
  RESTAURANT_DOWIDAR_COM
}

final emailValues = EnumValues({
  "admin@admin.com": Email.ADMIN_ADMIN_COM,
  "azamansari4747@gmail.com": Email.AZAMANSARI4747_GMAIL_COM,
  "restaurant@dowidar.com": Email.RESTAURANT_DOWIDAR_COM
});

class Location {
  double? lat;
  double? lng;

  Location({
    this.lat,
    this.lng,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    lat: json["lat"]?.toDouble(),
    lng: json["lng"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lng": lng,
  };
}

enum RestaurantName {
  BUNDU_KHAN_RESTAURANT,
  RESTAURANT_1,
  RESTURANT
}

final restaurantNameValues = EnumValues({
  "Bundu Khan Restaurant": RestaurantName.BUNDU_KHAN_RESTAURANT,
  "Restaurant 1": RestaurantName.RESTAURANT_1,
  "Resturant": RestaurantName.RESTURANT
});

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
  From? from;
  To? to;

  Day({
    this.from,
    this.to,
  });

  factory Day.fromJson(Map<String, dynamic> json) => Day(
    from: fromValues.map[json["from"]]!,
    to: toValues.map[json["to"]]!,
  );

  Map<String, dynamic> toJson() => {
    "from": fromValues.reverse[from],
    "to": toValues.reverse[to],
  };
}

enum From {
  THE_1000,
  THE_206,
  THE_208,
  THE_226
}

final fromValues = EnumValues({
  "10:00": From.THE_1000,
  "20:6": From.THE_206,
  "20:8": From.THE_208,
  "22:6": From.THE_226
});

enum To {
  THE_206,
  THE_2200
}

final toValues = EnumValues({
  "20:6": To.THE_206,
  "22:00": To.THE_2200
});

enum RestaurantStatus {
  BUSY,
  OPENED
}

final restaurantStatusValues = EnumValues({
  "busy": RestaurantStatus.BUSY,
  "opened": RestaurantStatus.OPENED
});

enum DatumStatus {
  CANCELLED,
  PENDING,
  PROCESSING
}

final datumStatusValues = EnumValues({
  "cancelled": DatumStatus.CANCELLED,
  "pending": DatumStatus.PENDING,
  "processing": DatumStatus.PROCESSING
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
