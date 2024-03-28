// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_delivery_address_response_object.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateDeliveryAddressResponseObject
    _$UpdateDeliveryAddressResponseObjectFromJson(Map<String, dynamic> json) =>
        UpdateDeliveryAddressResponseObject(
          success: json['success'] as bool,
          message: json['message'] as String,
        );

Map<String, dynamic> _$UpdateDeliveryAddressResponseObjectToJson(
        UpdateDeliveryAddressResponseObject instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
    };
