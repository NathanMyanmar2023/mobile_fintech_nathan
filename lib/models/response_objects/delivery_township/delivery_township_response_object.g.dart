// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_township_response_object.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeliveryTownshipResponseObject _$DeliveryTownshipResponseObjectFromJson(
        Map<String, dynamic> json) =>
    DeliveryTownshipResponseObject(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => Townships.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DeliveryTownshipResponseObjectToJson(
        DeliveryTownshipResponseObject instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

Townships _$TownshipsFromJson(Map<String, dynamic> json) => Townships(
      id: json['id'] as int,
      name: json['name'] as String,
    );

Map<String, dynamic> _$TownshipsToJson(Townships instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
