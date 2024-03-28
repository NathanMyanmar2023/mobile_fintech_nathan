class ShoppingOb {
  ShoppingOb({
    this.success,
    this.message,
    this.data,
  });

  ShoppingOb.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ShoppingData.fromJson(v));
      });
    }
  }

  bool? success;
  String? message;
  List<ShoppingData>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class ShoppingData {
  ShoppingData({
    this.productCode,
    this.id,
    this.name,
    this.stock,
    this.price,
    this.discount,
    this.discountPrice,
    this.photo,
    this.categoryId,
    this.categoryName,
    this.brandName,
    this.brandId,
    this.isFavourite,
    this.description,
    this.detail,
    this.count = 1,
  });

  ShoppingData.fromJson(dynamic json) {
    productCode = json['product_code'];
    id = json['id'];
    name = json['name'];
    stock = json['stock'];
    price = json['price'];
    discount = json['discount'];
    discountPrice = json['discountPrice'];
    photo = json['photo'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    brandName = json['brand_name'];
    brandId = json['brand_id'];
    isFavourite = json['is_favourite'];
    description = json['description'];
    detail = json['detail'];
  }

  String? productCode;
  int? id;
  String? name;
  int? stock;
  String? price;
  int? discount;
  String? discountPrice;
  String? photo;
  int? categoryId;
  String? categoryName;
  String? brandName;
  int? brandId;
  int? isFavourite;
  String? description;
  String? detail;
  int? count;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['product_code'] = productCode;
    map['id'] = id;
    map['name'] = name;
    map['stock'] = stock;
    map['price'] = price;
    map['discount'] = discount;
    map['discountPrice'] = discountPrice;
    map['photo'] = photo;
    map['category_id'] = categoryId;
    map['category_name'] = categoryName;
    map['brand_name'] = brandName;
    map['brand_id'] = brandId;
    map['is_favourite'] = isFavourite;
    map['description'] = description;
    map['detail'] = detail;
    return map;
  }
}
