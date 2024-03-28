class ProductsOb {
  bool? success;
  String? message;
  List<Data>? data;

  ProductsOb({this.success, this.message, this.data});

  ProductsOb.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
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

  Data(
      {this.productCode,
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
      this.detail});

  Data.fromJson(Map<String, dynamic> json) {
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_code'] = productCode;
    data['id'] = id;
    data['name'] = name;
    data['stock'] = stock;
    data['price'] = price;
    data['discount'] = discount;
    data['discountPrice'] = discountPrice;
    data['photo'] = photo;
    data['category_id'] = categoryId;
    data['category_name'] = categoryName;
    data['brand_name'] = brandName;
    data['brand_id'] = brandId;
    data['is_favourite'] = isFavourite;
    data['description'] = description;
    data['detail'] = detail;
    return data;
  }
}
