class OrderDetailOb {
  OrderDetailOb({
      this.success, 
      this.message, 
      this.data,});

  OrderDetailOb.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? OrderDetailData.fromJson(json['data']) : null;
  }
  bool? success;
  String? message;
  OrderDetailData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}
class OrderDetailData {
  OrderDetailData({
    this.items,
    this.address,
    this.subTotal,
    this.grandTotal,
    this.haveAddress,});

  OrderDetailData.fromJson(dynamic json) {
    items = json['items'] != null ? Items.fromJson(json['items']) : null;
    address = json['address'] != null ? Address.fromJson(json['address']) : null;
    subTotal = json['subTotal'];
    grandTotal = json['grandTotal'];
    haveAddress = json['haveAddress'];
  }
  Items? items;
  Address? address;
  String? subTotal;
  String? grandTotal;
  bool? haveAddress;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (items != null) {
      map['items'] = items?.toJson();
    }
    if (address != null) {
      map['address'] = address?.toJson();
    }
    map['subTotal'] = subTotal;
    map['grandTotal'] = grandTotal;
    map['haveAddress'] = haveAddress;
    return map;
  }
}

class Address {
  Address({
    this.region,
    this.regionId,
    this.township,
    this.townshipId,
    this.addressLine,
    this.phone,
    this.receiverName,
    this.isHome,
    this.deliveryFee,});

  Address.fromJson(dynamic json) {
    region = json['region'];
    regionId = json['regionId'];
    township = json['township'];
    townshipId = json['townshipId'];
    addressLine = json['addressLine'];
    phone = json['phone'];
    receiverName = json['receiverName'];
    isHome = json['isHome'];
    deliveryFee = json['deliveryFee'];
  }
  String? region;
  int? regionId;
  String? township;
  int? townshipId;
  String? addressLine;
  String? phone;
  String? receiverName;
  bool? isHome;
  int? deliveryFee;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['region'] = region;
    map['regionId'] = regionId;
    map['township'] = township;
    map['townshipId'] = townshipId;
    map['addressLine'] = addressLine;
    map['phone'] = phone;
    map['receiverName'] = receiverName;
    map['isHome'] = isHome;
    map['deliveryFee'] = deliveryFee;
    return map;
  }

}
class Items {
  Items({
    this.id,
    this.orderId,
    this.status,
    this.address,
    this.townshiopId,
    this.deliveryFees,
    this.products,});

  Items.fromJson(dynamic json) {
    id = json['id'];
    orderId = json['order_id'];
    status = json['status'];
    address = json['address'];
    townshiopId = json['townshiop_id'];
    deliveryFees = json['delivery_fees'];
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products?.add(Products.fromJson(v));
      });
    }
  }
  int? id;
  String? orderId;
  String? status;
  String? address;
  String? townshiopId;
  int? deliveryFees;
  List<Products>? products;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['order_id'] = orderId;
    map['status'] = status;
    map['address'] = address;
    map['townshiop_id'] = townshiopId;
    map['delivery_fees'] = deliveryFees;
    if (products != null) {
      map['products'] = products?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}
class Products {
  Products({
    this.id,
    this.name,
    this.price,
    this.discount,
    this.discountPrice,
    this.quantity,
    this.photo,
    this.categoryName,
    this.brandName,});

  Products.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    discount = json['discount'];
    discountPrice = json['discountPrice'];
    quantity = json['quantity'];
    photo = json['photo'];
    categoryName = json['category_name'];
    brandName = json['brand_name'];
  }
  int? id;
  String? name;
  String? price;
  String? discount;
  String? discountPrice;
  int? quantity;
  String? photo;
  String? categoryName;
  String? brandName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['price'] = price;
    map['discount'] = discount;
    map['discountPrice'] = discountPrice;
    map['quantity'] = quantity;
    map['photo'] = photo;
    map['category_name'] = categoryName;
    map['brand_name'] = brandName;
    return map;
  }

}