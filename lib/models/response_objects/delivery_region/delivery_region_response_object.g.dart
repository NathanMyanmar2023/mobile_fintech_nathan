// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_region_response_object.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeliveryRegionResponseObject _$DeliveryRegionResponseObjectFromJson(
        Map<String, dynamic> json) =>
    DeliveryRegionResponseObject(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => Regions.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DeliveryRegionResponseObjectToJson(
        DeliveryRegionResponseObject instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

Regions _$RegionsFromJson(Map<String, dynamic> json) => Regions(
      id: json['id'] as int,
      name: json['name'] as String,
    );

Map<String, dynamic> _$RegionsToJson(Regions instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
