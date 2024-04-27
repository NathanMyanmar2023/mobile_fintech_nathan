class ProductDetailOb {
  ProductDetailOb({
      this.success, 
      this.message, 
      this.data,});

  ProductDetailOb.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? ProductData.fromJson(json['data']) : null;
  }
  bool? success;
  String? message;
  ProductData? data;

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

class ProductData {
  ProductData({
      this.productCode, 
      this.id, 
      this.name,
    this.size,
      this.stock, 
      this.price, 
      this.discount, 
      this.discountPrice, 
      this.photo, 
      this.categoryId, 
      this.categoryName, 
      this.brandName, 
      this.brandId, 
      this.detail, 
      this.isFavourite, 
      this.photos,});

  ProductData.fromJson(dynamic json) {
    productCode = json['product_code'];
    id = json['id'];
    name = json['name'];
    size = json['size'];
    stock = json['stock'];
    price = json['price'];
    discount = json['discount'];
    discountPrice = json['discountPrice'];
    photo = json['photo'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    brandName = json['brand_name'];
    brandId = json['brand_id'];
    detail = json['detail'];
    isFavourite = json['is_favourite'];
    photos = json['photos'] != null ? json['photos'].cast<String>() : [];
  }
  String? productCode;
  int? id;
  String? name;
  String? size;
  int? stock;
  String? price;
  dynamic discount;
  String? discountPrice;
  String? photo;
  int? categoryId;
  String? categoryName;
  String? brandName;
  int? brandId;
  String? detail;
  int? isFavourite;
  List<String>? photos;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['product_code'] = productCode;
    map['id'] = id;
    map['name'] = name;
    map['size'] = size;
    map['stock'] = stock;
    map['price'] = price;
    map['discount'] = discount;
    map['discountPrice'] = discountPrice;
    map['photo'] = photo;
    map['category_id'] = categoryId;
    map['category_name'] = categoryName;
    map['brand_name'] = brandName;
    map['brand_id'] = brandId;
    map['detail'] = detail;
    map['is_favourite'] = isFavourite;
    map['photos'] = photos;
    return map;
  }

}