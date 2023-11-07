

class ModGetAllOrders {
  String message;
  Data data;

  ModGetAllOrders({
    required this.message,
    required this.data,
  });

  factory ModGetAllOrders.fromJson(Map<String, dynamic> json) => ModGetAllOrders(
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  int currentPage;
  List<Datum> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  List<Link> links;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  Data({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    currentPage: json["current_page"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links": List<dynamic>.from(links.map((x) => x.toJson())),
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
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
  dynamic? note;
  Restaurant? restaurant;
  Map<String, String?>? user;
  List<Item>? items;

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
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    orderNo: json["order_no"],
    addressId: json["address_id"],
    userId: json["user_id"],
    restaurantId: json["restaurant_id"],
    status: json["status"] != null ? datumStatusValues.map[json["status"]] : null,
    paymentMethodId: json["payment_method_id"],
    createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : null,
    updatedAt: json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : null,
    driverId: json["driver_id"],
    driverStatus: json["driver_status"] != null ? driverStatusValues.map[json["driver_status"]] : null,
    note: json["note"],
    restaurant: json["restaurant"] != null ? Restaurant.fromJson(json["restaurant"]) : null,
    user: json["user"] != null ? Map.from(json["user"]).map((k, v) => MapEntry<String, String?>(k, v)) : null,
    items: json["items"] != null ? List<Item>.from(json["items"].map((x) => Item.fromJson(x))) : null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_no": orderNo,
    "address_id": addressId,
    "user_id": userId,
    "restaurant_id": restaurantId,
    "status": status != null ? datumStatusValues.reverse[status] : null,
    "payment_method_id": paymentMethodId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "driver_id": driverId,
    "driver_status": driverStatus != null ? driverStatusValues.reverse[driverStatus] : null,
    "note": note,
    "restaurant": restaurant?.toJson(),
    "user": user != null ? Map.from(user!).map((k, v) => MapEntry<String, dynamic>(k, v)) : null,
    "items": items != null ? List<dynamic>.from(items!.map((x) => x.toJson())) : null,
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
  ItemName? name;
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
    name: json["name"] != null ? itemNameValues.map[json["name"]] : null,
    image: json["image"],
    arName: json["ar_name"] != null ? itemArNameValues.map[json["ar_name"]] : null,
    description: json["description"],
    arDescription: json["ar_description"],
    price: json["price"]?.toDouble(),
    discount: json["discount"],
    isAvailable: json["is_available"],
    createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : null,
    updatedAt: json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : null,
    imageUrl: json["image_url"],
    pivot: json["pivot"] != null ? Pivot.fromJson(json["pivot"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "restaurant_id": restaurantId,
    "category_id": categoryId,
    "sub_category_id": subCategoryId,
    "name": name != null ? itemNameValues.reverse[name!] : null,
    "image": image,
    "ar_name": arName != null ? itemArNameValues.reverse[arName!] : null,
    "description": description,
    "ar_description": arDescription,
    "price": price,
    "discount": discount,
    "is_available": isAvailable,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "image_url": imageUrl,
    "pivot": pivot != null ? pivot!.toJson() : null,
  };
}

enum ItemArName {
  CELINE_ROMAGUERA_MD,
  EMPTY,
  THE_1
}

final itemArNameValues = EnumValues({
  "Celine Romaguera MD": ItemArName.CELINE_ROMAGUERA_MD,
  "جوسي لوسي": ItemArName.EMPTY,
  "اسم المنتج العيني 1": ItemArName.THE_1
});

enum ItemName {
  CHANDLER_STANTON,
  JUCY_LUCY1234,
  KATLYNN_HARVEY,
  SAMPLE_PRODUCT_1
}

final itemNameValues = EnumValues({
  "Chandler Stanton": ItemName.CHANDLER_STANTON,
  "Jucy Lucy1234": ItemName.JUCY_LUCY1234,
  "Katlynn Harvey": ItemName.KATLYNN_HARVEY,
  "Sample Product 1": ItemName.SAMPLE_PRODUCT_1
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

class Restaurant {
  int? id;
  RestaurantName? name;
  RestaurantArName? arName;
  Address? address;
  String? phoneNumber;
  Email? email;
  CoverPhoto? logo;
  CoverPhoto? coverPhoto;
  Description? description;
  ArDescription? arDescription;
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
  dynamic? deletedBy;
  dynamic? deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? deliveryTime;
  int? deliveryCharges;
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
    name: restaurantNameValues.map[json["name"]],
    arName: restaurantArNameValues.map[json["ar_name"]],
    address: addressValues.map[json["address"]],
    phoneNumber: json["phone_number"],
    email: emailValues.map[json["email"]],
    logo: coverPhotoValues.map[json["logo"]],
    coverPhoto: coverPhotoValues.map[json["cover_photo"]],
    description: descriptionValues.map[json["description"]],
    arDescription: arDescriptionValues.map[json["ar_description"]],
    openingHours: json["opening_hours"] != null
        ? OpeningHours.fromJson(json["opening_hours"])
        : null,
    deliveryRange: json["delivery_range"],
    minimumOrderValue: json["minimum_order_value"],
    maximumOrderValue: json["maximum_order_value"],
    location: Location.fromJson(json["location"]),
    cashOnDelivery: json["cash_on_delivery"],
    isActive: json["is_active"],
    status: restaurantStatusValues.map[json["status"]],
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    deletedBy: json["deleted_by"],
    deletedAt: json["deleted_at"],
    createdAt: json["created_at"] != null
        ? DateTime.parse(json["created_at"])
        : null,
    updatedAt: json["updated_at"] != null
        ? DateTime.parse(json["updated_at"])
        : null,
    deliveryTime: json["delivery_time"],
    deliveryCharges: json["delivery_charges"],
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
    "address": addressValues.reverse[address],
    "phone_number": phoneNumber,
    "email": emailValues.reverse[email],
    "logo": coverPhotoValues.reverse[logo],
    "cover_photo": coverPhotoValues.reverse[coverPhoto],
    "description": descriptionValues.reverse[description],
    "ar_description": arDescriptionValues.reverse[arDescription],
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
    "delivery_time": deliveryTime,
    "delivery_charges": deliveryCharges,
    "tax": tax,
    "average_rating": averageRating,
    "total_ratings": totalRatings,
    "logo_url": logoUrl,
    "cover_photo_url": coverPhotoUrl,
    "assigned_manager": assignedManager,
  };

}
enum Address {
  RESTAURANT_1_ADDRESS
}

final addressValues = EnumValues({
  "Restaurant 1 address": Address.RESTAURANT_1_ADDRESS
});

enum ArDescription {
  THE_1
}

final arDescriptionValues = EnumValues({
  "وصف مطعم 1": ArDescription.THE_1
});

enum RestaurantArName {
  THE_1
}

final restaurantArNameValues = EnumValues({
  "مطعم 1": RestaurantArName.THE_1
});

enum CoverPhoto {
  THE_1698320255_JPG
}

final coverPhotoValues = EnumValues({
  "1698320255.jpg": CoverPhoto.THE_1698320255_JPG
});

enum Description {
  RESTAURANT_1_DESCRIPTION
}

final descriptionValues = EnumValues({
  "Restaurant 1 description": Description.RESTAURANT_1_DESCRIPTION
});

enum Email {
  RESTAURANT_DOWIDAR_COM
}

final emailValues = EnumValues({
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
  RESTAURANT_1
}

final restaurantNameValues = EnumValues({
  "Restaurant 1": RestaurantName.RESTAURANT_1
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
    monday: json["monday"] != null ? Day.fromJson(json["monday"]) : null,
    tuesday: json["tuesday"] != null ? Day.fromJson(json["tuesday"]) : null,
    wednesday: json["wednesday"] != null ? Day.fromJson(json["wednesday"]) : null,
    thursday: json["thursday"] != null ? Day.fromJson(json["thursday"]) : null,
    friday: json["friday"] != null ? Day.fromJson(json["friday"]) : null,
    saturday: json["saturday"] != null ? Day.fromJson(json["saturday"]) : null,
    sunday: json["sunday"] != null ? Day.fromJson(json["sunday"]) : null,
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
    from: json["from"] != null ? fromValues.map[json["from"]] : null,
    to: json["to"] != null ? toValues.map[json["to"]] : null,
  );

  Map<String, dynamic> toJson() => {
    "from": from != null ? fromValues.reverse[from!] : null,
    "to": to != null ? toValues.reverse[to!] : null,
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
  BUSY
}

final restaurantStatusValues = EnumValues({
  "busy": RestaurantStatus.BUSY
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

class Link {
  String? url;
  String label;
  bool active;

  Link({
    required this.url,
    required this.label,
    required this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
