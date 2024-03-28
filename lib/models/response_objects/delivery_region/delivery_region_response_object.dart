import 'package:json_annotation/json_annotation.dart';

part 'delivery_region_response_object.g.dart';

@JsonSerializable()
class DeliveryRegionResponseObject {
  final bool success;
  final String message;
  final List<Regions> data;

  DeliveryRegionResponseObject({
    required this.success,
    required this.message,
    required this.data,
  });

  factory DeliveryRegionResponseObject.fromJson(Map<String, dynamic> json) => _$DeliveryRegionResponseObjectFromJson(json);
  Map<String, dynamic> toJson() => _$DeliveryRegionResponseObjectToJson(this);
}

@JsonSerializable()
class Regions {
  final int id;
  final String name;

  Regions({
    required this.id,
    required this.name,
  });

  factory Regions.fromJson(Map<String, dynamic> json) => _$RegionsFromJson(json);
  Map<String, dynamic> toJson() => _$RegionsToJson(this);
}
