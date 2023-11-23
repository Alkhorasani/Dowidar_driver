// To parse this JSON data, do
//
//     final ModOrderDetails = ModOrderDetailsFromJson(jsonString);

import '../ModGetAllOrders/ModGetAllOrders.dart';

class ModOrderDetails {
  Data? data;

  ModOrderDetails({
    this.data,
  });

  factory ModOrderDetails.fromJson(Map<String, dynamic> json) => ModOrderDetails(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class Data {
  OrderDetail? order;
  Statuses? statuses;

  Data({
    this.order,
    this.statuses,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    order: json["order"] == null ? null : OrderDetail.fromJson(json["order"]),
    statuses: json["statuses"] == null ? null : Statuses.fromJson(json["statuses"]),
  );

  Map<String, dynamic> toJson() => {
    "order": order?.toJson(),
    "statuses": statuses?.toJson(),
  };
}

class OrderDetail {
  int? id;
  String? orderNo;
  int? addressId;
  String? userId;
  int? restaurantId;
  String? status;
  String? paymentMethodId;
  String? createdAt;
  String? updatedAt;
  Statuses? statuses;
  Restaurant? restaurant;
  UserDriver? user;
  UserDriver? driver;
  List<Item>? items;
  Address? address;
  List<PaymentHistory>? paymentHistories;

  OrderDetail({
    this.id,
    this.orderNo,
    this.addressId,
    this.userId,
    this.restaurantId,
    this.status,
    this.paymentHistories,
    this.paymentMethodId,
    this.createdAt,
    this.updatedAt,
    this.statuses,
    this.restaurant,
    this.items,
    this.address,
    this.user,
    this.driver,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
    id: json["id"],
    orderNo: json["order_no"],
    addressId: json["address_id"],
    userId: json["user_id"],
    restaurantId: json["restaurant_id"],
    status: json["status"],
    paymentMethodId: json["payment_method_id"].toString(),
    paymentHistories: json["payment_histories"] == null ? [] : List<PaymentHistory>.from(json["payment_histories"]!.map((x) => PaymentHistory.fromJson(x))),
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    statuses: json["statuses"] == null ? null : Statuses.fromJson(json["statuses"]),
    user: json["user"] == null ? null : UserDriver.fromJson(json["user"]),
    driver: json["driver"] == null ? null : UserDriver.fromJson(json["driver"]),
    restaurant: json["restaurant"] == null ? null : Restaurant.fromJson(json["restaurant"]),
    items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
    address: json["address"] == null ? null : Address.fromJson(json["address"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_no": orderNo,
    "address_id": addressId,
    "user_id": userId,
    "restaurant_id": restaurantId,
    "status": status,
    "payment_method_id": paymentMethodId,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "statuses": statuses?.toJson(),
    "user": user?.toJson(),
    "driver": driver?.toJson(),
    "payment_histories": paymentHistories == null ? [] : List<dynamic>.from(paymentHistories!.map((x) => x.toJson())),
    "restaurant": restaurant?.toJson(),
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
    "address": address?.toJson(),
  };

  paymentType(List<PaymentHistory>? paymentHistories){
    if(paymentHistories != null && paymentHistories.isNotEmpty){
      if(paymentHistories.length > 1){
        return "${paymentHistories.first.paymentMethod?.name ?? 'Cash'}/${paymentHistories.last.paymentMethod?.name ?? 'Cash'}";
      }else{
        return paymentHistories.first.paymentMethod?.name ?? 'Cash';
      }
    }
  }


  getTotalPayment(List<PaymentHistory>? paymentHistories){
    if(paymentHistories != null && paymentHistories.isNotEmpty){
      if(paymentHistories.length > 1){
        return "${double.parse(paymentHistories.first.amount ?? '0.0') + double.parse(paymentHistories.last.amount ?? '0.0')}";
      }else{
        return paymentHistories.first.amount ?? '0';
      }
    }
  }
}



class UserDriver {
  String? id;
  String? firstname;
  String? lastname;
  String? email;
  String? emailVerifiedAt;
  String? phone;
  String? phoneVerifiedAt;
  String? status;
  String? avatar;
  dynamic deletedAt;
  String? createdAt;
  String? updatedAt;
  String? roleId;
  String? createdBy;
  String? updatedBy;
  dynamic deletedBy;
  String? device;
  String? deviceId;
  dynamic latitude;
  dynamic longitude;
  String? fullName;
  String? avatarUrl;

  UserDriver({
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

  factory UserDriver.fromJson(Map<String, dynamic> json) => UserDriver(
    id: json["id"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    phone: json["phone"],
    phoneVerifiedAt: json["phone_verified_at"],
    status: json["status"],
    avatar: json["avatar"],
    deletedAt: json["deleted_at"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
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
    "email_verified_at": emailVerifiedAt,
    "phone": phone,
    "phone_verified_at": phoneVerifiedAt,
    "status": status,
    "avatar": avatar,
    "deleted_at": deletedAt,
    "created_at": createdAt,
    "updated_at": updatedAt,
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

class Address {
  int? id;
  String? title;
  String? addressLine1;
  dynamic addressLine2;
  String? location;

  Address({
    this.id,
    this.title,
    this.addressLine1,
    this.addressLine2,
    this.location,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    id: json["id"],
    title: json["title"],
    addressLine1: json["address_line_1"],
    addressLine2: json["address_line_2"],
    location: json["location"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "address_line_1": addressLine1,
    "address_line_2": addressLine2,
    "location": location,
  };
}

class Item {
  int? id;
  int? restaurantId;
  dynamic categoryId;
  int? subCategoryId;
  String? name;
  String? image;
  String? arName;
  String? description;
  String? arDescription;
  String? price;
  String? discount;
  bool? isAvailable;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<VariationGroup>? variationGroups;
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
    this.variationGroups,
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
    arName: json["ar_name"],
    description: json["description"],
    arDescription: json["ar_description"],
    price: json["price"].toString(),
    discount: json["discount"].toString(),
    isAvailable: json["is_available"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    variationGroups: json["variation_groups"] == null ? [] : List<VariationGroup>.from(json["variation_groups"]!.map((x) => VariationGroup.fromJson(x))),
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
    "variation_groups": variationGroups == null ? [] : List<dynamic>.from(variationGroups!.map((x) => x.toJson())),
    "image_url": imageUrl,
    "pivot": pivot?.toJson(),
  };
}
class Variation {
  int? id;
  int? variationGroupId;
  String? name;
  String? image;
  String? arName;
  String? description;
  String? arDescription;
  double? price;
  dynamic discount;
  bool? isAvailable;
  String? createdAt;
  String? updatedAt;
  String? imageUrl;

  Variation({
    this.id,
    this.variationGroupId,
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
  });

  factory Variation.fromJson(Map<String, dynamic> json) => Variation(
    id: json["id"],
    variationGroupId: json["variation_group_id"],
    name: json["name"],
    image: json["image"],
    arName: json["ar_name"],
    description: json["description"],
    arDescription: json["ar_description"],
    price: json["price"]?.toDouble(),
    discount: json["discount"],
    isAvailable: json["is_available"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    imageUrl: json["image_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "variation_group_id": variationGroupId,
    "name": name,
    "image": image,
    "ar_name": arName,
    "description": description,
    "ar_description": arDescription,
    "price": price,
    "discount": discount,
    "is_available": isAvailable,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "image_url": imageUrl,
  };
}

class VariationGroup {
  int? id;
  int? itemId;
  String? name;
  String? arName;
  String? description;
  String? arDescription;
  int? isMandatory;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Variation>? variations;

  VariationGroup({
    this.id,
    this.itemId,
    this.name,
    this.arName,
    this.description,
    this.arDescription,
    this.isMandatory,
    this.createdAt,
    this.updatedAt,
    this.variations,
  });

  factory VariationGroup.fromJson(Map<String, dynamic> json) => VariationGroup(
    id: json["id"],
    itemId: json["item_id"],
    name: json["name"],
    arName: json["ar_name"],
    description: json["description"],
    arDescription: json["ar_description"],
    isMandatory: json["is_mandatory"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
      variations: json["variations"] == null ? [] : List<Variation>.from(json["variations"]!.map((x) => Variation.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "item_id": itemId,
    "name": name,
    "ar_name": arName,
    "description": description,
    "ar_description": arDescription,
    "is_mandatory": isMandatory,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "variations": variations == null ? [] : List<VariationGroup>.from(variations!.map((x) => x.toJson())),
  };
}



class Pivot {
  int? orderId;
  int? itemId;
  int? quantity;
  double? unitPrice;

  Pivot({
    this.orderId,
    this.itemId,
    this.quantity,
    this.unitPrice,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
    orderId: json["order_id"],
    itemId: json["item_id"],
    quantity: json["quantity"],
    unitPrice: json["unit_price"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "order_id": orderId,
    "item_id": itemId,
    "quantity": quantity,
    "unit_price": unitPrice,
  };
}


class Statuses {
  String? pending;
  String? confirmed;
  String? processing;
  String? enroute;
  String? delivered;
  String? cancelled;

  Statuses({
    this.pending,
    this.confirmed,
    this.processing,
    this.enroute,
    this.delivered,
    this.cancelled,
  });

  factory Statuses.fromJson(Map<String, dynamic> json) => Statuses(
    pending: json["pending"],
    confirmed: json["confirmed"],
    processing: json["processing"],
    enroute: json["enroute"],
    delivered: json["delivered"],
    cancelled: json["cancelled"],
  );

  Map<String, dynamic> toJson() => {
    "pending": pending,
    "confirmed": confirmed,
    "processing": processing,
    "enroute": enroute,
    "delivered": delivered,
    "cancelled": cancelled,
  };
}
