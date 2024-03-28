import 'package:json_annotation/json_annotation.dart';

part 'delivery_township_response_object.g.dart';

@JsonSerializable()
class DeliveryTownshipResponseObject {
  final bool success;
  final String message;
  final List<Townships> data;

  DeliveryTownshipResponseObject({
    required this.success,
    required this.message,
    required this.data,
  });

  factory DeliveryTownshipResponseObject.fromJson(Map<String, dynamic> json) => _$DeliveryTownshipResponseObjectFromJson(json);
  Map<String, dynamic> toJson() => _$DeliveryTownshipResponseObjectToJson(this);
}

@JsonSerializable()
class Townships {
  final int id;
  final String name;

  Townships({
    required this.id,
    required this.name,
  });

  factory Townships.fromJson(Map<String, dynamic> json) => _$TownshipsFromJson(json);
  Map<String, dynamic> toJson() => _$TownshipsToJson(this);
}
