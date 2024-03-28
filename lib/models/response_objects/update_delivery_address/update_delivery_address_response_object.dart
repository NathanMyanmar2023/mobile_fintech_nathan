import 'package:json_annotation/json_annotation.dart';

part 'update_delivery_address_response_object.g.dart';

@JsonSerializable()
class UpdateDeliveryAddressResponseObject {
  final bool success;
  final String message;

  UpdateDeliveryAddressResponseObject({
    required this.success,
    required this.message,
  });

  factory UpdateDeliveryAddressResponseObject.fromJson(Map<String, dynamic> json) => _$UpdateDeliveryAddressResponseObjectFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateDeliveryAddressResponseObjectToJson(this);
}
