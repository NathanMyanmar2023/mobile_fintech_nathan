import 'package:json_annotation/json_annotation.dart';

part 'add_to_cart_response_object.g.dart';

@JsonSerializable()
class AddToCartResponseObject {
  final bool success;
  final String message;

  AddToCartResponseObject({
    required this.success,
    required this.message,
  });

  factory AddToCartResponseObject.fromJson(Map<String, dynamic> json) => _$AddToCartResponseObjectFromJson(json);
  Map<String, dynamic> toJson() => _$AddToCartResponseObjectToJson(this);
}
