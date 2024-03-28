// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_to_cart_response_object.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddToCartResponseObject _$AddToCartResponseObjectFromJson(
        Map<String, dynamic> json) =>
    AddToCartResponseObject(
      success: json['success'] as bool,
      message: json['message'] as String,
    );

Map<String, dynamic> _$AddToCartResponseObjectToJson(
        AddToCartResponseObject instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
    };
