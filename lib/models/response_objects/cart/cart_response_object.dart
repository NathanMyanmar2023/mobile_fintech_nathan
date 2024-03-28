import 'package:json_annotation/json_annotation.dart';

part 'cart_response_object.g.dart';

@JsonSerializable()
class CartResponseObject {
  final bool success;
  final String message;
  final Data? data;

  CartResponseObject({
    required this.success,
    required this.message,
    required this.data,
  });

  factory CartResponseObject.fromJson(Map<String, dynamic> json) =>
      _$CartResponseObjectFromJson(json);
  Map<String, dynamic> toJson() => _$CartResponseObjectToJson(this);
}

@JsonSerializable()
class Data {
  final List<CartItems> items;
  final Address address; // Add the Address field
  final int subTotal;
  final int grandTotal;
  final bool haveAddress;

  Data({
    required this.items,
    required this.address,
    required this.subTotal,
    required this.grandTotal,
    required this.haveAddress,
  });
  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class CartItems {
  final int cartId;
  final int productQuality;
  final int productId;
  final String productName;
  final int productPrice;
  final int discountPrice;
  final int productDiscount;
  final String productImage;
  final int hearts;
  final String categoryName;
  final String brandName;
  final int productSubTotal;

  CartItems({
    required this.cartId,
    required this.productQuality,
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.discountPrice,
    required this.productDiscount,
    required this.productImage,
    required this.hearts,
    required this.categoryName,
    required this.brandName,
    required this.productSubTotal,
  });

  factory CartItems.fromJson(Map<String, dynamic> json) =>
      _$CartItemsFromJson(json);
  Map<String, dynamic> toJson() => _$CartItemsToJson(this);
}

@JsonSerializable()
class Address {
  final String region;
  final int regionId;
  final String township;
  final int townshipId;
  final String addressLine;
  final String phone;
  final String receiverName;
  final int isHome;
  final int deliveryFee;

  Address({
    required this.region,
    required this.regionId,
    required this.township,
    required this.townshipId,
    required this.addressLine,
    required this.phone,
    required this.receiverName,
    required this.isHome,
    required this.deliveryFee,
  });

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
