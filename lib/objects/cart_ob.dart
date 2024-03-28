class CartOb {
  CartOb({
    this.success,
    this.message,
    this.data,
  });

  CartOb.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? CartData.fromJson(json['data']) : null;
  }

  bool? success;
  String? message;
  CartData? data;

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

class CartData {
  CartData({
    this.items,
    this.address,
    this.haveAddress,
    this.subTotal,
    this.grandTotal,
  });

  CartData.fromJson(dynamic json) {
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items?.add(Items.fromJson(v));
      });
    }
    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    haveAddress = json['haveAddress'];
    subTotal = json['subTotal'];
    grandTotal = json['grandTotal'];
  }

  List<Items>? items;
  Address? address;
  bool? haveAddress;
  String? subTotal;
  String? grandTotal;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (items != null) {
      map['items'] = items?.map((v) => v.toJson()).toList();
    }
    if (address != null) {
      map['address'] = address?.toJson();
    }
    map['haveAddress'] = haveAddress;
    map['subTotal'] = subTotal;
    map['grandTotal'] = grandTotal;
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
    this.deliveryFee,
  });

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
    this.cartId,
    this.productQuality,
    this.productId,
    this.productName,
    this.productPrice,
    this.totalSKUPrice,
    this.onHandStock,
    this.discountPrice,
    this.productDiscount,
    this.productImage,
    this.hearts,
    this.categoryName,
    this.brandName,
    this.productSubTotal,
    this.productCount = 1,
  });

  Items.fromJson(dynamic json) {
    cartId = json['cartId'];
    productQuality = json['productQuality'];
    productId = json['productId'];
    productName = json['productName'];
    productPrice = json['productPrice'];
    totalSKUPrice = json['totalSKUPrice'];
    onHandStock = json['onHandStock'];
    discountPrice = json['discountPrice'];
    productDiscount = json['productDiscount'];
    productImage = json['productImage'];
    hearts = json['hearts'];
    categoryName = json['categoryName'];
    brandName = json['brandName'];
    productSubTotal = json['productSubTotal'];
  }

  int? cartId;
  int? productQuality;
  int? productId;
  String? productName;
  String? productPrice;
  String? totalSKUPrice;
  int? onHandStock;
  int? discountPrice;
  int? productDiscount;
  String? productImage;
  int? hearts;
  String? categoryName;
  String? brandName;
  String? productSubTotal;
  int? productCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cartId'] = cartId;
    map['productQuality'] = productQuality;
    map['productId'] = productId;
    map['productName'] = productName;
    map['productPrice'] = productPrice;
    map['totalSKUPrice'] = totalSKUPrice;
    map['onHandStock'] = onHandStock;
    map['discountPrice'] = discountPrice;
    map['productDiscount'] = productDiscount;
    map['productImage'] = productImage;
    map['hearts'] = hearts;
    map['categoryName'] = categoryName;
    map['brandName'] = brandName;
    map['productSubTotal'] = productSubTotal;
    return map;
  }
}
