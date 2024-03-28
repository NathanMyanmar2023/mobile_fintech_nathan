// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_response_object.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartResponseObject _$CartResponseObjectFromJson(Map<String, dynamic> json) =>
    CartResponseObject(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CartResponseObjectToJson(CartResponseObject instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      items: (json['items'] as List<dynamic>)
          .map((e) => CartItems.fromJson(e as Map<String, dynamic>))
          .toList(),
      address: Address.fromJson(json['address'] as Map<String, dynamic>),
      subTotal: json['subTotal'] as int,
      grandTotal: json['grandTotal'] as int,
      haveAddress: json['haveAddress'] as bool,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'items': instance.items,
      'address': instance.address,
      'subTotal': instance.subTotal,
      'grandTotal': instance.grandTotal,
      'haveAddress': instance.haveAddress,
    };

CartItems _$CartItemsFromJson(Map<String, dynamic> json) => CartItems(
      cartId: json['cartId'] as int,
      productQuality: json['productQuality'] as int,
      productId: json['productId'] as int,
      productName: json['productName'] as String,
      productPrice: json['productPrice'] as int,
      discountPrice: json['discountPrice'] as int,
      productDiscount: json['productDiscount'] as int,
      productImage: json['productImage'] as String,
      hearts: json['hearts'] as int,
      categoryName: json['categoryName'] as String,
      brandName: json['brandName'] as String,
      productSubTotal: json['productSubTotal'] as int,
    );

Map<String, dynamic> _$CartItemsToJson(CartItems instance) => <String, dynamic>{
      'cartId': instance.cartId,
      'productQuality': instance.productQuality,
      'productId': instance.productId,
      'productName': instance.productName,
      'productPrice': instance.productPrice,
      'discountPrice': instance.discountPrice,
      'productDiscount': instance.productDiscount,
      'productImage': instance.productImage,
      'hearts': instance.hearts,
      'categoryName': instance.categoryName,
      'brandName': instance.brandName,
      'productSubTotal': instance.productSubTotal,
    };

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      region: json['region'] as String,
      regionId: json['regionId'] as int,
      township: json['township'] as String,
      townshipId: json['townshipId'] as int,
      addressLine: json['addressLine'] as String,
      phone: json['phone'] as String,
      receiverName: json['receiverName'] as String,
      isHome: json['isHome'] as int,
      deliveryFee: json['deliveryFee'] as int,
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'region': instance.region,
      'regionId': instance.regionId,
      'township': instance.township,
      'townshipId': instance.townshipId,
      'addressLine': instance.addressLine,
      'phone': instance.phone,
      'receiverName': instance.receiverName,
      'isHome': instance.isHome,
      'deliveryFee': instance.deliveryFee,
    };
